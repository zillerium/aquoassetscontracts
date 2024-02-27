// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRWAToken {
    function transferFrom(address from, address to, uint amount) external;
}

contract POOLToken {
    address public owner;
 
    mapping(address => uint) public balances;


    // Token name and symbol for representation
    string public name = "POOL Tokens";
    string public symbol = "POOL";

    constructor() {
        owner = msg.sender; // Setting the contract deployer as the owner
    }

    // Modifier to restrict certain functions to the contract's owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    // Minting function to create tokens and assign them to the contract's address
    function mint(uint amount) public onlyOwner {
        // Increase the contract's balance
        balances[address(this)] += amount;

    }

    // Function to transfer tokens from the contract to another address
    function transfer(address to, address rwaContractAddress, uint amount) public {
        require(balances[address(this)] >= amount, "Not enough tokens in contract");

        // Transfer the tokens
        balances[address(this)] -= amount;
        balances[to] += amount;

        // Instantiate the RWA contract using the provided address
        IRWAToken rwaToken = IRWAToken(rwaContractAddress);

        // Call `transferFrom` on the RWA contract to transfer RWA tokens from 'to' to the POOL contract
        // The 'to' address must have previously approved the POOL contract to spend RWA tokens on their behalf
        rwaToken.transferFrom(to, address(this), amount);
    }

    function transferFrom(address from, address to, uint amount) public {
        require(balances[from] >= amount, "Insufficient balance");
      

        // Transfer the tokens
        balances[from] -= amount;
        balances[to] += amount;

     }

}

