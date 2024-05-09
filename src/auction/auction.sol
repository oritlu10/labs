// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/console.sol";
import "@openzeppelin/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol",

contract Auction is ERC20, ERC721 {

    
    struct suggest{

        bool flag = false;
        uint amount;

    }

    address payable private owner;
    mapping(address => suggest) public suggestions;
    uint256 max;
    bool start = false;
    uint end;
    address[] public stack;


     constructor() {
        owner = payable(msg.sender);
        end = block.timestamp() + 7;
        start = true;
       
    }
    modifier onlyOwner(){
        require(
            owner == msg.sender ,
            "Only the owner and the gabaim allowed to withdraw Ether");
            _;
    }

    function addSuggest() public {//הכנסת הצעה חדשה

        require(start , "The auction doesnt start");
        require(block.timestamp < end , "The Auction is over");
        require (suggestions(stack[stack.length]).amoumt < msg.sender, "You should offer a higher amount"){  //הכנסת הצעה חדשה רק במקרה שההצעה הקודמת קטנה ממנה

            if (suggestions[msg.sender].amoumt > 0 ){ //במקרה שהבן אדם כבר קיים

            uint lastSuggest = suggestions[msg.sender].amoumt;
            require(msg.sender.balance >=msg.value , "you do not have enough money");
            suggestions[msg.sender].amoumt = msg.value;
            ERC20.transferFrom(msg.sender, address(this) , msg.value);
            ERC20.transfer(msg.sender, lastSuggest);
            stack.push(msg.sender);
        }
        else {//משתמש חדש

            require(msg.sender.balance >=msg.value , "you do not have enough money");
            suggestions[msg.sender].amoumt= msg.value;
            suggestions[msg.sender].flag = true;
            ERC20.transferFrom(msg.sender, address(this) , msg.value);
            stack.push(msg.sender);
        }

       }

    }

    function removeSugget() public {

        require(start , "The auction doesnt start");
        require(block.timestamp < end , "The Auction is over");
        require(suggestions[msg.sender].flag == true){

            suggestions[msg.sender].flag = false;
        }
    }
}