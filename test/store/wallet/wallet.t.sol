// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/test/wallet/wallet.sol";

contract wallet {
    /// @dev Address of the  contract.
    Wallet public wallet;

    /// @dev Setup the testing environment.
    function setUp() public {
        wallet = new wallet();
        gabaim = msg.sender;
    }

    function testOwnerWithdraw() public {
        uint256 initialBalance = address(wallet).balance;

        uint256 amount = 1 ether;

        wallet.withdraw(amount);

        Assert.equal(address(wallet).balance, initialBalance - amount, "Owner should successfully withdraw ether");
    }

    function testGabaimWithdraw()public{
        uint256 initialBalance = address(wallet).balance;
        uint256 amount = 1 ether;
       
        require(wallet.gabaim[msg.sender]==1,"The caller shouldn't be gabaim");

        wallet.withdraw(amount);

        Assert.equal(address(wallet).balance, initialBalance - amount, "Gabaim should successfully withdraw ether");
    }

    function testGetAndSetBalance()(uint256 value) public {
        wallet.setBalance(value);
        console.log(value);
        console.log(wallet.getBalance());
        assertEq(value, wallet.getBalance());
    }
}
