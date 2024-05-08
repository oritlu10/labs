SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "/home/sarih/labs/task/cp.sol"
import "../Wallet/Wallet.sol"
contract split {

    Wallet w;

    constructor(){
     address[40] public addressArray;
     W = new Wallet;
     uint amount = 60;
    }
    function splitMoney(uint amount) public returns(address addressArray ){
      uint amountSplit= amount/addressArray.length;
      for (uint i = 0; i < addressArray.length; i++) {
           w.transfer(addressArray[i].(msg.sender),amountSplit);
      }
      return addressArray;
    }

}
