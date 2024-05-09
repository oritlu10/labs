SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "/home/sarih/labs/task/cp.sol"
import "../Wallet/Wallet.sol"
contract split {


    constructor(){
     address[40] public addressArray;
    }
    function splitMoney() public payable {
      uint amountSplit= msg.value/addressArray.length;
      for (uint i = 0; i < addressArray.length; i++) {
           payable(addressArray[i].transfer(amountSplit);
      }
   
    }
    function addAddress(address newAddress) public(){
      addressArray.push(newAddress)
    } 

}
