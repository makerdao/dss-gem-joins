pragma solidity >=0.5.12;

import "dss-deploy/DssDeploy.t.base.sol";

import {IlkDeployer} from "./ilk-deployer.sol";

interface Wards {
    function wards(address) external returns (uint256);
}

contract DssDeployTest is DssDeployTestBase {

    address constant pauseProxy = 0xBE8E3e3618f7474F8cB1d074A26afFef007E98FB;

    function testIlkDeployer() public {
        DSToken gold = new DSToken("gold");
        IlkDeployer dep = new IlkDeployer(0, "gold", address(gold));

        assertEq(dep.join(), 0xF9b0FA6c2B1ec98Fd2D54bc2a345Ed65597eb537);
        assertEq(Wards(dep.join()).wards(address(dep)), 0);
        assertEq(Wards(dep.join()).wards(pauseProxy), 1);

        assertEq(dep.flip(), 0xbc95e8904d879F371Ac6B749727a0EAfDCd2ACB6);
        assertEq(Wards(dep.flip()).wards(address(dep)), 0);
        assertEq(Wards(dep.flip()).wards(pauseProxy), 1);
    }

}


