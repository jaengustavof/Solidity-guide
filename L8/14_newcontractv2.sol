// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract MappingExample {
    mapping(address => uint) public balances;
    address public UltimaLlamada;
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function update(uint newBalance) public {
        UltimaLlamada = msg.sender;
        balances[msg.sender] += newBalance;
    }
}

contract MappingUser {
    MappingExample public m = new MappingExample(msg.sender);
    address public UltimaLlamada;

    function f() public returns (uint) {
        UltimaLlamada = msg.sender;
        m.update(100);

        return m.balances(address(this));
    }
	
    
	function getMAddress() public view returns(address)
	{
		return address(m);
	}
}