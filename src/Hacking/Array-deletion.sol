// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

/*
Name: Array Deletion Oversight: leading to data inconsistency

Description:
In Solidity where improper deletion of elements from dynamic arrays can result in data inconsistency. 
When attempting to delete elements from an array, if the deletion process is not handled correctly, 
the array may still retain storage space and exhibit unexpected behavior. 


Mitigation:  
Option1: By copying the last element and placing it in the position to be removed.
Option2: By shifting them from right to left.

*/

contract ContractTest is Test {
    ArrayDeletionBug arrayDeletionBugContract;
    FixedArrayDeletion fixedArrayDeletionContract;

    function setUp() public {
        arrayDeletionBugContract = new ArrayDeletionBug();
        fixedArrayDeletionContract = new FixedArrayDeletion();
    }

    function testArrayDeletion() public {
        arrayDeletionBugContract.myArray(1);
        //delete incorrectly
        arrayDeletionBugContract.deleteElement(1);
        arrayDeletionBugContract.myArray(1);
        arrayDeletionBugContract.getLength();
    }

    function testFixedArrayDeletion() public {
        fixedArrayDeletionContract.myArray(1);
        //delete incorrectly
        fixedArrayDeletionContract.deleteElement(1);
        fixedArrayDeletionContract.myArray(1);
        fixedArrayDeletionContract.getLength();
    }

    receive() external payable {}
}

contract ArrayDeletionBug {
    uint[] public myArray = [1, 2, 3, 4, 5];

    function deleteElement(uint index) external {
        require(index < myArray.length, "Invalid index");
        delete myArray[index];
    }

    function getLength() public view returns (uint) {
        return myArray.length;
    }
}

contract FixedArrayDeletion {
    uint[] public myArray = [1, 2, 3, 4, 5];

    //Mitigation 1: By copying the last element and placing it in the position to be removed.
    function deleteElement(uint index) external {
        require(index < myArray.length, "Invalid index");

        // Swap the element to be deleted with the last element
        myArray[index] = myArray[myArray.length - 1];

        // Delete the last element
        myArray.pop();
    }

    /*Mitigation 2: By shifting them from right to left.
    function deleteElement(uint index) external {
        require(index < myArray.length, "Invalid index");
        
        for (uint i = _index; i < myArray.length - 1; i++) {
            myArray[i] = myArray[i + 1];
        }
        
        // Delete the last element
        myArray.pop();
    }
    */
    function getLength() public view returns (uint) {
        return myArray.length;
    }
}
