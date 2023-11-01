// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AquoNewERC20.sol";
import "./AquoContractList.sol";

contract Deployer {

    AssetManager public assetManager;

    // Event to log the address of the deployed asset contract
    event AssetDeployed(address deployedAddress);

    constructor(address _assetManagerAddress) {
        assetManager = AssetManager(_assetManagerAddress);
    }

    function deployAndRegisterAsset(string memory ipfsAddress, string memory assetDesc, uint256 initialShares) public returns (address) {
        // Deploy the Asset contract
        AssetShares newAsset = new AssetShares(ipfsAddress, initialShares);
        
        // Register the asset in the AssetManager
        assetManager.addAsset(ipfsAddress, assetDesc, address(newAsset));

        // Emit the event
        emit AssetDeployed(address(newAsset));

        return address(newAsset);
    }
}
