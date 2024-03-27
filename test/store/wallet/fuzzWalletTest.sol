SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/Wallet/Wallet.sol";

contract FuzzWalletTest is Test{

    Wallet public W;
    address randomUser = vm.addr(1234); // create random user
    function  setUp() public{
        W = new Wallet();
    }

       function testReceive(uint256 amount) public {
        uint256 balance = wallet.balance();
        vm.startPrank(randomUser); // send from random address
        vm.deal(randomUser, amount); // put money in this wallet
        payable(address(W)).transfer(amount); // move amount to the contract
        assertEq(wallet.balance(), balance+ amount);
        vm.stopPrank();
        
    }
    function testAllowedWithdraw(uint256 amount) external {
        vm.deal(randomUser, amount);
        vm.startPrank(randomUser); // send from random address
        console.log(amount);
        payable(address(w)).transfer(amount);
        uint256 balance = wallet.balance();
        W.withdraw(amount);
        assertEq(wallet.balance(), initialBalance - amount);
        vm.stopPrank();
    }

    function testNotAllowedWithdraw(uint256 amount) external {
        address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        console.log(amount);
        vm.expectRevert();
        W.withdraw(amount);
     }

    function testUpdate(address oldGabai, address newGabai ) public{
       
        //address userAddress = vm.addr(1); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        if(oldGabai=newGabai){
            vm.expectRevert("the new gabai already gabai");
            W.update(oldGabai, newGabai);
        }
        else{
            W.update(oldGabai, newGabai);
            assertEq(W.gabaim(newGabai),1);
            assertEq(W.gabaim(oldGabai),0);
        }
        vm.stopPrank();

    }
    function testGetBalance() public{
       
        // assertEq(wallet.getBalance(), 50 , "not equals"); 
        assertEq(W.getBalance(), address(W).balance , "not equals");
    }

}
