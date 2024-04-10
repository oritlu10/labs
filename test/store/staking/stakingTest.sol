// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/Staking/Staking.sol";

contract StakingTest is Test{

    Staking public staking;
    function setUp() public{
        staking = new Staking();
        address owner = address(this); // Address of the test contract itself


    }
    function testDeposit() public{
        
        uint256 initialPoolBalance = staking.poolBalance();
        console.log(initialPoolBalance);
        staking.deposit(100);
        uint256 finalPoolBalance = staking.poolBalance();
        console.log(finalPoolBalance);
        assertEq(finalPoolBalance, initialPololBalance - depositAmount);
        
    }
    function testWithdraw() public{
        uint256 depositAmount = 100;
        staking.deposit(depositAmount)();
        uint256 initialPoolBalance = address(this).poolBalance();
        uint256 withdrawAmount = 50;
        staking.withdraw(withdrawAmount);
        uint256 finalPoolBalance = address(this).poolBalance();
    }

    function testCalculateSum() public {
        staking.poolBalance = 1000;
        staking.percent = 1000;
        staking.poolsRich = 1000000000;
        uint256 result = staking.calculateSum(500);
        assertEq(result, 5000000000, "calculateSum result incorrect");

   }

   function testCalculateDays() public {
        staking.database[owner].push(Staking.User({ date: block.timestamp - 604800, sum: 100 }));
        staking.database[owner].push(Staking.User({ date: block.timestamp - 302400, sum: 200 }));
        uint256 result = staking.calculateDays(150);
        assertEq(result, 300, "calculateDays result incorrect");

}
