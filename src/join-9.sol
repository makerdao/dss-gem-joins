// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-9s.sol -- Non-standard token adapters

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

import "dss/lib.sol";

interface VatLike {
    function slip(bytes32, address, int256) external;
}

interface GemLike {
    function balanceOf(address) external view returns (uint256);
    function decimals() external view returns (uint8);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function getFeeFor(uint256) external returns (uint256);
}

// For a token that has a fee (PAXG)

contract GemJoin9 is LibNote {
    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }
    modifier auth {
        require(wards[msg.sender] == 1, "GemJoin/not-authorized");
        _;
    }

    VatLike public vat;   // CDP Engine
    bytes32 public ilk;   // Collateral Type
    GemLike public gem;
    uint256 public dec;
    uint256 public live;  // Active Flag
    uint256 public total;

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        dec = gem.decimals();
    }
    function cage() external note auth {
        live = 0;
    }
    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x);
    }
    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x);
    }
    // Allow dss-proxy-actions to send the gems with only 1 transfer
    // This should be called via token.transfer() followed by gemJoin.join() atomically or
    // someone else can steal your tokens
    function join(address usr) external note returns (uint256) {
        require(live == 1, "GemJoin/not-live");

        uint256 wad = sub(gem.balanceOf(address(this)), total);
        require(int256(wad) >= 0, "GemJoin/overflow");

        vat.slip(ilk, usr, int256(wad));
        total = add(total, wad);

        return wad;
    }
    function join(address usr, uint256 wad) external note {
        require(live == 1, "GemJoin/not-live");

        uint256 sad = sub(wad, gem.getFeeFor(wad));
        require(int256(sad) >= 0, "GemJoin/overflow");

        vat.slip(ilk, usr, int256(sad));
        total = add(total, sad);

        uint256 bal = gem.balanceOf(address(this));
        require(gem.transferFrom(msg.sender, address(this), wad), "GemJoin/failed-transfer");
        require(sub(gem.balanceOf(address(this)), bal) == sad, "GemJoin/bad-fee");
    }
    function exit(address usr, uint256 wad) external note {
        require(wad <= 2 ** 255, "GemJoin/overflow");

        vat.slip(ilk, msg.sender, -int256(wad));
        total = sub(total, wad);

        require(gem.transfer(usr, wad), "GemJoin/failed-transfer");
    }
}