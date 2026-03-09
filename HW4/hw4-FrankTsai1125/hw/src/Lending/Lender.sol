// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract Lender is ReentrancyGuard, Ownable {
    // State Variables
    address[] public allowedTokens;
    mapping(address => address) public tokenToPriceFeed;
    mapping(address => mapping(address => uint256)) public accountToTokenDeposits;
    mapping(address => mapping(address => uint256)) public accountToTokenBorrows;

    // Constant Variable
    uint256 public constant LIQUIDATION_REWARD = 5; // 5% Liquidation Reward
    uint256 public constant LIQUIDATION_FACTOR = 80; // At 80% Loan to Value Ratio, the loan can be liquidated
    uint256 public constant CLOSE_FACTOR = 50; // Only 50% of asset can be liquidated at one time
    uint256 public constant MIN_HEALTH_FACTOR = 1e18;

    // event
    event AllowedTokenConfiguration(address indexed token, address indexed priceFeed);
    event TokenSupply(address indexed account, address indexed token, uint256 indexed amount);
    event TokenBorrow(address indexed account, address indexed token, uint256 indexed amount);
    event TokenWithdraw(address indexed account, address indexed token, uint256 indexed amount);
    event TokenRepay(address indexed account, address indexed token, uint256 indexed amount);
    event Liquidate(
        address indexed account,
        address indexed repayToken,
        address indexed rewardToken,
        uint256 halfDebtInEth,
        address liquidator
    );

    // Error
    error TransferFailed();
    error TokenNotAllowed(address token);
    error NeedsMoreThanZero();

    // Modifier

    // Constructor
    constructor() Ownable(msg.sender) {}

    function supply(address token, uint256 amount) external {}
    function withdraw(address token, uint256 amount) external {}

    function borrow(address token, uint256 amount) external {}

    function repay(address token, uint256 amount) external {}

    function liquidate(address account, address repayToken, address rewardToken) external {}

    function viewCollateral(address user) public view returns (uint256) {}

    function viewDebt(address user) public view returns (uint256) {}

    function getValueInETH(address token, uint256 amount) public view returns (uint256) {}

    function getTokenValueFromEth(address token, uint256 totalValueInETH) public view returns (uint256) {}

    function healthFactor(address account) public view returns (uint256) {}
    function setAllowedToken(address token, address priceFeed) external onlyOwner {}
}
