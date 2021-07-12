// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-auth.sol -- Non-standard token adapters

// Copyright (C) 2018 Rain <rainbreak@riseup.net>
// Copyright (C) 2018-2020 Maker Ecosystem Growth Holdings, INC.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity >=0.5.12;

interface VatLike {
    function slip(bytes32, address, int256) external;
}

interface GemLike {
    function decimals() external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

// For a token that needs join/exit to be managed (like in permissioned vaults)

contract ManagedGemJoin {
    VatLike public vat;
    bytes32 public ilk;
    GemLike public gem;
    uint256 public dec;
    uint256 public live;  // Access Flag

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) public auth { wards[usr] = 1; }
    function deny(address usr) public auth { wards[usr] = 0; }
    modifier auth { require(wards[msg.sender] == 1, "ManagedGemJoin/non-authed"); _; }

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        dec = gem.decimals();
    }

    function cage() external auth {
        live = 0;
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "ManagedGemJoin/overflow");
    }

    function join(address urn, uint256 amt) public auth {
        require(live == 1, "ManagedGemJoin/not-live");
        uint256 wad = mul(amt, 10 ** (18 - dec));
        require(int256(wad) >= 0, "ManagedGemJoin/overflow");
        vat.slip(ilk, urn, int256(wad));
        require(gem.transferFrom(msg.sender, address(this), amt), "ManagedGemJoin/failed-transfer");
    }

    function exit(address urn, address usr, uint256 amt) public auth {
        uint256 wad = mul(amt, 10 ** (18 - dec));
        require(int256(wad) >= 0, "ManagedGemJoin/overflow");
        vat.slip(ilk, urn, -int256(wad));
        require(gem.transfer(usr, amt), "ManagedGemJoin/failed-transfer");
    }
}
