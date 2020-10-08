pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./DssGemJoins.sol";

contract DssGemJoinsTest is DSTest {
    DssGemJoins joins;

    function setUp() public {
        joins = new DssGemJoins();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
