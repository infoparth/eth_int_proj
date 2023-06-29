// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Test {

address public owner;

mapping (address => address[]) members;
event memberAdded ( address indexed member, address indexed memadd);
event memberRemoved (address indexed member, address indexed memrem);
event memberFound (address indexed memfrom, address indexed member);
event ownerChanged (address indexed owner);

constructor(){

    owner = msg.sender;
}

function addMember(address _add) public {

    require(_add != address(0), "This address can't be added, add a valid address." );
    members[msg.sender].push(_add);
    emit memberAdded(msg.sender, _add);
}

function getMembers() public view returns(address[] memory){
    return members[msg.sender];
}

function checkMember(address[] memory _arr, address _check) public returns (uint){

     uint val = _arr.length;

     for(uint i = 0; i <  val; i++){

        if (_arr[i] == _check){
            emit memberFound(msg.sender, _check);
            return i + 1;
        }

     }

     return 0;
}

function removeMember(address _rem) public{

    uint val = checkMember(members[msg.sender], _rem);
    require(val != 0, "You haven't added this member");
    delete members[msg.sender][val - 1];
    emit memberRemoved(msg.sender, _rem);
    
}

function changeOwner(address _new)public{

    require(msg.sender == owner, "You are not the owner.");
    owner = _new;
    emit ownerChanged(_new);
}
}