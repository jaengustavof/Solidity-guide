// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract NameRegistry {
   struct ContractDetails {
      address owner;
      address contractAddress;
      uint16 version;
   }
   mapping(string => ContractDetails) registry;
   

   function registerName(string memory name, address addr, uint16 ver) public returns (bool) {
     
      ContractDetails storage info = registry[name];
        // create info if it doesn't exist in the registry
       if (info.contractAddress == address(0)) {
          info.owner = msg.sender;
          info.contractAddress = addr;
          info.version = ver;
       } else {
            require(info.owner == msg.sender,"only owner can edit");
            info.version = ver;
            info.contractAddress = addr;
       }
       // update record in the registry
       return true;
   }
    function getContractDetails(string memory name) public view returns(address, uint16) {
      return (registry[name].contractAddress, registry[name].version);
   }
}