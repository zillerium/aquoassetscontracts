// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPOOLToken {
  function transfer(address to, address rwaContractAddress, uint amount) external;
}

contract RWAToken  {
    address public owner;
    address public poolAddress; // Added variable to store the pool address

    mapping(address => uint) public balances;

    // Token name and symbol for representation
    string public name = "Real World Asset";
    string public symbol = "RWA";

    event Transfer(address indexed from, address indexed to, uint amount);
    event Mint(address indexed to, uint amount);

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
        emit Mint(address(this), amount);
    }

    // Function to transfer tokens from the contract to another address
    function transfer(address to, uint amount) public {
        require(balances[address(this)] >= amount, "Not enough tokens in contract");

        // Transfer the tokens
        balances[address(this)] -= amount;
        balances[to] += amount;
        emit Transfer(address(this), to, amount);
    }

    function transferFrom(address from, address to, uint amount) public {
        require(balances[from] >= amount, "Insufficient balance");
      

        // Transfer the tokens
        balances[from] -= amount;
        balances[to] += amount;

        emit Transfer(from, to, amount);
    }

    function updatePoolAddress(address newPoolAddress) public onlyOwner {
        poolAddress = newPoolAddress;
     }

    function swap(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient RWA balance");
        IPOOLToken(poolAddress).transfer(msg.sender, address(this), amount); // Call the transfer function of the POOL contract
        //balances[msg.sender] -= amount; // Deduct the RWA tokens from the sender's balance
        emit Transfer(msg.sender, address(this), amount); // Emit a Transfer event for the RWA tokens
    }

}

