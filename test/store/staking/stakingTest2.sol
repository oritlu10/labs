pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Staking/Staking.sol";
import "../src/audit/approve.sol";
contract StakingTest is Test {


user1.address


function withdraw( uint256 amount) external updateReward(msg.sender) {
        uint256 amount = 1000;
        require(amount > 0, "amount = 0");
        intinalBalance = balances[msg.sender]
        balances[msg.sender] -= amount;
        beforeTransfer = staked
        staked -= amount;
        stakingToken.transfer(msg.sender, amount);
        assertEq( intinalBalance, intinalBalance+1000 ,"not equal")
        assertEq( beforeTransfer, intinalBalance+1000 ,"not equal")
    }
