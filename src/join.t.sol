pragma solidity >=0.5.12;

import "dss-deploy/DssDeploy.t.base.sol";

import {GemJoin2} from "./join-2.sol";
import {GemJoin3} from "./join-3.sol";
import {GemJoin4} from "./join-4.sol";
import {GemJoin5} from "./join-5.sol";
import {GemJoin6} from "./join-6.sol";
import {GemJoin7} from "./join-7.sol";
import {GemJoin8} from "./join-8.sol";
import {GemJoin9} from "./join-9.sol";
import {AuthGemJoin} from "./join-auth.sol";

import "./tokens/AAVE.sol";
import "./tokens/BAL.sol";
import "./tokens/BAT.sol";
import "./tokens/COMP.sol";
import "./tokens/DGD.sol";
import "./tokens/GNT.sol";
import "./tokens/GUSD.sol";
import "./tokens/KNC.sol";
import "./tokens/LINK.sol";
import "./tokens/LRC.sol";
import "./tokens/MANA.sol";
import "./tokens/OMG.sol";
import "./tokens/PAXG.sol";
import "./tokens/PAXUSD.sol";
import "./tokens/RENBTC.sol";
import "./tokens/REP.sol";
import "./tokens/TUSD.sol";
import "./tokens/UNI.sol";
import "./tokens/USDC.sol";
import "./tokens/USDT.sol";
import "./tokens/WBTC.sol";
import "./tokens/YFI.sol";
import "./tokens/ZRX.sol";

contract DssDeployTest is DssDeployTestBase {
    function testGemJoin_REP() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        REP rep = new REP(100 ether);
        GemJoin repJoin = new GemJoin(address(vat), "REP", address(rep));
        assertEq(repJoin.dec(), 18);

        dssDeploy.deployCollateral("REP", address(repJoin), address(pip));

        rep.approve(address(repJoin), uint256(-1));
        assertEq(rep.balanceOf(address(this)), 100 ether);
        assertEq(rep.balanceOf(address(repJoin)), 0);
        assertEq(vat.gem("REP", address(this)), 0);
        repJoin.join(address(this), 10 ether);
        assertEq(rep.balanceOf(address(repJoin)), 10 ether);
        assertEq(vat.gem("REP", address(this)), 10 ether);
        repJoin.exit(address(this), 4 ether);
        assertEq(rep.balanceOf(address(this)), 94 ether);
        assertEq(rep.balanceOf(address(repJoin)), 6 ether);
        assertEq(vat.gem("REP", address(this)), 6 ether);
    }

    function testGemJoin_ZRX() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        ZRX zrx = new ZRX(100 ether);
        GemJoin zrxJoin = new GemJoin(address(vat), "ZRX", address(zrx));
        assertEq(zrxJoin.dec(), 18);

        dssDeploy.deployCollateral("ZRX", address(zrxJoin), address(pip));

        zrx.approve(address(zrxJoin), uint256(-1));
        assertEq(zrx.balanceOf(address(this)), 100 ether);
        assertEq(zrx.balanceOf(address(zrxJoin)), 0);
        assertEq(vat.gem("ZRX", address(this)), 0);
        zrxJoin.join(address(this), 10 ether);
        assertEq(zrx.balanceOf(address(zrxJoin)), 10 ether);
        assertEq(vat.gem("ZRX", address(this)), 10 ether);
        zrxJoin.exit(address(this), 4 ether);
        assertEq(zrx.balanceOf(address(this)), 94 ether);
        assertEq(zrx.balanceOf(address(zrxJoin)), 6 ether);
        assertEq(vat.gem("ZRX", address(this)), 6 ether);
    }

    function testGemJoin2_OMG() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        OMG omg = new OMG(100 ether);
        GemJoin2 omgJoin = new GemJoin2(address(vat), "OMG", address(omg));
        assertEq(omgJoin.dec(), 18);

        dssDeploy.deployCollateral("OMG", address(omgJoin), address(pip));

        omg.approve(address(omgJoin), uint256(-1));
        assertEq(omg.balanceOf(address(this)), 100 ether);
        assertEq(omg.balanceOf(address(omgJoin)), 0);
        assertEq(vat.gem("OMG", address(this)), 0);
        omgJoin.join(address(this), 10 ether);
        assertEq(omg.balanceOf(address(omgJoin)), 10 ether);
        assertEq(vat.gem("OMG", address(this)), 10 ether);
        omgJoin.exit(address(this), 4 ether);
        assertEq(omg.balanceOf(address(this)), 94 ether);
        assertEq(omg.balanceOf(address(omgJoin)), 6 ether);
        assertEq(vat.gem("OMG", address(this)), 6 ether);
    }

    function testGemJoin_BAT() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        BAT bat = new BAT(100 ether);
        GemJoin batJoin = new GemJoin(address(vat), "BAT", address(bat));
        assertEq(batJoin.dec(), 18);

        dssDeploy.deployCollateral("BAT", address(batJoin), address(pip));

        bat.approve(address(batJoin), uint256(-1));
        assertEq(bat.balanceOf(address(this)), 100 ether);
        assertEq(bat.balanceOf(address(batJoin)), 0);
        assertEq(vat.gem("BAT", address(this)), 0);
        batJoin.join(address(this), 10 ether);
        assertEq(bat.balanceOf(address(batJoin)), 10 ether);
        assertEq(vat.gem("BAT", address(this)), 10 ether);
        batJoin.exit(address(this), 4 ether);
        assertEq(bat.balanceOf(address(this)), 94 ether);
        assertEq(bat.balanceOf(address(batJoin)), 6 ether);
        assertEq(vat.gem("BAT", address(this)), 6 ether);
    }

    function testGemJoin3_DGD() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        DGD dgd = new DGD(100 * 10 ** 9);
        GemJoin3 dgdJoin = new GemJoin3(address(vat), "DGD", address(dgd), 9);
        assertEq(dgdJoin.dec(), 9);

        dssDeploy.deployCollateral("DGD", address(dgdJoin), address(pip));

        dgd.approve(address(dgdJoin), uint256(-1));
        assertEq(dgd.balanceOf(address(this)), 100 * 10 ** 9);
        assertEq(dgd.balanceOf(address(dgdJoin)), 0);
        assertEq(vat.gem("DGD", address(this)), 0);
        dgdJoin.join(address(this), 10 * 10 ** 9);
        assertEq(dgd.balanceOf(address(dgdJoin)), 10 * 10 ** 9);
        assertEq(vat.gem("DGD", address(this)), 10 ether);
        dgdJoin.exit(address(this), 4 * 10 ** 9);
        assertEq(dgd.balanceOf(address(this)), 94 * 10 ** 9);
        assertEq(dgd.balanceOf(address(dgdJoin)), 6 * 10 ** 9);
        assertEq(vat.gem("DGD", address(this)), 6 ether);
    }

    function testGemJoin4_GNT() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        GNT gnt = new GNT(100 ether);
        GemJoin4 gntJoin = new GemJoin4(address(vat), "GNT", address(gnt));
        assertEq(gntJoin.dec(), 18);

        dssDeploy.deployCollateral("GNT", address(gntJoin), address(pip));

        assertEq(gnt.balanceOf(address(this)), 100 ether);
        assertEq(gnt.balanceOf(address(gntJoin)), 0);
        assertEq(vat.gem("GNT", address(this)), 0);
        address bag = gntJoin.make();
        gnt.transfer(bag, 10 ether);
        gntJoin.join(address(this), 10 ether);
        assertEq(gnt.balanceOf(address(gntJoin)), 10 ether);
        assertEq(vat.gem("GNT", address(this)), 10 ether);
        gntJoin.exit(address(this), 4 ether);
        assertEq(gnt.balanceOf(address(this)), 94 ether);
        assertEq(gnt.balanceOf(address(gntJoin)), 6 ether);
        assertEq(vat.gem("GNT", address(this)), 6 ether);
    }

    function testGemJoin5_USDC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDC usdc = new USDC(100 * 10 ** 6);
        GemJoin5 usdcJoin = new GemJoin5(address(vat), "USDC", address(usdc));
        assertEq(usdcJoin.dec(), 6);

        dssDeploy.deployCollateral("USDC", address(usdcJoin), address(pip));

        usdc.approve(address(usdcJoin), uint256(-1));
        assertEq(usdc.balanceOf(address(this)), 100 * 10 ** 6);
        assertEq(usdc.balanceOf(address(usdcJoin)), 0);
        assertEq(vat.gem("USDC", address(this)), 0);
        usdcJoin.join(address(this), 10 * 10 ** 6);
        assertEq(usdc.balanceOf(address(usdcJoin)), 10 * 10 ** 6);
        assertEq(vat.gem("USDC", address(this)), 10 ether);
        usdcJoin.exit(address(this), 4 * 10 ** 6);
        assertEq(usdc.balanceOf(address(this)), 94 * 10 ** 6);
        assertEq(usdc.balanceOf(address(usdcJoin)), 6 * 10 ** 6);
        assertEq(vat.gem("USDC", address(this)), 6 ether);
    }

    function testGemJoin5_WBTC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        WBTC wbtc = new WBTC(100 * 10 ** 8);
        GemJoin5 wbtcJoin = new GemJoin5(address(vat), "WBTC", address(wbtc));
        assertEq(wbtcJoin.dec(), 8);

        dssDeploy.deployCollateral("WBTC", address(wbtcJoin), address(pip));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        assertEq(wbtc.balanceOf(address(this)), 100 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 0);
        assertEq(vat.gem("WBTC", address(this)), 0);
        wbtcJoin.join(address(this), 10 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 10 * 10 ** 8);
        assertEq(vat.gem("WBTC", address(this)), 10 ether);
        wbtcJoin.exit(address(this), 4 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(this)), 94 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 6 * 10 ** 8);
        assertEq(vat.gem("WBTC", address(this)), 6 ether);
    }

    function testGemJoin6_DGD() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        TUSD tusd = new TUSD(100 ether);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));
        assertEq(tusdJoin.dec(), 18);

        dssDeploy.deployCollateral("TUSD", address(tusdJoin), address(pip));

        tusd.approve(address(tusdJoin), uint256(-1));
        assertEq(tusd.balanceOf(address(this)), 100 ether);
        assertEq(tusd.balanceOf(address(tusdJoin)), 0);
        assertEq(vat.gem("TUSD", address(this)), 0);
        tusdJoin.join(address(this), 10 ether);
        assertEq(tusd.balanceOf(address(tusdJoin)), 10 ether);
        assertEq(vat.gem("TUSD", address(this)), 10 ether);
        tusdJoin.exit(address(this), 4 ether);
        assertEq(tusd.balanceOf(address(this)), 94 ether);
        assertEq(tusd.balanceOf(address(tusdJoin)), 6 ether);
        assertEq(vat.gem("TUSD", address(this)), 6 ether);
    }

    function testGemJoin_KNC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        KNC knc = new KNC(100 ether);
        GemJoin kncJoin = new GemJoin(address(vat), "KNC", address(knc));
        assertEq(kncJoin.dec(), 18);

        dssDeploy.deployCollateral("KNC", address(kncJoin), address(pip));

        knc.approve(address(kncJoin), uint256(-1));
        assertEq(knc.balanceOf(address(this)), 100 ether);
        assertEq(knc.balanceOf(address(kncJoin)), 0);
        assertEq(vat.gem("KNC", address(this)), 0);
        kncJoin.join(address(this), 10 ether);
        assertEq(knc.balanceOf(address(kncJoin)), 10 ether);
        assertEq(vat.gem("KNC", address(this)), 10 ether);
        kncJoin.exit(address(this), 4 ether);
        assertEq(knc.balanceOf(address(this)), 94 ether);
        assertEq(knc.balanceOf(address(kncJoin)), 6 ether);
        assertEq(vat.gem("KNC", address(this)), 6 ether);
    }

    function testGemJoin_MANA() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        MANA mana = new MANA(100 ether);
        GemJoin manaJoin = new GemJoin(address(vat), "MANA", address(mana));
        assertEq(manaJoin.dec(), 18);

        dssDeploy.deployCollateral("MANA", address(manaJoin), address(pip));

        mana.approve(address(manaJoin), uint256(-1));
        assertEq(mana.balanceOf(address(this)), 100 ether);
        assertEq(mana.balanceOf(address(manaJoin)), 0);
        assertEq(vat.gem("MANA", address(this)), 0);
        manaJoin.join(address(this), 10 ether);
        assertEq(mana.balanceOf(address(manaJoin)), 10 ether);
        assertEq(vat.gem("MANA", address(this)), 10 ether);
        manaJoin.exit(address(this), 4 ether);
        assertEq(mana.balanceOf(address(this)), 94 ether);
        assertEq(mana.balanceOf(address(manaJoin)), 6 ether);
        assertEq(vat.gem("MANA", address(this)), 6 ether);
    }

    function testGemJoin7_USDT() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        assertEq(usdtJoin.dec(), 6);

        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));

        usdt.approve(address(usdtJoin), uint256(-1));
        assertEq(usdt.balanceOf(address(this)), 100 * 10 ** 6);
        assertEq(usdt.balanceOf(address(usdtJoin)), 0);
        assertEq(vat.gem("USDT", address(this)), 0);
        usdtJoin.join(address(this), 10 * 10 ** 6);
        assertEq(usdt.balanceOf(address(usdtJoin)), 10 * 10 ** 6);
        assertEq(vat.gem("USDT", address(this)), 10 ether);
        usdtJoin.exit(address(this), 4 * 10 ** 6);
        assertEq(usdt.balanceOf(address(this)), 94 * 10 ** 6);
        assertEq(usdt.balanceOf(address(usdtJoin)), 6 * 10 ** 6);
        assertEq(vat.gem("USDT", address(this)), 6 ether);
    }

    function testGemJoin_PAXUSD() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        PAXUSD paxusd = new PAXUSD(100 ether);
        GemJoin paxusdJoin = new GemJoin(address(vat), "PAXUSD", address(paxusd));
        assertEq(paxusdJoin.dec(), 18);

        dssDeploy.deployCollateral("PAXUSD", address(paxusdJoin), address(pip));

        paxusd.approve(address(paxusdJoin), uint256(-1));
        assertEq(paxusd.balanceOf(address(this)), 100 ether);
        assertEq(paxusd.balanceOf(address(paxusdJoin)), 0);
        assertEq(vat.gem("PAXUSD", address(this)), 0);
        paxusdJoin.join(address(this), 10 ether);
        assertEq(paxusd.balanceOf(address(paxusdJoin)), 10 ether);
        assertEq(vat.gem("PAXUSD", address(this)), 10 ether);
        paxusdJoin.exit(address(this), 4 ether);
        assertEq(paxusd.balanceOf(address(this)), 94 ether);
        assertEq(paxusd.balanceOf(address(paxusdJoin)), 6 ether);
        assertEq(vat.gem("PAXUSD", address(this)), 6 ether);
    }

    function testGemJoin_COMP() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        COMP comp = new COMP(100 ether);
        GemJoin compJoin = new GemJoin(address(vat), "COMP", address(comp));
        assertEq(compJoin.dec(), 18);

        dssDeploy.deployCollateral("COMP", address(compJoin), address(pip));

        comp.approve(address(compJoin), uint256(-1));
        assertEq(comp.balanceOf(address(this)), 100 ether);
        assertEq(comp.balanceOf(address(compJoin)), 0);
        assertEq(vat.gem("COMP", address(this)), 0);
        compJoin.join(address(this), 10 ether);
        assertEq(comp.balanceOf(address(compJoin)), 10 ether);
        assertEq(vat.gem("COMP", address(this)), 10 ether);
        compJoin.exit(address(this), 4 ether);
        assertEq(comp.balanceOf(address(this)), 94 ether);
        assertEq(comp.balanceOf(address(compJoin)), 6 ether);
        assertEq(vat.gem("COMP", address(this)), 6 ether);
    }

    function testGemJoin_UNI() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        UNI uni = new UNI(100 ether);
        GemJoin uniJoin = new GemJoin(address(vat), "UNI", address(uni));
        assertEq(uniJoin.dec(), 18);

        dssDeploy.deployCollateral("UNI", address(uniJoin), address(pip));

        uni.approve(address(uniJoin), uint256(-1));
        assertEq(uni.balanceOf(address(this)), 100 ether);
        assertEq(uni.balanceOf(address(uniJoin)), 0);
        assertEq(vat.gem("UNI", address(this)), 0);
        uniJoin.join(address(this), 10 ether);
        assertEq(uni.balanceOf(address(uniJoin)), 10 ether);
        assertEq(vat.gem("UNI", address(this)), 10 ether);
        uniJoin.exit(address(this), 4 ether);
        assertEq(uni.balanceOf(address(this)), 94 ether);
        assertEq(uni.balanceOf(address(uniJoin)), 6 ether);
        assertEq(vat.gem("UNI", address(this)), 6 ether);
    }

    function testGemJoin_AAVE() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        AAVE aave = new AAVE(100 * 10**18);
        GemJoin aaveJoin = new GemJoin(address(vat), "AAVE", address(aave));
        assertEq(aaveJoin.dec(), 18);

        dssDeploy.deployCollateral("AAVE", address(aaveJoin), address(pip));

        aave.approve(address(aaveJoin), uint256(-1));
        assertEq(aave.balanceOf(address(this)), 100 * 10**18);
        assertEq(aave.balanceOf(address(aaveJoin)), 0);
        assertEq(vat.gem("AAVE", address(this)), 0);
        aaveJoin.join(address(this), 10 * 10**18);
        assertEq(aave.balanceOf(address(aaveJoin)), 10 * 10**18);
        assertEq(vat.gem("AAVE", address(this)), 10 * 10**18);
        aaveJoin.exit(address(this), 4 * 10**18);
        assertEq(aave.balanceOf(address(this)), 94 * 10**18);
        assertEq(aave.balanceOf(address(aaveJoin)), 6 * 10**18);
        assertEq(vat.gem("AAVE", address(this)), 6 * 10**18);
    }

    function testGemJoin_LRC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        LRC lrc = new LRC(100 ether);
        GemJoin lrcJoin = new GemJoin(address(vat), "LRC", address(lrc));
        assertEq(lrcJoin.dec(), 18);

        dssDeploy.deployCollateral("LRC", address(lrcJoin), address(pip));

        lrc.approve(address(lrcJoin), uint256(-1));
        assertEq(lrc.balanceOf(address(this)), 100 ether);
        assertEq(lrc.balanceOf(address(lrcJoin)), 0);
        assertEq(vat.gem("LRC", address(this)), 0);
        lrcJoin.join(address(this), 10 ether);
        assertEq(lrc.balanceOf(address(lrcJoin)), 10 ether);
        assertEq(vat.gem("LRC", address(this)), 10 ether);
        lrcJoin.exit(address(this), 4 ether);
        assertEq(lrc.balanceOf(address(this)), 94 ether);
        assertEq(lrc.balanceOf(address(lrcJoin)), 6 ether);
        assertEq(vat.gem("LRC", address(this)), 6 ether);
    }

    function testGemJoin_LINK() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        LINK link = new LINK(100 ether);
        GemJoin linkJoin = new GemJoin(address(vat), "LINK", address(link));
        assertEq(linkJoin.dec(), 18);

        dssDeploy.deployCollateral("LINK", address(linkJoin), address(pip));

        link.approve(address(linkJoin), uint256(-1));
        assertEq(link.balanceOf(address(this)), 100 ether);
        assertEq(link.balanceOf(address(linkJoin)), 0);
        assertEq(vat.gem("LINK", address(this)), 0);
        linkJoin.join(address(this), 10 ether);
        assertEq(link.balanceOf(address(linkJoin)), 10 ether);
        assertEq(vat.gem("LINK", address(this)), 10 ether);
        linkJoin.exit(address(this), 4 ether);
        assertEq(link.balanceOf(address(this)), 94 ether);
        assertEq(link.balanceOf(address(linkJoin)), 6 ether);
        assertEq(vat.gem("LINK", address(this)), 6 ether);
    }

    function testGemJoin_BAL() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        BAL bal = new BAL(100 ether);
        GemJoin balJoin = new GemJoin(address(vat), "BAL", address(bal));
        assertEq(balJoin.dec(), 18);

        dssDeploy.deployCollateral("BAL", address(balJoin), address(pip));

        bal.approve(address(balJoin), uint256(-1));
        assertEq(bal.balanceOf(address(this)), 100 ether);
        assertEq(bal.balanceOf(address(balJoin)), 0);
        assertEq(vat.gem("BAL", address(this)), 0);
        balJoin.join(address(this), 10 ether);
        assertEq(bal.balanceOf(address(balJoin)), 10 ether);
        assertEq(vat.gem("BAL", address(this)), 10 ether);
        balJoin.exit(address(this), 4 ether);
        assertEq(bal.balanceOf(address(this)), 94 ether);
        assertEq(bal.balanceOf(address(balJoin)), 6 ether);
        assertEq(vat.gem("BAL", address(this)), 6 ether);
    }

    function testGemJoin_YFI() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        YFI yfi = new YFI(100 ether);
        GemJoin yfiJoin = new GemJoin(address(vat), "YFI", address(yfi));
        assertEq(yfiJoin.dec(), 18);

        dssDeploy.deployCollateral("YFI", address(yfiJoin), address(pip));

        yfi.approve(address(yfiJoin), uint256(-1));
        assertEq(yfi.balanceOf(address(this)), 100 ether);
        assertEq(yfi.balanceOf(address(yfiJoin)), 0);
        assertEq(vat.gem("YFI", address(this)), 0);
        yfiJoin.join(address(this), 10 ether);
        assertEq(yfi.balanceOf(address(yfiJoin)), 10 ether);
        assertEq(vat.gem("YFI", address(this)), 10 ether);
        yfiJoin.exit(address(this), 4 ether);
        assertEq(yfi.balanceOf(address(this)), 94 ether);
        assertEq(yfi.balanceOf(address(yfiJoin)), 6 ether);
        assertEq(vat.gem("YFI", address(this)), 6 ether);
    }

    function testGemJoin8_GUSD() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        assertEq(gusdJoin.dec(), 2);

        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));

        gusd.approve(address(gusdJoin), uint256(-1));
        assertEq(gusd.balanceOf(address(this)), 100 * 10 ** 2);
        assertEq(gusd.balanceOf(address(gusdJoin)), 0);
        assertEq(vat.gem("GUSD", address(this)), 0);
        gusdJoin.join(address(this), 10 * 10 ** 2);
        assertEq(gusd.balanceOf(address(gusdJoin)), 10 * 10 ** 2);
        assertEq(vat.gem("GUSD", address(this)), 10 ether);
        gusdJoin.exit(address(this), 4 * 10 ** 2);
        assertEq(gusd.balanceOf(address(this)), 94 * 10 ** 2);
        assertEq(gusd.balanceOf(address(gusdJoin)), 6 * 10 ** 2);
        assertEq(vat.gem("GUSD", address(this)), 6 ether);
    }

    function testGemJoin_PAXG() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));

        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        paxgJoin.join(address(this), 10 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 10 * 10 ** 18);
        assertEq(vat.gem("PAXG", address(this)), 10 ether);
        paxgJoin.exit(address(this), 4 * 10 ** 18);
        assertEq(paxg.balanceOf(address(this)), 94 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 6 * 10 ** 18);
        assertEq(vat.gem("PAXG", address(this)), 6 ether);
    }

    function testGemJoin5_RENBTC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        RENBTC renbtc = new RENBTC(100 * 10 ** 8);
        GemJoin5 renbtcJoin = new GemJoin5(address(vat), "RENBTC", address(renbtc));
        assertEq(renbtcJoin.dec(), 8);

        dssDeploy.deployCollateral("RENBTC", address(renbtcJoin), address(pip));

        renbtc.approve(address(renbtcJoin), uint256(-1));
        assertEq(renbtc.balanceOf(address(this)), 100 * 10 ** 8);
        assertEq(renbtc.balanceOf(address(renbtcJoin)), 0);
        assertEq(vat.gem("RENBTC", address(this)), 0);
        renbtcJoin.join(address(this), 10 * 10 ** 8);
        assertEq(renbtc.balanceOf(address(renbtcJoin)), 10 * 10 ** 8);
        assertEq(vat.gem("RENBTC", address(this)), 10 ether);
        renbtcJoin.exit(address(this), 4 * 10 ** 8);
        assertEq(renbtc.balanceOf(address(this)), 94 * 10 ** 8);
        assertEq(renbtc.balanceOf(address(renbtcJoin)), 6 * 10 ** 8);
        assertEq(vat.gem("RENBTC", address(this)), 6 ether);
    }

    function testFailGemJoin6Join() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        TUSD tusd = new TUSD(100 ether);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));
        dssDeploy.deployCollateral("TUSD", address(tusdJoin), address(pip));
        tusd.approve(address(tusdJoin), uint256(-1));
        assertEq(tusd.balanceOf(address(this)), 100 ether);
        assertEq(tusd.balanceOf(address(tusdJoin)), 0);
        assertEq(vat.gem("TUSD", address(this)), 0);
        tusd.setImplementation(0xCB9a11afDC6bDb92E4A6235959455F28758b34bA);
        // Fail here
        tusdJoin.join(address(this), 10 ether);
    }

    function testFailGemJoin6Exit() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        TUSD tusd = new TUSD(100 ether);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));
        dssDeploy.deployCollateral("TUSD", address(tusdJoin), address(pip));
        tusd.approve(address(tusdJoin), uint256(-1));
        tusdJoin.join(address(this), 10 ether);
        tusd.setImplementation(0xCB9a11afDC6bDb92E4A6235959455F28758b34bA);
        // Fail here
        tusdJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin7JoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));
        usdt.approve(address(usdtJoin), uint256(-1));
        // Fail here
        usdtJoin.join(address(this), 10 ether);
    }

    function testFailGemJoin7ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));
        usdt.approve(address(usdtJoin), uint256(-1));
        usdtJoin.join(address(this), 10 * 10 ** 6);
        // Fail here
        usdtJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin7Join() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));
        usdt.approve(address(usdtJoin), uint256(-1));
        assertEq(usdt.balanceOf(address(this)), 100 * 10 ** 6);
        assertEq(usdt.balanceOf(address(usdtJoin)), 0);
        assertEq(vat.gem("USDT", address(this)), 0);
        usdt.deprecate(address(1));
        // Fail here
        usdtJoin.join(address(this), 10 * 10 ** 6);
    }

    function testFailGemJoin7Exit() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));
        usdt.approve(address(usdtJoin), uint256(-1));
        usdtJoin.join(address(this), 10 * 10 ** 6);
        usdt.deprecate(address(1));
        // Fail here
        usdtJoin.exit(address(this), 10 * 10 ** 6);
    }

    function testGemJoin7FeeChange() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));

        // auxiliary function added, not in tether source code
        // basisPointsRate = 1, maximumFee = 1
        usdt.changeFees(100, 100);

        usdt.approve(address(usdtJoin), uint256(-1));
        usdtJoin.join(address(this), 1 * 10 ** 6);
        uint256 joinbal = vat.gem("USDT", address(this));

        assertEq(usdt.balanceOf(address(usdtJoin)), 999900);
        assertEq(joinbal, 999900 * 10 ** 12);
        usdtJoin.exit(address(this), 999900); // exit in 10 ** 6
        uint256 exitbal = usdt.balanceOf(address(this));
        assertEq(exitbal, 99999800);
    }

    function testFailGemJoin8JoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));
        gusd.approve(address(gusdJoin), uint256(-1));
        // Fail here
        gusdJoin.join(address(this), 10 ether);
    }

    function testFailGemJoin8ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));
        gusd.approve(address(gusdJoin), uint256(-1));
        gusdJoin.join(address(this), 10 * 10 ** 2);
        // Fail here
        gusdJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin8Join() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));
        gusd.approve(address(gusdJoin), uint256(-1));
        assertEq(gusd.balanceOf(address(this)), 100 * 10 ** 2);
        assertEq(gusd.balanceOf(address(gusdJoin)), 0);
        assertEq(vat.gem("GUSD", address(this)), 0);
        gusd.setImplementation(address(1));
        // Fail here
        gusdJoin.join(address(this), 10 * 10 ** 2);
    }

    function testFailGemJoin8Exit() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));
        gusd.approve(address(gusdJoin), uint256(-1));
        gusdJoin.join(address(this), 10 * 10 ** 2);
        gusd.setImplementation(address(1));
        // Fail here
        gusdJoin.exit(address(this), 10 * 10 ** 2);
    }

    function testFailGemJoin9JoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));
        paxg.approve(address(paxgJoin), uint256(-1));
        // Fail here
        paxgJoin.join(address(this), 1000 ether);
    }

    function testFailGemJoin9ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));
        paxg.approve(address(paxgJoin), uint256(-1));
        paxgJoin.join(address(this), 10 * 10 ** 18);
        // Fail here
        paxgJoin.exit(address(this), 100 ether);
    }

    function testGemJoin9JoinFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));
        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 0);
        paxg.setFeeRate(40000);     // 4%
        paxgJoin.join(address(this), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(this)), 0);
        assertEq(paxg.balanceOf(address(paxgJoin)), 96 * 10 ** 18);
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
        assertEq(vat.gem("PAXG", address(this)), 96 * 10 ** 18);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 4 * 10 ** 18);
        paxg.setFeeRate(250000);     // 25%
        paxgJoin.exit(address(this), 96 * 10 ** 18);
        assertEq(paxg.balanceOf(address(this)), 72 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 28 * 10 ** 18);
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
    }

    function testFailGemJoin9JoinFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));
        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        paxg.setFeeRate(10000);     // 1%
        paxgJoin.join(address(this), 100 * 10 ** 18);
        // Fail here
        paxgJoin.exit(address(this), 100 * 10 ** 18);
    }

    function testGemJoin9JoinDirectFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 0);
        paxg.setFeeRate(40000);     // 4%
        paxg.transfer(address(paxgJoin), 100 * 10 ** 18);
        paxgJoin.join(address(this));
        assertEq(paxg.balanceOf(address(this)), 0);
        assertEq(paxg.balanceOf(address(paxgJoin)), 96 * 10 ** 18);
        assertEq(vat.gem("PAXG", address(this)), 96 * 10 ** 18);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 4 * 10 ** 18);
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
        paxg.setFeeRate(250000);     // 25%
        paxgJoin.exit(address(this), 96 * 10 ** 18);
        assertEq(paxg.balanceOf(address(this)), 72 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), 28 * 10 ** 18);
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
    }

    function testFailJoinAfterCageGemJoin2() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        OMG omg = new OMG(100 ether);
        GemJoin2 omgJoin = new GemJoin2(address(vat), "OMG", address(omg));

        dssDeploy.deployCollateral("OMG", address(omgJoin), address(pip));

        omg.approve(address(omgJoin), uint256(-1));
        omgJoin.join(address(this), 10);
        omgJoin.cage();
        omgJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin3() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        DGD dgd = new DGD(100 ether);
        GemJoin3 dgdJoin = new GemJoin3(address(vat), "DGD", address(dgd), 9);

        dssDeploy.deployCollateral("DGD", address(dgdJoin), address(pip));

        dgd.approve(address(dgdJoin), uint256(-1));
        dgdJoin.join(address(this), 10);
        dgdJoin.cage();
        dgdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin4() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        GNT gnt = new GNT(100 ether);
        GemJoin4 gntJoin = new GemJoin4(address(vat), "GNT", address(gnt));

        dssDeploy.deployCollateral("GNT", address(gntJoin), address(pip));

        address bag = gntJoin.make();
        gnt.transfer(bag, 10);
        gntJoin.join(address(this), 10);
        gntJoin.cage();
        gnt.transfer(bag, 10);
        gntJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin5() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDC usdc = new USDC(100 ether);
        GemJoin5 usdcJoin = new GemJoin5(address(vat), "USDC", address(usdc));

        dssDeploy.deployCollateral("USDC", address(usdcJoin), address(pip));

        usdc.approve(address(usdcJoin), uint256(-1));
        usdcJoin.join(address(this), 10);
        usdcJoin.cage();
        usdcJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin6() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        TUSD tusd = new TUSD(100 ether);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));

        dssDeploy.deployCollateral("TUSD", address(tusdJoin), address(pip));

        tusd.approve(address(tusdJoin), uint256(-1));
        tusdJoin.join(address(this), 10);
        tusdJoin.cage();
        tusdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin7() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        USDT usdt = new USDT(100 * 10 ** 6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        dssDeploy.deployCollateral("USDT", address(usdtJoin), address(pip));

        usdt.approve(address(usdtJoin), uint256(-1));
        usdtJoin.join(address(this), 10);
        usdtJoin.cage();
        usdtJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin8() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        GUSD gusd = new GUSD(100 * 10 ** 2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        dssDeploy.deployCollateral("GUSD", address(gusdJoin), address(pip));

        gusd.approve(address(gusdJoin), uint256(-1));
        gusdJoin.join(address(this), 10);
        gusdJoin.cage();
        gusdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin9() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        PAXG paxg = new PAXG(100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        dssDeploy.deployCollateral("PAXG", address(paxgJoin), address(pip));

        paxg.approve(address(paxgJoin), uint256(-1));
        paxgJoin.join(address(this), 100 * 10 ** 18);
        paxgJoin.cage();
        // Fail here
        paxgJoin.join(address(this), 100 * 10 ** 18);
    }

    function testFailJoinAfterCageAuthGemJoin() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        DSToken sai = new DSToken("SAI");
        sai.mint(20);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));

        dssDeploy.deployCollateral("SAI", address(saiJoin), address(pip));

        sai.approve(address(saiJoin), uint256(-1));
        saiJoin.join(address(this), 10);
        saiJoin.cage();
        saiJoin.join(address(this), 10);
    }

    function testTokenSai() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        DSToken sai = new DSToken("SAI");
        sai.mint(10);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));
        assertEq(saiJoin.dec(), 18);

        dssDeploy.deployCollateral("SAI", address(saiJoin), address(pip));

        sai.approve(address(saiJoin), uint256(-1));
        assertEq(sai.balanceOf(address(saiJoin)), 0);
        assertEq(vat.gem("SAI", address(this)), 0);
        saiJoin.join(address(this), 10);
        assertEq(sai.balanceOf(address(saiJoin)), 10);
        assertEq(vat.gem("SAI", address(this)), 10);
        saiJoin.deny(address(this)); // Check there is no need of authorization to exit
        saiJoin.exit(address(this), 4);
        assertEq(sai.balanceOf(address(saiJoin)), 6);
        assertEq(vat.gem("SAI", address(this)), 6);
    }

    function testFailTokenSai() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        DSToken sai = new DSToken("SAI");
        sai.mint(10);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));

        dssDeploy.deployCollateral("SAI", address(saiJoin), address(pip));

        sai.approve(address(saiJoin), uint256(-1));
        saiJoin.deny(address(this));
        saiJoin.join(address(this), 10);
    }
}
