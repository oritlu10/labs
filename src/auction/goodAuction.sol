// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/console.sol";
import "@openzeppelin/ERC721/ERC721.sol";
import "@openzeppelin/ERC20/ERC20.sol";
import "/home/user/Documents/labs/src/audit/approve.sol"


//import "./SafeMath.sol";

contract Auction  {
  IERC721 public immutable auctionToken;

    struct suggest{

        bool flag;
        uint amount;
        uint tokenId;


    }
    address payable private owner;
    mapping(address => suggest) public suggestions;
    uint256 max;
    bool start=false;
    uint end;
    address[] public stack;    
    uint256 public constant SEVEN_DAYS = 604800;// שבעה ימים בשניות של קיום המכירה
    address winnerAddress;
     constructor(address at) {
        owner = payable(msg.sender);
        end = block.timestamp + SEVEN_DAYS;
        start = true;
        auctionToken = IERC721(at);
        auctionToken.mint(1);
       
    }
    modifier onlyOwner(){
        require(
            owner == msg.sender ,
            "Only the owner and the gabaim allowed to withdraw Ether");
            _;
    }

    //Inserting a new offer
    function addSuggest(uint amount, uint tokenId) public {

        require(start , "The auction doesnt start");
        if(block.timestamp < end){
            //Entering a new offer only if the previous offer is smaller than it
            require (suggestions[stack[stack.length]].amount < amount, "You should offer a higher amount");
              
                //In case the offerer already exists
            if (suggestions[msg.sender].amount > 0 ){ 

                uint lastSuggest = suggestions[msg.sender].amount;
                require(msg.sender.balance >= amount , "you do not have enough money");
                suggestions[msg.sender].amount = amount;
                suggestions[msg.sender].tokenId = tokenId;
                 //Receiving the money of the new offer of an existing customer
                 transferFrom(msg.sender,address(this),amount);
                 //The refund of the previous offer
                payable(suggestions[msg.sender]).transfer(lastSuggest);                     
                stack.push(msg.sender);
            }
            else {//new user

                require(msg.sender.balance >=amount , "you do not have enough money");
                suggestions[msg.sender].amount= amount;
                suggestions[msg.sender].tokenId = tokenId;
                suggestions[msg.sender].flag = true;
                transferFrom(msg.sender, address(this) , amount);
                stack.push(msg.sender);
            }
       }
       else{
            start=false;
            endAuction();
        }

    }
    //Removal of an offer
    function removeSugget() public {

        require(start , "The auction doesnt start");
        require(block.timestamp < end , "The Auction is over");
        require(suggestions[msg.sender].flag == true, "");

            payable(suggestions[msg.sender]).transfer(suggestions[msg.sender].amount);    
            suggestions[msg.sender].flag = false;
        }


    //A function that is performed only when seven days have passed since the activation of the contract
    function endAuction() external onlyOwner{

        uint i= stack.length; 
        for(;i>=0 && suggestions[stack[i]].flag == false; i--){}
        winnerAddress = stack[i];
        auctionToken.approve(stack[i],suggestions[stack[i]].tokenId);
        auctionToken.transferFrom(address(this),stack[i], suggestions[stack[i]].tokenId);
        for(uint j= i-1; j>=0; j--){
            if(suggestions[stack[i]].flag)
            //The refund of all unsuccessful bids after the sale has ended
             payable(suggestions[stack[j]]).transfer(suggestions[stack[j]].amount);         
        }

    }
}
