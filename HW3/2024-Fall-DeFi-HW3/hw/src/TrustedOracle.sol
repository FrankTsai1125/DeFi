// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./interface.sol";
import "forge-std/console.sol";

interface ITrustedOracle {
    function getPrice() external view returns (uint256);
}

contract TrustedOracle {
    address public owner;

    address[] oracles;

    event AddNewOracle(address oracle);

    constructor() payable {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    function addOracle(address oracle) external payable onlyOwner {
        oracles.push(oracle);
        emit AddNewOracle(oracle);
    }

    function getAveragePrice() external payable returns (uint256) {
        uint256 price = 0;
        uint256 count = getOracleCount();
        for (uint256 i = 0; i < count; i++) {
            
            price += ITrustedOracle(oracles[i]).getPrice();
        }

        return price / count;
    }

    function getOracleCount() public view returns (uint256) {
        return oracles.length;
    }
}

// TODO: Complete the chainlink oracle implementation

contract ChainlinkOracle {
    address public trustedOracle;
    constructor(address _trustedOracle) {
       trustedOracle = _trustedOracle; //
       console.log(trustedOracle);
    }

    function getPrice() public view returns (uint256) {
        
        (bool success,bytes memory data) = address(trustedOracle).staticcall(abi.encodeWithSignature("latestRoundData()"));
        (
        uint80 roundID,
        int price,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
        ) = abi.decode(data, (uint80, int, uint256, uint256, uint80));

        return uint256(price); // 返回價格
    }

}

