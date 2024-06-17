// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FunctionModifier {
address public owner;
uint public x =10;
bool public locked;

constructor (){
    owner= msg.sender;
} 

modifier onlyOwner() {
    require(owner==msg.msg.sender, "not valid");
    _;
    
}
modifier validAddress(address addr){
    require(addr !=address(0), "Not valid address");
    _;
}

function changeOwner() public onlyOwner validAddress  (address newOwner) {
    owner = newOwner;
    
}

modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }
function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
    
