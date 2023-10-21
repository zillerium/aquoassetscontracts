pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AssetShares is ERC20, Ownable {
    
    constructor(uint256 initialSupply) ERC20("AssetShares", "ASH") {
        _mint(msg.sender, initialSupply);  // Initial distribution to the contract owner
    }

    // Function to allocate additional shares/tokens (in case of dilution)
    function mintAdditionalShares(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
    }

    // The default ERC20 functions provided by OpenZeppelin's ERC20 implementation will handle
    // transferring of shares/tokens, checking balances, and other standard functionalities.
}