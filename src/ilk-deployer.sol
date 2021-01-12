// SPDX-License-Identifier: AGPL-3.0-or-later

/// ilkfab.sol -- Non-standard token adapters

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

import "./join.sol";
import "./join-auth.sol";
import "./join-2.sol";
import "./join-3.sol";
import "./join-4.sol";
import "./join-5.sol";
import "./join-6.sol";
import "./join-7.sol";
import "./join-8.sol";

interface Changelog {
    function getAddress(bytes32) external view returns (address);
}

interface Auth {
    function rely(address) external;
    function deny(address) external;
}

interface FlipFab {
    function newFlip(address,address,bytes32) external returns (address);
}

contract IlkDeployer {
    Changelog public constant changelog = Changelog(0xdA0Ab1e0017DEbCd72Be8599041a2aa3bA7e740F);

    address public flip;
    address public join;

    constructor(uint256 join_, bytes32 ilk_, address gem_) public {
        address vat = changelog.getAddress("MCD_VAT");

        if (join_ == 0) {
            join = address(new GemJoin(vat, ilk_, gem_));
        } else if (join_ == 1) {
            join = address(new AuthGemJoin(vat, ilk_, gem_));
        } else if (join_ == 2) {
            join = address(new GemJoin2(vat, ilk_, gem_));
        } else if (join_ == 3) {
            join = address(new GemJoin3(vat, ilk_, gem_, uint256(GemLike(gem_).decimals())));
        } else if (join_ == 4) {
            join = address(new GemJoin4(vat, ilk_, gem_));
        } else if (join_ == 5) {
            join = address(new GemJoin5(vat, ilk_, gem_));
        } else if (join_ == 6) {
            join = address(new GemJoin6(vat, ilk_, gem_));
        } else if (join_ == 7) {
            join = address(new GemJoin7(vat, ilk_, gem_));
        } else if (join_ == 8) {
            join = address(new GemJoin8(vat, ilk_, gem_));
        } else {
            revert("IlkFab/invalid-join-type");
        }
        address pause_proxy = changelog.getAddress("MCD_PAUSE_PROXY");
        Auth(join).rely(pause_proxy);
        Auth(join).deny(address(this));

        flip = FlipFab(changelog.getAddress("FLIP_FAB")).newFlip(vat, changelog.getAddress("MCD_CAT"), ilk_);
        Auth(flip).rely(pause_proxy);
        Auth(flip).deny(address(this));
    }
}
