// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

/*
Name: Over-Permissive Approve Scam

Description:
This vulnerability is associated with the approval process in ERC20 tokens. 
In this scenario, Alice approves Eve to transfer an unlimited (type(uint256).max) amount of tokens 
from Alice's account. Later, Eve exploits this permission and transfers 1000 tokens from Alice's account to hers.

Most current scams use approve or setApprovalForAll to defraud your transfer rights. Be especially careful with this part.

Mitigation:
Users should only approve the amount of tokens necessary for the operation at hand. 
*/

contract ContractTest is Test {
    ERC20 ERC20Contract;
    address orit = vm.addr(1);
    address kobi = vm.addr(2);

    function testApproveScam() public {
        ERC20Contract = new ERC20();
        ERC20Contract.mint(1000);
        ERC20Contract.transfer(address(orit), 1000);

        vm.prank(orit);
        // Be Careful to grant unlimited amount to unknown website/address.
        // Do not perform approve, if you are sure it's from a legitimate website.
        // Orit granted approval permission to Kobi.
        ERC20Contract.approve(address(kobi), type(uint256).max);

        console.log(
            "Before exploiting, Balance of Kobi:",
            ERC20Contract.balanceOf(kobi)
        );
        console.log(
            "Due to Orit granted transfer permission to Kobi, now Kobi can move funds from Orit"
        );
        vm.prank(kobi);
        // Now, Kobi can move funds from Orit.
        ERC20Contract.transferFrom(address(orit), address(kobi), 1000);
        console.log(
            "After exploiting, Balance of Kobi:",
            ERC20Contract.balanceOf(kobi)
        );
        console.log("Exploit completed");
    }

    receive() external payable {}
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Test example";
    string public symbol = "Test";
    uint8 public decimals = 18;

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
