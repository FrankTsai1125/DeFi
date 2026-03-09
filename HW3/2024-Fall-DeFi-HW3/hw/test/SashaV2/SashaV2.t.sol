// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {SashaV2BaseTest} from "./SashaV2Base.t.sol";

import "../../src/interface.sol";

contract SashaV2Test is SashaV2BaseTest {
    function testExploit() public validation {}
}
