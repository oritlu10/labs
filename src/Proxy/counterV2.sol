// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract CounterV2 {
    uint256 public count;
    function inc() external{
        count +=1;   
    }
    function dec() external {
        count -=1;
    }
}
