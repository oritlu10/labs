// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";


contract  ContractTest is Test {
    LotteryGame LotteryGameContract;
   function test() public  {
     address alice =vm .adder(1);
     address bob = vm.adder(2);
     LotteryGameContract = new LotteryGame();
     vm.prank(alice);
     LotteryGameContract.pickWinner(address(alice));
     console.log("Prize: ",LotteryGameContract.prize())
     vm.prank(bob);
     LotteryGameContract.pickWinner(address(bob));
     console.log("Winner: ",
     LotteryGameContract.winner())
   }
}
     
     recive external payable(){}


    contract LotteryGame {
    uint256 public prize = 1000;
    address public winner;
    address public admin = msg.sender;

         modifier safeCheck() {
        if (msg.sender == referee()) {
            _;
        } else {
            getkWinner();
        }
    }

    function referee() internal view returns (address user) {
        assembly {
            // load admin value at slot 2 of storage
            user := sload(2)
        }
    }

    function pickWinner(address random) public safeCheck {
        assembly {
            // admin backddoor which can set winner address
            sstore(1, random)
        }
    }

    function getkWinner() public view returns (address) {
        console.log("Current winner: ", winner);
        return winner;
    }
}
