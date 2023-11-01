// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AquoAssetTransferv3.sol";
import "./AquoContractListv3.sol";

contract DeployContract {

    ContractList public contractList;

    // Event to log the address of the deployed asset contract
    event contractDeployed(address contractAddress);

    constructor(address _contractList) {
        contractList = ContractList(_contractList);
    }

    function deployAndRegisterContract(string memory _ipfsAddress, uint256 _initialShares) public returns (address) {
        // Deploy the Asset contract
        AssetContract newContract = new AssetContract(_initialShares, msg.sender);
        
        // Register the asset in the AssetManager
        contractList.listContract(address(newContract), _ipfsAddress);

        // Emit the event
        emit contractDeployed(address(newContract));

        return address(newContract);
    }
}

