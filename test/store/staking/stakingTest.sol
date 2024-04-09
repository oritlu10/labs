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

    }
    function testDeposit() public{
        
        uint256 initialPoolBalance = staking.poolBalance();
        console.log(initialPoolBalance);
        uint256 depositAmount = 100
        staking.deposit(depositAmount);
        uint256 finalPoolBalance = staking.poolBalance();
        console.log(finalPoolBalance);
        assertEq(finalPoolBalance, initialPololBalance + depositAmount);
        
    }
    function testWithdraw() public{

    }
}
