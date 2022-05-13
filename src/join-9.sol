// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-9.sol -- Non-standard token adapters

// Copyright (C) 2018 Rain <rainbreak@riseup.net>
// Copyright (C) 2020-2022 Dai Foundation
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

pragma solidity >=0.6.12;

interface VatLike {
    function slip(bytes32, address, int256) external;
}

interface GemLike {
    function balanceOf(address) external view returns (uint256);
    function decimals() external view returns (uint8);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

// For a token that has a fee (PAXG)

contract GemJoin9 {
    // --- Data ---
    mapping (address => uint256) public wards; // Auth

    uint256 public live;                       // Active Flag
    uint256 public total;                      // Internal balance tracking

    VatLike public immutable vat;              // CDP Engine
    bytes32 public immutable ilk;              // Collateral Type
    GemLike public immutable gem;
    uint256 public immutable dec;

    // --- Events ---
    event Rely(address indexed usr);
    event Deny(address indexed usr);
    event Join(address indexed usr, uint256 wad);
    event Exit(address indexed usr, uint256 wad);
    event Cage();

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        dec = GemLike(gem_).decimals();
        live = 1;
        wards[msg.sender] = 1;
        emit Rely(msg.sender);
    }

    // --- Auth ---
    modifier auth {
        require(wards[msg.sender] == 1, "GemJoin9/not-authorized");
        _;
    }

    function rely(address usr) external auth {
        wards[usr] = 1;
        emit Rely(usr);
    }

    function deny(address usr) external auth {
        wards[usr] = 0;
        emit Deny(usr);
    }

    function cage() external auth {
        live = 0;
        emit Cage();
    }

    // --- Math ---
    function _add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x, "GemJoin9/overflow");
    }
    function _sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x, "GemJoin9/underflow");
    }

    // Allow dss-proxy-actions to send the gems with only 1 transfer
    // This should be called via token.transfer() followed by gemJoin.join() atomically or
    // someone else can steal your tokens
    function join(address usr) external returns (uint256 wad) {
        wad = _join(usr);

        emit Join(usr, wad);
    }

    function join(address usr, uint256 wad) external {
        require(gem.transferFrom(msg.sender, address(this), wad), "GemJoin9/failed-transfer");

        _join(usr);

        emit Join(usr, wad);
    }

    function _join(address usr) internal returns (uint256 wad) {
        require(live == 1, "GemJoin9/not-live");

        uint256 _total = total;     // Cache to save an SLOAD
        wad = _sub(gem.balanceOf(address(this)), _total);
        require(int256(wad) >= 0, "GemJoin9/overflow");

        total = _add(_total, wad);
        vat.slip(ilk, usr, int256(wad));
    }

    function exit(address usr, uint256 wad) external {
        require(wad <= 2 ** 255, "GemJoin9/overflow");

        total = _sub(total, wad);
        vat.slip(ilk, msg.sender, -int256(wad));

        require(gem.transfer(usr, wad), "GemJoin9/failed-transfer");
        emit Exit(usr, wad);
    }
}
