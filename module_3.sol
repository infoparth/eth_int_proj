// SPDX-License-Identifier: MIT 
 
pragma solidity ^0.8.13; 
 
import "eth_int_module_proj/node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "eth_int_module_proj/node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol"; 
import "eth_int_module_proj/node_modules/@openzeppelin/contracts/access/Ownable.sol"; 
 
contract myProj is ERC20, ERC20Burnable, Ownable{ 
 
 
    constructor(uint _initialSupply) ERC20("FLEX", "FLX"){ 
 
        _mint(msg.sender, _initialSupply); 
 
    } 
 
 
    function add(address _add, uint _value) public onlyOwner returns(uint)  { 
 
        _mint(_add, _value); 
 
        return _value; 
 
 
    } 
 
    function transtoken(address _add, uint _val) public returns(bool){ 
 
       return transfer(_add, _val); 
 
    } 
 
    function burntok(uint _val)public{ 
 
        require(balanceOf(msg.sender) >= _val,"You Do not have enough tokens to burn"); 
        burn(_val); 

    } 
 
 
}
