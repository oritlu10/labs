SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "/home/sarih/labs/task/cp.sol"

contract testSplit in Test {

    testSplit ts;

    constructor(){
     ts = new testSplit;
    }
    function testSplitMoney() public {
         uint amount=80
         ts.splitMoney(amoumt);
         uint amountPerBeneficiary = amount / addressArray.length;
         assert.Eq(ts.balanceOf(addressArray[i]), amountPerBeneficiary, "Amount was not distributed equally");
    }

}
