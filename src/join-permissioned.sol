// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-permissioned.sol -- Non-standard token adapters

// Copyright (C) 2021 Dai Foundation
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
    function decimals() external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

// For a token that needs to limit who can join collateral, without giving full ward authorization.

contract PermissionedGemJoin is LibNote {
    VatLike public vat;
    bytes32 public ilk;
    GemLike public gem;
    uint256 public dec;
    uint256 public live;  // Access Flag

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) public note auth { wards[usr] = 1; }
    function deny(address usr) public note auth { wards[usr] = 0; }
    modifier auth { require(wards[msg.sender] == 1, "PermissionedGemJoin/non-authed"); _; }

    // Whitelisted contracts, set by an auth
    mapping (address => uint256) public bud;

    modifier toll { require(bud[msg.sender] == 1, "PermissionedGemJoin/contract-not-whitelisted"); _; }

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

    function join(address usr, uint256 wad) public toll note {
        require(live == 1, "PermissionedGemJoin/not-live");
        require(int256(wad) >= 0, "PermissionedGemJoin/overflow");
        vat.slip(ilk, usr, int256(wad));
        require(gem.transferFrom(msg.sender, address(this), wad), "PermissionedGemJoin/failed-transfer");
    }

    function exit(address usr, uint256 wad) public note {
        require(wad <= 2 ** 255, "PermissionedGemJoin/overflow");
        vat.slip(ilk, msg.sender, -int256(wad));
        require(gem.transfer(usr, wad), "PermissionedGemJoin/failed-transfer");
    }

    function kiss(address a) external note auth {
        require(a != address(0), "PermissionedGemJoin/no-contract-0");
        bud[a] = 1;
    }

    function diss(address a) external note auth {
        bud[a] = 0;
    }
}
