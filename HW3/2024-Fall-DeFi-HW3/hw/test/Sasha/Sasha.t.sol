// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {SashaBaseTest} from "./SashaBase.t.sol";

import "../../src/interface.sol";

contract SashaTest is SashaBaseTest {
    function testExploit() public validation {}
}
