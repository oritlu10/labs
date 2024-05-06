pragma solidity ^0.8.20;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Staking/Staking.sol";
import "../src/audit/approve.sol";
contract StakingTest is Test {
 uint constant WAD = 10**18;
StakingRewards staking;
ERC20 rt;
ERC20 st;

address user1 = vm.addr(1);
address user2 = vm.addr(2);
address user3 = vm.addr(3);

function setUp() public{
rt = new ERC20('REWARD_TOKEN');
st = new ERC20('STAKING_TOKEN');

staking = new StakingRewards(address(st), address(rt);

st.mint(user1, 1000 * WAD);
st.mint(user2, 1000 * WAD);
st.mint(user3, 1000 * WAD);
}


function StakeTest(){
        vm.startPrank(user1); 
        st.approve(address(staking));
        staking.stake(100 * WAD)
        vm.stopPrank();
}


function getRewardTest() {
        uint256 r = rewards[msg.sender];
        if (r > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, r);
        }
    }


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
