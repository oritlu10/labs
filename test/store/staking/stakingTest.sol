// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../new_project/src/MyToken.sol";

import "../../src/Staking/Staking.sol";

contract StakingTest is Test{

    Staking  public staking;
    MyToken token;

    function setUp() public {
        token = new MyToken();
        staking = new Staking(token);
    }

    function testDeposit() public {
        uint256 amount = 1000; 
        token.mint(msg.sender, amount);
        token.approve(address(staking), amount);
        staking.deposit(amount);
        assertEq(staking.poolBalance(), amount, "Pool balance should match deposited amount");
    }

    function testWithdraw() public {
        uint256 initialBalance = 1000; 
        uint256 withdrawAmount = 500; 
        token.mint(address(staking), initialBalance);
        staking.deposit(initialBalance);
        uint256 initialUserBalance = token.balanceOf(msg.sender);
        staking.withdraw(withdrawAmount);
        uint256 finalUserBalance = token.balanceOf(msg.sender);
        assertEq(finalUserBalance - initialUserBalance, withdrawAmount, "User balance should increase by withdraw amount");
        assertEq(staking.poolBalance(), initialBalance - withdrawAmount, "Pool balance should decrease by withdraw amount");
    }

    function testCalculateDays() public {
        uint256 amount = 1000;
        token.mint(address(this), amount);
        token.approve(address(staking), amount);
        staking.deposit(amount);
        assertEq(staking.database(msg.sender).length, 1, "There should be one entry in the user's database");
     //   uint256 expectedSum = amount * 7;
        AssertEq(staking.calculateDays(amount), amount, "Calculated sum should match expected sum");
    }

    function testCalculateSum() public {
        uint256 sum = 1000;
        uint256 rate = 2;
        uint256 poolBalance = 5000;
        uint256 expectedBonus = (sum * rate * 1000000000) / poolBalance;
        assertEq(staking.calculateSum(sum) expectedBonus, "Calculated bonus should match expected bonus");
    }
}

