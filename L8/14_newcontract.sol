// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint newBalance) public {
        balances[msg.sender] += newBalance;
    }
}

contract MappingUser {
    MappingExample m = new MappingExample();
    function f() public returns (uint) {
        m.update(100);
        return m.balances(address(this));
    }
	
    
	function getMAddress() public view returns(address)
	{
		return address(m);
	}
}