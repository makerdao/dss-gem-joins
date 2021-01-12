pragma solidity >=0.5.12;

import "dss/lib.sol";

interface VatLike {
    function slip(bytes32, address, int256) external;
}

interface GemLike {
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function decimals() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);
}
