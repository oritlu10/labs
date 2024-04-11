// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../new_project/src/MyToken.sol";

import "../../src/Staking/Staking.sol";

contract StakingTest is Test{

    Staking  public staking;

 
      address userAddress = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;