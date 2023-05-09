// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract C {
    uint[3] x;  //se almacena en storage
    uint aux;
    
    function f() public {
        x[0] = 1;
        x[1] = 1;
        x[2] = 1;
    }
	modifier testDouble { 
	 aux = 0;
	 _;  // Si se cumple anterior condición se ejecuta función.
	 aux = 1;
	 _;
	}
	
	function i() public testDouble {
		x[aux] = 5;
	}


    function g(uint[3] memory z) internal pure {  //Z se almacena en memoria
		uint a = 2;   //se almacena en stack
        z[1] = a;     //se modifica memory
    }

    function h(uint[3] storage z) internal  {  //referencia a storage
        uint a = 3;   //se almacena en stack
        z[2] = a;  //se modifica storage
    }
   
    function callinternalfunctions() public {
        g(x);
        h(x);
    }
    
    function get_x() external view returns (uint[3] memory)  {
        return x;
    }

}