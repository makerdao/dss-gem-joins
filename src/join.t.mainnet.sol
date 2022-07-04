// SPDX-FileCopyrightText: © 2020 Dai Foundation <www.daifoundation.org>
// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.6.12;

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
import {ManagedGemJoin} from "./join-managed.sol";

interface HEVM is Hevm {
    function load(address, bytes32) external returns (bytes32);
    function store(address, bytes32, bytes32) external;
}

interface GemAbstract {
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);
    function approve(address, uint256) external returns (bool);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

interface AAVE  is GemAbstract {}
interface BAL   is GemAbstract {}
interface BAT   is GemAbstract {}
interface COMP  is GemAbstract {}
interface DGD   is GemAbstract {}
interface GNT   is GemAbstract {}
interface GUSD  is GemAbstract {
    function getImplementation() external returns (address);
    function setImplementation(address) external;
}
interface KNC   is GemAbstract {}
interface LINK  is GemAbstract {}
interface LRC   is GemAbstract {}
interface MANA  is GemAbstract {}
interface MATIC is GemAbstract {}
interface OMG {
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);
    function approve(address, uint256) external; // no erc20 compliant
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);

}

interface PAXG is GemAbstract {
    function feeRecipient() external view returns (address);
    function feeParts() external view returns (uint256);
    function feeRate() external view returns (uint256);
}

interface PAXUSD is GemAbstract {}
interface RENBTC is GemAbstract {}
interface REP    is GemAbstract {}
interface TUSD   is GemAbstract {
    function setImplementation(address) external;
}
interface UNI    is GemAbstract {}
interface USDC   is GemAbstract {}
interface USDT {
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);
    function approve(address, uint256) external; // no erc20 compliant
    function transfer(address, uint256) external;
    function transferFrom(address, address, uint256) external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function deprecate(address) external;
}
interface WBTC   is GemAbstract {}
interface YFI    is GemAbstract {}
interface ZRX    is GemAbstract {}
interface WSTETH is GemAbstract {}

interface SAI    is GemAbstract {}

contract DssDeployTest is DssDeployTestBase {

    // --- HEVM ---
    // CHEAT_CODE = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D
    bytes20 constant CHEAT_CODE =
        bytes20(uint160(uint256(keccak256('hevm cheat code'))));

    HEVM hevm2 = HEVM(address(CHEAT_CODE));


    // --- Tokens ---
    AAVE   aave     = AAVE(  0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9);
    BAL    bal      = BAL(   0xba100000625a3754423978a60c9317c58a424e3D);
    BAT    bat      = BAT(   0x0D8775F648430679A709E98d2b0Cb6250d2887EF);
    COMP   comp     = COMP(  0xc00e94Cb662C3520282E6f5717214004A7f26888);
    DGD    dgd      = DGD(   0xE0B7927c4aF23765Cb51314A0E0521A9645F0E2A);
    GNT    gnt      = GNT(   0xa74476443119A942dE498590Fe1f2454d7D4aC0d);
    GUSD   gusd     = GUSD(  0x056Fd409E1d7A124BD7017459dFEa2F387b6d5Cd);
    KNC    knc      = KNC(   0xdd974D5C2e2928deA5F71b9825b8b646686BD200);
    LINK   link     = LINK(  0x514910771AF9Ca656af840dff83E8264EcF986CA);
    LRC    lrc      = LRC(   0xBBbbCA6A901c926F240b89EacB641d8Aec7AEafD);
    MANA   mana     = MANA(  0x0F5D2fB29fb7d3CFeE444a200298f468908cC942);
    MATIC  matic    = MATIC( 0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0);
    OMG    omg      = OMG(   0xd26114cd6EE289AccF82350c8d8487fedB8A0C07);
    PAXG   paxg     = PAXG(  0x45804880De22913dAFE09f4980848ECE6EcbAf78);
    PAXUSD paxusd   = PAXUSD(0x8E870D67F660D95d5be530380D0eC0bd388289E1);
    RENBTC renbtc   = RENBTC(0xEB4C2781e4ebA804CE9a9803C67d0893436bB27D);
    REP    rep      = REP(   0x221657776846890989a759BA2973e427DfF5C9bB);
    TUSD   tusd     = TUSD(  0x0000000000085d4780B73119b644AE5ecd22b376);
    UNI    uni      = UNI(   0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984);
    USDC   usdc     = USDC(  0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    USDT   usdt     = USDT(  0xdAC17F958D2ee523a2206206994597C13D831ec7);
    WBTC   wbtc     = WBTC(  0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    YFI    yfi      = YFI(   0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e);
    ZRX    zrx      = ZRX(   0xE41d2489571d322189246DaFA5ebDe1F4699F498);
    WSTETH wsteth   = WSTETH(0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0);

    SAI    sai      = SAI(   0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359);

    GUSD gusd_store = GUSD( 0xc42B14e49744538e3C239f8ae48A1Eaaf35e68a0);

    function getFeeFor(uint256 _value) internal view returns (uint256) {
        uint256 feeParts = paxg.feeParts();
        uint256 feeRate = paxg.feeRate();
        if (feeRate == 0) {
            return 0;
        }

        return div(mul(_value, feeRate), feeParts);
    }

    // --- Math ---
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;

        return c;
    }

    function bytesToBytes32(bytes memory source) internal pure returns (bytes32 result) {
        assembly {
            result := mload(add(source, 32))
        }
    }

    function giveTokens(address token, uint256 amount) internal {
        // Edge case - balance is already set for some reason
        if (GemAbstract(token).balanceOf(address(this)) == amount) return;

        // Scan the storage for the balance storage slot
        for (uint256 i = 0; i < 200; i++) {
            // Solidity-style storage layout for maps
            {
                bytes32 prevValue = hevm2.load(
                    address(token),
                    keccak256(abi.encode(address(this), uint256(i)))
                );

                hevm2.store(
                    address(token),
                    keccak256(abi.encode(address(this), uint256(i))),
                    bytes32(amount)
                );
                if (GemAbstract(token).balanceOf(address(this)) == amount) {
                    // Found it
                    return;
                } else {
                    // Keep going after restoring the original value
                    hevm2.store(
                        address(token),
                        keccak256(abi.encode(address(this), uint256(i))),
                        prevValue
                    );
                }
            }

            // Vyper-style storage layout for maps
            {
                bytes32 prevValue = hevm2.load(
                    address(token),
                    keccak256(abi.encode(uint256(i), address(this)))
                );

                hevm2.store(
                    address(token),
                    keccak256(abi.encode(uint256(i), address(this))),
                    bytes32(amount)
                );
                if (GemAbstract(token).balanceOf(address(this)) == amount) {
                    // Found it
                    return;
                } else {
                    // Keep going after restoring the original value
                    hevm2.store(
                        address(token),
                        keccak256(abi.encode(uint256(i), address(this))),
                        prevValue
                    );
                }
            }
        }

        // We have failed if we reach here
        assertTrue(false, "TestError/GiveTokens-slot-not-found");
    }

    function testGemJoin_REP() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(rep), 100 * WAD);
        GemJoin repJoin = new GemJoin(address(vat), "REP", address(rep));
        assertEq(repJoin.dec(), 18);

        StairstepExponentialDecrease repCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("REP", address(repJoin), address(pip), address(repCalc));

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

        giveTokens(address(zrx), 100 * WAD);
        GemJoin zrxJoin = new GemJoin(address(vat), "ZRX", address(zrx));
        assertEq(zrxJoin.dec(), 18);

        StairstepExponentialDecrease zrxCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("ZRX", address(zrxJoin), address(pip), address(zrxCalc));

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

        giveTokens(address(omg), 100 * WAD);
        GemJoin2 omgJoin = new GemJoin2(address(vat), "OMG", address(omg));
        assertEq(omgJoin.dec(), 18);

        StairstepExponentialDecrease omgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("OMG", address(omgJoin), address(pip), address(omgCalc));

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

        giveTokens(address(bat), 100 * WAD);
        GemJoin batJoin = new GemJoin(address(vat), "BAT", address(bat));
        assertEq(batJoin.dec(), 18);

        StairstepExponentialDecrease batCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("BAT", address(batJoin), address(pip), address(batCalc));

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

        giveTokens(address(dgd), 100 * 10**9);
        GemJoin3 dgdJoin = new GemJoin3(address(vat), "DGD", address(dgd), 9);
        assertEq(dgdJoin.dec(), 9);

        StairstepExponentialDecrease dgdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("DGD", address(dgdJoin), address(pip), address(dgdCalc));

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

        giveTokens(address(gnt), 100 * WAD);
        GemJoin4 gntJoin = new GemJoin4(address(vat), "GNT", address(gnt));
        assertEq(gntJoin.dec(), 18);

        StairstepExponentialDecrease gntCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GNT", address(gntJoin), address(pip), address(gntCalc));

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

        giveTokens(address(usdc), 100 * 10**6);
        GemJoin5 usdcJoin = new GemJoin5(address(vat), "USDC", address(usdc));
        assertEq(usdcJoin.dec(), 6);

        StairstepExponentialDecrease usdcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDC", address(usdcJoin), address(pip), address(usdcCalc));

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

        giveTokens(address(wbtc), 100 * 10**8);
        GemJoin5 wbtcJoin = new GemJoin5(address(vat), "WBTC", address(wbtc));
        assertEq(wbtcJoin.dec(), 8);

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

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

    function testGemJoin6_TUSD() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(tusd), 100 * WAD);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));
        assertEq(tusdJoin.dec(), 18);

        LinearDecrease tusdCalc = calcFab.newLinearDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("TUSD", address(tusdJoin), address(pip), address(tusdCalc));

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

        giveTokens(address(knc), 100 * WAD);
        GemJoin kncJoin = new GemJoin(address(vat), "KNC", address(knc));
        assertEq(kncJoin.dec(), 18);

        StairstepExponentialDecrease kncCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("KNC", address(kncJoin), address(pip), address(kncCalc));

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

        giveTokens(address(mana), 100 * WAD);
        GemJoin manaJoin = new GemJoin(address(vat), "MANA", address(mana));
        assertEq(manaJoin.dec(), 18);

        StairstepExponentialDecrease manaCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("MANA", address(manaJoin), address(pip), address(manaCalc));

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

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));
        assertEq(usdtJoin.dec(), 6);

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));

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

        giveTokens(address(paxusd), 100 * WAD);
        GemJoin paxusdJoin = new GemJoin(address(vat), "PAXUSD", address(paxusd));
        assertEq(paxusdJoin.dec(), 18);

        StairstepExponentialDecrease paxusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXUSD", address(paxusdJoin), address(pip), address(paxusdCalc));

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

        giveTokens(address(comp), 100 * WAD);
        GemJoin compJoin = new GemJoin(address(vat), "COMP", address(comp));
        assertEq(compJoin.dec(), 18);

        StairstepExponentialDecrease compCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("COMP", address(compJoin), address(pip), address(compCalc));

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

        giveTokens(address(uni), 100 * WAD);
        GemJoin uniJoin = new GemJoin(address(vat), "UNI", address(uni));
        assertEq(uniJoin.dec(), 18);

        StairstepExponentialDecrease uniCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("UNI", address(uniJoin), address(pip), address(uniCalc));

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

        giveTokens(address(aave), 100 * WAD);
        GemJoin aaveJoin = new GemJoin(address(vat), "AAVE", address(aave));
        assertEq(aaveJoin.dec(), 18);

        StairstepExponentialDecrease aaveCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("AAVE", address(aaveJoin), address(pip), address(aaveCalc));

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

    function testGemJoin_MATIC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(matic), 100 * WAD);
        GemJoin maticJoin = new GemJoin(address(vat), "MATIC", address(matic));
        assertEq(maticJoin.dec(), 18);

        StairstepExponentialDecrease maticCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("MATIC", address(maticJoin), address(pip), address(maticCalc));

        matic.approve(address(maticJoin), uint256(-1));
        assertEq(matic.balanceOf(address(this)), 100 * 10**18);
        assertEq(matic.balanceOf(address(maticJoin)), 0);
        assertEq(vat.gem("MATIC", address(this)), 0);
        maticJoin.join(address(this), 10 * 10**18);
        assertEq(matic.balanceOf(address(maticJoin)), 10 * 10**18);
        assertEq(vat.gem("MATIC", address(this)), 10 * 10**18);
        maticJoin.exit(address(this), 4 * 10**18);
        assertEq(matic.balanceOf(address(this)), 94 * 10**18);
        assertEq(matic.balanceOf(address(maticJoin)), 6 * 10**18);
        assertEq(vat.gem("MATIC", address(this)), 6 * 10**18);
    }

    function testGemJoin_LRC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(lrc), 100 * WAD);
        GemJoin lrcJoin = new GemJoin(address(vat), "LRC", address(lrc));
        assertEq(lrcJoin.dec(), 18);

        StairstepExponentialDecrease lrcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("LRC", address(lrcJoin), address(pip), address(lrcCalc));

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

        giveTokens(address(link), 100 * WAD);
        GemJoin linkJoin = new GemJoin(address(vat), "LINK", address(link));
        assertEq(linkJoin.dec(), 18);

        StairstepExponentialDecrease linkCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("LINK", address(linkJoin), address(pip), address(linkCalc));

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

        giveTokens(address(bal), 100 * WAD);
        GemJoin balJoin = new GemJoin(address(vat), "BAL", address(bal));
        assertEq(balJoin.dec(), 18);

        StairstepExponentialDecrease balCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("BAL", address(balJoin), address(pip), address(balCalc));

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

        giveTokens(address(yfi), 100 * WAD);
        GemJoin yfiJoin = new GemJoin(address(vat), "YFI", address(yfi));
        assertEq(yfiJoin.dec(), 18);

        StairstepExponentialDecrease yfiCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("YFI", address(yfiJoin), address(pip), address(yfiCalc));

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

        uint256 ilkAmt = 100 * 100; // GUSD has 2 decimals
        hevm2.store(
            address(gusd_store),
            keccak256(abi.encode(address(this), uint256(6))),
            bytes32(ilkAmt)
        );
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));
        assertEq(gusdJoin.dec(), 2);

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));

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

        giveTokens(address(paxg), 100 * WAD);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        paxgJoin.join(address(this), 10 * 10 ** 18);
        uint256 prevBalanceThis = paxg.balanceOf(address(this));
        uint256 netAmt = 10 * 10 ** 18 - getFeeFor(10 * 10**18);
        uint256 netAmt2 = netAmt - getFeeFor(netAmt);
        assertEq(paxg.balanceOf(address(paxgJoin)), netAmt);
        assertEq(vat.gem("PAXG", address(this)), netAmt);
        paxgJoin.exit(address(this), netAmt);
        assertEq(paxg.balanceOf(address(this)), prevBalanceThis + netAmt2);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
    }

    function testGemJoin5_RENBTC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(renbtc), 100 * 10**8);
        GemJoin5 renbtcJoin = new GemJoin5(address(vat), "RENBTC", address(renbtc));
        assertEq(renbtcJoin.dec(), 8);

        StairstepExponentialDecrease renbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("RENBTC", address(renbtcJoin), address(pip), address(renbtcCalc));

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

        giveTokens(address(tusd), 100 * WAD);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));

        LinearDecrease tusdCalc = calcFab.newLinearDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("TUSD", address(tusdJoin), address(pip), address(tusdCalc));

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

        giveTokens(address(tusd), 100 * WAD);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));

        LinearDecrease tusdCalc = calcFab.newLinearDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("TUSD", address(tusdJoin), address(pip), address(tusdCalc));

        tusd.approve(address(tusdJoin), uint256(-1));
        tusdJoin.join(address(this), 10 ether);
        tusd.setImplementation(0xCB9a11afDC6bDb92E4A6235959455F28758b34bA);
        // Fail here
        tusdJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin7JoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));
        usdt.approve(address(usdtJoin), uint256(-1));

        // Fail here
        usdtJoin.join(address(this), 10 ether);
    }

    function testFailGemJoin7ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(gnt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));
        usdt.approve(address(usdtJoin), uint256(-1));

        usdtJoin.join(address(this), 10 * 10 ** 6);
        // Fail here
        usdtJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin7Join() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));
        usdt.approve(address(usdtJoin), uint256(-1));

        assertEq(usdt.balanceOf(address(this)), 100 * 10 ** 6);
        assertEq(usdt.balanceOf(address(usdtJoin)), 0);
        assertEq(vat.gem("USDT", address(this)), 0);
        // Set owner to address(this)
        hevm2.store(
            address(usdt),
            bytes32(uint256(0)),
            bytesToBytes32(abi.encode(address(this)))
        );
        usdt.deprecate(address(1));
        // Fail here
        usdtJoin.join(address(this), 10 * 10 ** 6);
    }

    function testFailGemJoin7Exit() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));
        usdt.approve(address(usdtJoin), uint256(-1));

        usdtJoin.join(address(this), 10 * 10 ** 6);
        // Set owner to address(this)
        hevm2.store(
            address(usdt),
            bytes32(uint256(0)),
            bytesToBytes32(abi.encode(address(this)))
        );
        usdt.deprecate(address(1));
        // Fail here
        usdtJoin.exit(address(this), 10 * 10 ** 6);
    }

    function testGemJoin7FeeChange() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));

        // auxiliary function added, not in tether source code
        // basisPointsRate = 1, maximumFee = 1
        uint256 basisPointsRate = 100;
        uint256 maximumFee = 100;
        hevm2.store(
            address(usdt),
            bytes32(uint256(3)),
            bytes32(basisPointsRate)
        );
        hevm2.store(
            address(usdt),
            bytes32(uint256(4)),
            bytes32(maximumFee)
        );

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
        uint256 ilkAmt = 100 * 100; // GUSD has 2 decimals
        hevm2.store(
            address(gusd_store),
            keccak256(abi.encode(address(this), uint256(6))),
            bytes32(ilkAmt)
        );
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));
        gusd.approve(address(gusdJoin), uint256(-1));

        // Fail here
        gusdJoin.join(address(this), 10 ether);
    }

    function testFailGemJoin8ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        uint256 ilkAmt = 100 * 100; // GUSD has 2 decimals
        hevm2.store(
            address(gusd_store),
            keccak256(abi.encode(address(this), uint256(6))),
            bytes32(ilkAmt)
        );
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));
        gusd.approve(address(gusdJoin), uint256(-1));

        gusdJoin.join(address(this), 10 * 10 ** 2);
        // Fail here
        gusdJoin.exit(address(this), 10 ether);
    }

    function testFailGemJoin8Join() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        uint256 ilkAmt = 100 * 100; // GUSD has 2 decimals
        hevm2.store(
            address(gusd_store),
            keccak256(abi.encode(address(this), uint256(6))),
            bytes32(ilkAmt)
        );
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));

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
        uint256 ilkAmt = 100 * 100; // GUSD has 2 decimals
        hevm2.store(
            address(gusd_store),
            keccak256(abi.encode(address(this), uint256(6))),
            bytes32(ilkAmt)
        );
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));

        gusd.approve(address(gusdJoin), uint256(-1));
        gusdJoin.join(address(this), 10 * 10 ** 2);
        gusd.setImplementation(address(1));
        // Fail here
        gusdJoin.exit(address(this), 10 * 10 ** 2);
    }

    function testFailGemJoin9JoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(paxg), 100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        // Fail here
        paxgJoin.join(address(this), 1000 ether);
    }

    function testFailGemJoin9ExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(paxg), 100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        paxgJoin.join(address(this), 10 * 10 ** 18);
        // Fail here
        paxgJoin.exit(address(this), 100 ether);
    }

    function testGemJoin9JoinFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(paxg), 100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        uint256 prevRecipientBalance = paxg.balanceOf(paxg.feeRecipient());
        uint256 netAmt = 100 * 10 ** 18 - getFeeFor(100 * 10**18);
        uint256 netAmt2 = netAmt - getFeeFor(netAmt);
        paxgJoin.join(address(this), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(this)), 0);
        assertEq(paxg.balanceOf(address(paxgJoin)), netAmt);
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
        assertEq(vat.gem("PAXG", address(this)), netAmt);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), prevRecipientBalance + getFeeFor(100 * 10**18));
        prevRecipientBalance = paxg.balanceOf(paxg.feeRecipient());
        paxgJoin.exit(address(this), netAmt);
        assertEq(paxg.balanceOf(address(this)), netAmt2);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), prevRecipientBalance + getFeeFor(netAmt));
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
    }

    function testFailGemJoin9JoinFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(paxg), 100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        paxgJoin.join(address(this), 100 * 10 ** 18);
        // Fail here
        paxgJoin.exit(address(this), 100 * 10 ** 18);
    }

    function testGemJoin9JoinDirectFee() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(paxg), 100 * 10 ** 18);
        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));

        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        assertEq(paxg.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        uint256 prevRecipientBalance = paxg.balanceOf(paxg.feeRecipient());
        uint256 netAmt = 100 * 10 ** 18 - getFeeFor(100 * 10**18);
        uint256 netAmt2 = netAmt - getFeeFor(netAmt);
        paxg.transfer(address(paxgJoin), 100 * 10 ** 18);
        paxgJoin.join(address(this));
        assertEq(paxg.balanceOf(address(this)), 0);
        assertEq(paxg.balanceOf(address(paxgJoin)), netAmt);
        assertEq(vat.gem("PAXG", address(this)), netAmt);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), prevRecipientBalance + getFeeFor(100 * 10**18));
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
        prevRecipientBalance = paxg.balanceOf(paxg.feeRecipient());
        paxgJoin.exit(address(this), netAmt);
        assertEq(paxg.balanceOf(address(this)), netAmt2);
        assertEq(paxg.balanceOf(address(paxgJoin)), 0);
        assertEq(vat.gem("PAXG", address(this)), 0);
        assertEq(paxg.balanceOf(paxg.feeRecipient()), prevRecipientBalance + getFeeFor(netAmt));
        assertEq(paxgJoin.total(), paxg.balanceOf(address(paxgJoin)));
    }
 
    function testFailManagedGemJoinJoinWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

        wbtc.approve(address(wbtcJoin), uint256(-1));

        // Fail here
        wbtcJoin.join(address(this), 10 ether);
    }

    function testFailManagedGemJoinExitWad() public {
        deployKeepAuth();
        DSValue pip = new DSValue();
        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        wbtcJoin.join(address(this), 10 * 10 ** 8);
        // Fail here
        wbtcJoin.exit(address(this), address(this), 10 ether);
    }

    function testFailManagedGemJoinJoin() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));

        dssDeploy.deployCollateralFlip("WBTC", address(wbtcJoin), address(pip));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        wbtcJoin.deny(address(this));
        wbtcJoin.join(address(this), 10);
    }

    function testFailManagedGemJoinExit() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        wbtcJoin.join(address(this), 10);
        wbtcJoin.deny(address(this));
        wbtcJoin.exit(address(this), address(this), 10);
    }

    function testFailJoinAfterCageGemJoin2() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(omg), 100 * WAD);
        GemJoin2 omgJoin = new GemJoin2(address(vat), "OMG", address(omg));

        StairstepExponentialDecrease omgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("OMG", address(omgJoin), address(pip), address(omgCalc));

        omg.approve(address(omgJoin), uint256(-1));
        omgJoin.join(address(this), 10);
        omgJoin.cage();
        omgJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin3() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(dgd), 100 * WAD);
        GemJoin3 dgdJoin = new GemJoin3(address(vat), "DGD", address(dgd), 9);

        StairstepExponentialDecrease dgdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("DGD", address(dgdJoin), address(pip), address(dgdCalc));

        dgd.approve(address(dgdJoin), uint256(-1));
        dgdJoin.join(address(this), 10);
        dgdJoin.cage();
        dgdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin4() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(gnt), 100 * WAD);
        GemJoin4 gntJoin = new GemJoin4(address(vat), "GNT", address(gnt));

        StairstepExponentialDecrease gntCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GNT", address(gntJoin), address(pip), address(gntCalc));

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

        giveTokens(address(usdc), 100 * WAD);
        GemJoin5 usdcJoin = new GemJoin5(address(vat), "USDC", address(usdc));

        StairstepExponentialDecrease usdcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDC", address(usdcJoin), address(pip), address(usdcCalc));

        usdc.approve(address(usdcJoin), uint256(-1));
        usdcJoin.join(address(this), 10);
        usdcJoin.cage();
        usdcJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin6() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(tusd), 100 * WAD);
        GemJoin6 tusdJoin = new GemJoin6(address(vat), "TUSD", address(tusd));

        LinearDecrease tusdCalc = calcFab.newLinearDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("TUSD", address(tusdJoin), address(pip), address(tusdCalc));

        tusd.approve(address(tusdJoin), uint256(-1));
        tusdJoin.join(address(this), 10);
        tusdJoin.cage();
        tusdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin7() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(usdt), 100 * 10**6);
        GemJoin7 usdtJoin = new GemJoin7(address(vat), "USDT", address(usdt));

        StairstepExponentialDecrease usdtCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("USDT", address(usdtJoin), address(pip), address(usdtCalc));

        usdt.approve(address(usdtJoin), uint256(-1));
        usdtJoin.join(address(this), 10);
        usdtJoin.cage();
        usdtJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin8() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(gusd), 100 * 10**2);
        GemJoin8 gusdJoin = new GemJoin8(address(vat), "GUSD", address(gusd));

        StairstepExponentialDecrease gusdCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("GUSD", address(gusdJoin), address(pip), address(gusdCalc));

        gusd.approve(address(gusdJoin), uint256(-1));
        gusdJoin.join(address(this), 10);
        gusdJoin.cage();
        gusdJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageGemJoin9() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        GemJoin9 paxgJoin = new GemJoin9(address(vat), "PAXG", address(paxg));
        StairstepExponentialDecrease paxgCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("PAXG", address(paxgJoin), address(pip), address(paxgCalc));

        paxg.approve(address(paxgJoin), uint256(-1));
        paxgJoin.join(address(this), 100 * 10 ** 18);
        paxgJoin.cage();
        // Fail here
        paxgJoin.join(address(this), 100 * 10 ** 18);
    }

    function testFailJoinAfterCageAuthGemJoin() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(sai), 100 * WAD);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));

        StairstepExponentialDecrease saiCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("SAI", address(saiJoin), address(pip), address(saiCalc));

        sai.approve(address(saiJoin), uint256(-1));
        saiJoin.join(address(this), 10);
        saiJoin.cage();
        saiJoin.join(address(this), 10);
    }

    function testFailJoinAfterCageManagedGemJoin() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        wbtcJoin.join(address(this), 10);
        wbtcJoin.cage();
        wbtcJoin.join(address(this), 10);
    }

    function testTokenSai() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(sai), 100 * WAD);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));
        assertEq(saiJoin.dec(), 18);

        dssDeploy.deployCollateralFlip("SAI", address(saiJoin), address(pip));

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

        giveTokens(address(sai), 100 * WAD);
        AuthGemJoin saiJoin = new AuthGemJoin(address(vat), "SAI", address(sai));

        StairstepExponentialDecrease saiCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("SAI", address(saiJoin), address(pip), address(saiCalc));

        sai.approve(address(saiJoin), uint256(-1));
        saiJoin.deny(address(this));
        saiJoin.join(address(this), 10);
    }

    function testManagedGemJoin_WBTC() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(wbtc), 100 * 10**8);
        ManagedGemJoin wbtcJoin = new ManagedGemJoin(address(vat), "WBTC", address(wbtc));
        assertEq(wbtcJoin.dec(), 8);

        StairstepExponentialDecrease wbtcCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WBTC", address(wbtcJoin), address(pip), address(wbtcCalc));

        wbtc.approve(address(wbtcJoin), uint256(-1));
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 0);
        assertEq(vat.gem("WBTC", address(this)), 0);
        wbtcJoin.join(address(this), 10 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 10 * 10 ** 8);
        assertEq(vat.gem("WBTC", address(this)), 10 * 10 ** 18);
        wbtcJoin.exit(address(this), address(this), 4 * 10 ** 8);
        assertEq(wbtc.balanceOf(address(wbtcJoin)), 6 * 10 ** 8);
        assertEq(vat.gem("WBTC", address(this)), 6 * 10 ** 18);
        assertEq(wbtc.balanceOf(address(this)), 94 * 10 ** 8);
    }

    function testGemJoin_WSTETH() public {
        deployKeepAuth();
        DSValue pip = new DSValue();

        giveTokens(address(wsteth), 100 * WAD);
        GemJoin wstethJoin = new GemJoin(address(vat), "WSTETH", address(wsteth));
        assertEq(wstethJoin.dec(), 18);

        StairstepExponentialDecrease wstethCalc = calcFab.newStairstepExponentialDecrease(address(pause.proxy()));
        dssDeploy.deployCollateralClip("WSTETH", address(wstethJoin), address(pip), address(wstethCalc));

        wsteth.approve(address(wstethJoin), uint256(-1));
        assertEq(wsteth.balanceOf(address(this)), 100 ether);
        assertEq(wsteth.balanceOf(address(wstethJoin)), 0);
        assertEq(vat.gem("WSTETH", address(this)), 0);
        wstethJoin.join(address(this), 10 ether);
        assertEq(wsteth.balanceOf(address(wstethJoin)), 10 ether);
        assertEq(vat.gem("WSTETH", address(this)), 10 ether);
        wstethJoin.exit(address(this), 4 ether);
        assertEq(wsteth.balanceOf(address(this)), 94 ether);
        assertEq(wsteth.balanceOf(address(wstethJoin)), 6 ether);
        assertEq(vat.gem("WSTETH", address(this)), 6 ether);
    }
}
