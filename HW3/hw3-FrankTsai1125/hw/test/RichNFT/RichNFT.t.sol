// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {RichNFTBaseTest} from "./RichNFTBase.t.sol";

import "../../src/interface.sol";

contract RichNFTTest is RichNFTBaseTest {
    function testExploit() public validation {}
}
