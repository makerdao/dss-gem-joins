// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-3.sol -- Non-standard token adapters

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

import "./deps.sol";

// For a token that has a lower precision than 18 and doesn't have decimals field in place (like DGD)

contract GemJoin3 is LibNote {
    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }
    modifier auth { require(wards[msg.sender] == 1); _; }

    VatLike public vat;
    bytes32 public ilk;
    GemLike public gem;
    uint256 public dec;
    uint256 public live;  // Access Flag

    constructor(address vat_, bytes32 ilk_, address gem_, uint256 decimals) public {
        require(decimals < 18, "GemJoin3/decimals-18-or-higher");
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        dec = decimals;
    }

    function cage() external note auth {
        live = 0;
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "GemJoin3/overflow");
    }

    function join(address urn, uint256 wad) public note {
        require(live == 1, "GemJoin3/not-live");
        uint256 wad18 = mul(wad, 10 ** (18 - dec));
        require(wad18 <= 2 ** 255, "GemJoin3/overflow");
        vat.slip(ilk, urn, int256(wad18));
        require(gem.transferFrom(msg.sender, address(this), wad), "GemJoin3/failed-transfer");
    }

    function exit(address guy, uint256 wad) public note {
        uint256 wad18 = mul(wad, 10 ** (18 - dec));
        require(wad18 <= 2 ** 255, "GemJoin3/overflow");
        vat.slip(ilk, msg.sender, -int256(wad18));
        require(gem.transfer(guy, wad), "GemJoin3/failed-transfer");
    }
}
