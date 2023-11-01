// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProspectusRegistry {
    
    // Updated struct to hold the IPFS address for the prospectus and image, and the proposer's wallet address
    struct ProspectusRecord {
        string prospectusCid;
        string imageCid;
        address proposer;
    }
    
    // Array to hold all the ProspectusRecord entries
    ProspectusRecord[] public records;
    
    // Mappings to check for unique IPFS entries for both prospectus and image
    mapping(string => bool) private prospectusCidExists;
    mapping(string => bool) private imageCidExists;

    // Updated function to add a new record with both prospectus and image CIDs
    function addRecord(string memory _prospectusCid, string memory _imageCid) public {
        // Ensure the IPFS addresses haven't been added before
       // require(!prospectusCidExists[_prospectusCid], "Prospectus CID already exists");
       // require(!imageCidExists[_imageCid], "Image CID already exists");
        
        if(prospectusCidExists[_prospectusCid] || imageCidExists[_imageCid]) {
            return;
        }

        // Create a new record and push it to the array
        records.push(ProspectusRecord({
            prospectusCid: _prospectusCid,
            imageCid: _imageCid,
            proposer: msg.sender
        }));
        
        // Mark the IPFS addresses as added
        prospectusCidExists[_prospectusCid] = true;
        imageCidExists[_imageCid] = true;
    }

    // Get the total number of records
    function getRecordCount() public view returns (uint) {
        return records.length;
    }
    
    // Get a specific record by index
    function getRecord(uint _index) public view returns (ProspectusRecord memory) {
        require(_index < records.length, "Index out of bounds");
        return records[_index];
    }

    function getAllRecords() public view returns (ProspectusRecord[] memory) {
        return records;
    }
}

