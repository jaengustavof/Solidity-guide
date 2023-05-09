// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Address.sol";
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol

contract ContractName {

    function getIsAddress(address scAddress) public view returns(bool)
    {
        return Address.isContract(scAddress);
    }
    
}