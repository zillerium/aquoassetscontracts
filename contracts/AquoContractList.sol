// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssetManager {
    struct Asset {
        uint256 assetId;
        string ipfsAddress;
        string assetDesc;
        address contractAddress;
    }

    Asset[] private assets;
    uint256 private nextAssetId = 1;
    mapping(uint256 => uint256) private assetIdToIndex;
    mapping(string => uint256) private ipfsAddressToIndex;
    mapping(address => uint256) private contractAddressToIndex;
    mapping(address => bool) private contractAddressExists;

    function addAsset(string memory ipfsAddress, string memory assetDesc, address contractAddress) public returns (uint256) {
        require(!contractAddressExists[contractAddress], "Contract Address already exists");

        uint256 assetId = nextAssetId++;
        Asset memory newAsset = Asset({
            assetId: assetId,
            ipfsAddress: ipfsAddress,
            assetDesc: assetDesc,
            contractAddress: contractAddress
        });
        assets.push(newAsset);
        uint256 index = assets.length - 1;
        assetIdToIndex[assetId] = index;
        ipfsAddressToIndex[ipfsAddress] = index;
        contractAddressToIndex[contractAddress] = index;
        contractAddressExists[contractAddress] = true;

        return assetId;
    }

    function getAssetByIpfsAddress(string memory ipfsAddress) public view returns (Asset memory) {
        uint256 index = ipfsAddressToIndex[ipfsAddress];
        return assets[index];
    }

    function getAssetByContractAddress(address contractAddress) public view returns (Asset memory) {
        uint256 index = contractAddressToIndex[contractAddress];
        return assets[index];
    }

    function getAssetByAssetId(uint256 assetId) public view returns (Asset memory) {
        uint256 index = assetIdToIndex[assetId];
        return assets[index];
    }

    function getAllAssets() public view returns (Asset[] memory) {
        return assets;
    }

}

