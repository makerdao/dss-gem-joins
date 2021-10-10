// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-2.sol -- Non-standard token adapters

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
    function transfer(address, uint256) external;
    function transferFrom(address, address, uint256) external;
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);
}

// For a token that does not return a bool on transfer or transferFrom (like OMG)
// This is one way of doing it. Check the balances before and after calling a transfer

contract GemJoin2 {
    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external auth {
        wards[usr] = 1;
        emit Rely(usr);
    }
    function deny(address usr) external auth {
        wards[usr] = 0;
        emit Deny(usr);
    }
    modifier auth { require(wards[msg.sender] == 1); _; }

    VatLike public vat;
    bytes32 public ilk;
    GemLike public gem;
    uint256 public dec;
    uint256 public live;  // Access Flag

    // Events
    event Rely(address indexed usr);
    event Deny(address indexed usr);
    event Join(address indexed usr, uint256 wad);
    event Exit(address indexed usr, uint256 wad);
    event Cage();

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        dec = gem.decimals();
        emit Rely(msg.sender);
    }

    function cage() external auth {
        live = 0;
        emit Cage();
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "GemJoin2/overflow");
    }

    function join(address usr, uint256 wad) external {
        require(live == 1, "GemJoin2/not-live");
        require(wad <= 2 ** 255, "GemJoin2/overflow");
        vat.slip(ilk, usr, int256(wad));
        uint256 prevBalance = gem.balanceOf(msg.sender);

        require(prevBalance >= wad, "GemJoin2/no-funds");
        require(gem.allowance(msg.sender, address(this)) >= wad, "GemJoin2/no-allowance");

        (bool ok,) = address(gem).call(
            abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), wad)
        );
        require(ok, "GemJoin2/failed-transfer");

        require(prevBalance - wad == gem.balanceOf(msg.sender), "GemJoin2/failed-transfer");

        emit Join(usr, wad);
    }

    function exit(address usr, uint256 wad) external {
        require(wad <= 2 ** 255, "GemJoin2/overflow");
        vat.slip(ilk, msg.sender, -int256(wad));
        uint256 prevBalance = gem.balanceOf(address(this));

        require(prevBalance >= wad, "GemJoin2/no-funds");

        (bool ok,) = address(gem).call(
            abi.encodeWithSignature("transfer(address,uint256)", usr, wad)
        );
        require(ok, "GemJoin2/failed-transfer");

        require(prevBalance - wad == gem.balanceOf(address(this)), "GemJoin2/failed-transfer");

        emit Exit(usr, wad);
    }
}
