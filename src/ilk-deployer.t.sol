pragma solidity >=0.5.12;

import "dss-deploy/DssDeploy.t.base.sol";

import {IlkDeployer} from "./ilk-deployer.sol";

contract DssDeployTest is DssDeployTestBase {

    function testIlkDeployer() public {
        DSToken gold = new DSToken("gold");
        IlkDeployer dep = new IlkDeployer(0, "gold", address(gold));

        assertEq(dep.join(), 0xF9b0FA6c2B1ec98Fd2D54bc2a345Ed65597eb537);
        assertEq(dep.flip(), 0xbc95e8904d879F371Ac6B749727a0EAfDCd2ACB6);
    }

}


