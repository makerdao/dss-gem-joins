// SPDX-License-Identifier: AGPL-3.0-or-later

/// wgem.sol -- Wrapped Gem

// Copyright (C) 2018 Rain <rainbreak@riseup.net>
// Copyright (C) 2018-2021 Maker Ecosystem Growth Holdings, INC.
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

interface GemLike {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function balanceOf(address) external view returns (uint256);
    function decimals() external view returns (uint8);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

// Wraps a gem for sole use within a Maker gem join
// Useful to avoid things double transfer fees with proxies (PAXG)

contract WrappedGem {

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external auth { wards[usr] = 1; emit Rely(usr); }
    function deny(address usr) external auth { wards[usr] = 0; emit Deny(usr); }
    modifier auth {
        require(wards[msg.sender] == 1, "WrappedGem/not-authorized");
        _;
    }

    // --- Storage ---
    GemLike public immutable gem;

    uint256 internal immutable to18ConversionFactor;

    // --- ERC20 Token Storage ---
    uint256                      public totalSupply;
    mapping (address => uint256) public balanceOf;
    string                       public symbol;
    uint8                        public constant decimals = 18;
    string                       public name;

    // --- Events ---
    event Rely(address indexed usr);
    event Deny(address indexed usr);
    event Transfer(address indexed src, address indexed dst, uint wad);
    event Mint(address indexed guy, uint wad);
    event Burn(address indexed guy, uint wad);

    // --- Init ---
    constructor(address gem_) public {
        require(GemLike(gem_).decimals() <= 18);

        wards[msg.sender] = 1;
        emit Rely(msg.sender);
        
        gem = GemLike(gem_);
        symbol = GemLike(gem_).symbol();
        name = GemLike(gem_).name();
        to18ConversionFactor = 10 ** (18 - uint256(GemLike(gem_).decimals()));
    }

    // --- Math ---
    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x);
    }
    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x);
    }
    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    // --- ERC20 Methods ---
    function transfer(address dst, uint256 wad) external returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }
    function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
        // Can only transfer in and out of an authed contracts
        require(wards[src] == 1 || wards[dst] == 1, "WrappedGem/only-auth-transfers");

        balanceOf[src] = sub(balanceOf[src], wad);
        balanceOf[dst] = add(balanceOf[dst], wad);

        emit Transfer(src, dst, wad);

        return true;
    }
    function mint(address guy, uint256 amt) public {
        uint256 wad = mul(amt, to18ConversionFactor);
        balanceOf[guy] = add(balanceOf[guy], wad);
        totalSupply = add(totalSupply, wad);

        emit Mint(guy, wad);

        require(gem.transferFrom(msg.sender, address(this), amt), "WrappedGem/failed-transfer");
    }
    function burn(address guy, uint256 amt) public {
        uint256 wad = mul(amt, to18ConversionFactor);
        balanceOf[guy] = sub(balanceOf[guy], wad);
        totalSupply = sub(totalSupply, wad);

        emit Burn(guy, wad);

        require(gem.transfer(guy, amt), "WrappedGem/insufficient-balance");
    }

}
