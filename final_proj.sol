// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18; 
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 
 
contract redeem is Ownable{ 
    struct  item {   // struct to store the items along with their index and value
 
        uint  id; 
        string  name; 
        uint  value; 
         
    } 
 
    item[] public items;   //struct array to store the items, that are listed
 
    uint index = 0; 
 
    function addItem(string memory _name, uint _val) public onlyOwner{ 
 
        item memory newItem = item(index, _name, _val); 
        items.push(newItem);  //adding the items into the struct array for listing
        index += 1; 
 
    } 
 
} 
 
contract DegenToken is ERC20, Ownable, redeem { 
 
     
 
    mapping (address => string[]) redTokens;  //mapping to store the redeemed tokens to a wallet address
 
    constructor() ERC20("Degen", "DGN") {} 
 
        function mint(address to, uint256 amount) public onlyOwner { 
            _mint(to, amount);   //minting tokens to a particular amount
    } 
 
    function transfer_token(address _add, uint _val) public returns(bool){ 
 
        return transfer(_add, _val); 
 
    } 
 
    function get_balance() public view returns(uint){ 
 
        return balanceOf(msg.sender); 
    } 
 
    function burn_token(uint _val) public{ 
 
        require(balanceOf(msg.sender) >= _val, "You don't have enough tokens to burn"); 
        transfer(address(0), _val); 
          
    } 
 
    function showItems() public view returns(item[] memory) { 
         
        return items; 
    } 
 
    function redeemToken(uint _val) public { 
 
        require (balanceOf(msg.sender) >= items[_val].value, "You don't have enough tokens"); 
        transfer(address(this), items[_val].value); 
        redTokens[msg.sender].push(items[_val].name); 
 
    } 

    function myItems() public view returns(string[] memory){

        return redTokens[msg.sender];
    }
 
    function withdrawToken(address _add) public onlyOwner{ 
 
        transferFrom(address(this), _add, address(this).balance); 
         
    } 
 
     
}
