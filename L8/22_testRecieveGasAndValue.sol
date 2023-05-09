// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8  ;


contract Bank {
    mapping(address => uint) public balances;
    
    function _deposit() internal  {
        balances[tx.origin] += msg.value;
    }
    
    function deposit() external payable  //returns(uint gasUsado) 
    {
     //   gasUsado = gasleft();
        _deposit();
      //  gasUsado = gasUsado - gasleft();
    }

    receive() external payable { 
        _deposit();
     }

}

interface IBank {
 function deposit() external payable ;
}

contract Caller {
   
    address payable public SCBank;

    function setBankSCAddress(address payable _SCBank) public {
        SCBank = _SCBank;
    }

    function  deposit_DC() public payable {
        Bank(SCBank).deposit{value: msg.value}();
    }
     function  deposit_IC() public payable {
        IBank(SCBank).deposit{value: msg.value}();
    }

    function deposit_LowLeveCalll() public payable {
        (bool success,) = address(SCBank).call{value: msg.value}(abi.encodeWithSignature("deposit()"));
        require(success, "deposit failed");
    }

    function transfer() public payable {  //Will fail - gas is restricted to 2100
        SCBank.transfer(msg.value);
    }
    function send() public payable { //will fail - gas is restricted to 2100
       assert(SCBank.send(msg.value));
    }



    function transferWithLowLevelCall() public payable {
        //we should verify destination is a SC
       (bool success,) = SCBank.call{value: msg.value}("");  //This is essentially the same as addr.transfer(x), only that it forwards all remaining gas and opens up the ability for the recipient to perform more expensive actions
       require(success, "deposit failed");
    }
    function transferWithLowLevelCallv2() public payable {
       require(SCBank.code.length  > 0, "Bank is not a SC");
       (bool success,) = SCBank.call{value: msg.value, gas:100000}("");  //we limit gas sent - prevent from attacks
       require(success, "deposit failed");
    }
    function getBankBalance() public view returns(uint) {
        return SCBank.balance;
    }

}