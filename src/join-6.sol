// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-6.sol -- Non-standard token adapters

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
    function balanceOf(address) external returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function implementation() external view returns (address);
}

// For a token with a proxy and implementation contract (like tUSD)
//  If the implementation behind the proxy is changed, this prevents joins
//   and exits until the implementation is reviewed and approved by governance.

contract GemJoin6 {
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
    modifier auth {
        require(wards[msg.sender] == 1, "GemJoin6/not-authorized");
        _;
    }

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

    mapping (address => uint256) public implementations;

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        gem = GemLike(gem_);
        setImplementation(gem.implementation(), 1);
        dec = gem.decimals();
        emit Rely(msg.sender);
    }
    function cage() external auth {
        live = 0;
        emit Cage();
    }
    function setImplementation(address implementation, uint256 permitted) public auth  {
        implementations[implementation] = permitted;  // 1 live, 0 disable
    }
    function join(address usr, uint256 wad) external {
        require(live == 1, "GemJoin6/not-live");
        require(int256(wad) >= 0, "GemJoin6/overflow");
        require(implementations[gem.implementation()] == 1, "GemJoin6/implementation-invalid");
        vat.slip(ilk, usr, int256(wad));
        require(gem.transferFrom(msg.sender, address(this), wad), "GemJoin6/failed-transfer");
        emit Join(usr, wad);
    }
    function exit(address usr, uint256 wad) external {
        require(wad <= 2 ** 255, "GemJoin6/overflow");
        require(implementations[gem.implementation()] == 1, "GemJoin6/implementation-invalid");
        vat.slip(ilk, msg.sender, -int256(wad));
        require(gem.transfer(usr, wad), "GemJoin6/failed-transfer");
        emit Exit(usr, wad);
    }
}
