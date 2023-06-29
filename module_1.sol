// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract proj_1{

    address public owner;
    mapping (address => uint) amount;

    constructor (){

        owner = msg.sender;

    }

    function contri() public payable{

        if(msg.value <= 1000 wei){

            revert("The amount should be greater than 1000 Wei");
        }

        amount[msg.sender] += msg.value; 

    }

    function addMem(address _add) public payable{

        require(msg.sender ==  owner, "You can't add a member");

        assert (_add != address(0));

        amount[_add] += msg.value;
    }

    function changeOwner(address _new) public{

        require(msg.sender == owner, "You are not the Owner");
        owner = _new;

    }


}