// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// deploy first in the sequence of contracts - AquoAssetShareNFT.sol, AquoAssetManager.sol, then AquoUserProxy.sol

contract AquoAssetShareNFT is ERC721Enumerable, Ownable {
    constructor() ERC721("Asset Share Token", "AST") {}

    // Mint new NFTs
    function mint(address to) external onlyOwner returns (uint256) {
        uint256 tokenId = totalSupply() + 1;
        _mint(to, tokenId);
        return tokenId;
    }
}
