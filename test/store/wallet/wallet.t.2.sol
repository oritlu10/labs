pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/CollectorsWallet.sol";

contract collectorsTest is Test {
    collectorsWallet public walletC;

    function setUp() public {
        walletC = new collectorsWallet();
    }

    function testReceive() public {
        address randomAddress = vm.addr(1234); // create random address
        vm.startPrank(randomAddress); // send from random address
        uint256 amount = 100;
        vm.deal(randomAddress, amount); // put money in this wallet

        uint256 initialBalance = address(walletC).balance; // the balance in the begining (before transfer)
        payable(address(walletC)).transfer(50); // move 50 to the contract
        uint256 finalBalance = address(walletC).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + 50);

        vm.stopPrank();
    }

    function testAllowedWithdraw() external {
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        // address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address

        // vm.expectRevert();
        walletC.withdraw(withdrawAmount);
        vm.stopPrank();
    }

    function testUpdateCollectors() public {
        address oldCollector = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
        address newCollector = 0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b;
        
        // address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        address userAddress = vm.addr(1); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        vm.expectRevert();
        walletC.updateCollectors(oldCollector, newCollector);

        // vm.startPrank(userAddress); // send from random address
        // vm.expectRevert();
        // walletC.updateCollectors(oldCollector, newCollector);
        vm.stopPrank();

        // why it is not work?
        // assert(walletC.collectors()[newCollector] == 1);
        // assert(walletC.owner() == 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f);
        // assert(walletC.collectors()[oldCollector] == 0);
    }

    function testGetBalance() public {
        // why it is not work? 
        // assertEq(walletC.getBalance(), 50 , "not equals"); 
        assertEq(walletC.getBalance(), address(walletC).balance , "not equals");
    }
}
