// SPDX-License-Identifier: AGPL-3.0-or-later

/// join-7.sol -- Non-standard token adapters

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
    function upgradedAddress() external view returns (address);
    function setImplementation(address, uint256) external;
    function adjustFee(uint256) external;
}

// GemJoin7
// For an upgradable token (like USDT) which doesn't return bool on transfers and may charge fees
//  If the token is deprecated changing the implementation behind, this prevents joins
//   and exits until the implementation is reviewed and approved by governance.

contract GemJoin7 {
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
    uint256 public live; // Access flag

    // Events
    event Rely(address indexed usr);
    event Deny(address indexed usr);
    event Join(address indexed usr, uint256 wad);
    event Exit(address indexed usr, uint256 wad);
    event Cage();

    mapping (address => uint256) public implementations;

    constructor(address vat_, bytes32 ilk_, address gem_) public {
        gem = GemLike(gem_);
        dec = gem.decimals();
        require(dec < 18, "GemJoin7/decimals-18-or-higher");
        wards[msg.sender] = 1;
        live = 1;
        vat = VatLike(vat_);
        ilk = ilk_;
        setImplementation(address(gem.upgradedAddress()), 1);
        emit Rely(msg.sender);
    }

    function cage() external auth {
        live = 0;
        emit Cage();
    }

    function setImplementation(address implementation, uint256 permitted) public auth {
        implementations[implementation] = permitted; // 1 live, 0 disable
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "GemJoin7/overflow");
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x, "GemJoin7/underflow");
    }

    function join(address usr, uint256 amt) external {
        require(live == 1, "GemJoin7/not-live");
        require(implementations[gem.upgradedAddress()] == 1, "GemJoin7/implementation-invalid");
        uint256 bal = gem.balanceOf(address(this));
        gem.transferFrom(msg.sender, address(this), amt);
        uint256 wad = mul(sub(gem.balanceOf(address(this)), bal), 10 ** (18 - dec));
        require(int256(wad) >= 0, "GemJoin7/overflow");
        vat.slip(ilk, usr, int256(wad));
        emit Join(usr, amt);
    }

    function exit(address usr, uint256 amt) external {
        uint256 wad = mul(amt, 10 ** (18 - dec));
        require(int256(wad) >= 0, "GemJoin7/overflow");
        require(implementations[gem.upgradedAddress()] == 1, "GemJoin7/implementation-invalid");
        vat.slip(ilk, msg.sender, -int256(wad));
        gem.transfer(usr, amt);
        emit Exit(usr, amt);
    }
}
