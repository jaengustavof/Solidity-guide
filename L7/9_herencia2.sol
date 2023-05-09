// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.1 <0.9.0;

contract A {
    function getMessage() public pure virtual returns (string memory)  {
        return "love from A";
    }
    function getMessageP()  pure private returns (string memory)  {
        return "love from A - pure";
    }
    function getMessageI()  pure internal returns (string memory)  {
        return "love from A - internal";
    }
}

contract B is A {
    function getMessage() public pure virtual override returns (string memory)  {
        return "love from B";
    }
  /* function getMessagePCall() public pure  returns (string memory)  {
        return getMessageP();
    }
    */
    function getMessageIcall() public pure  returns (string memory)  {
        return getMessageI();
    }
}

contract C  {
    function getMessage() public pure virtual  returns (string memory)  {
        return "love from C";
    }
}

contract D is B,C {

    function getMessage() public pure override(B,C) returns (string memory) { 
      return  super.getMessage(); 
    }

}


contract E is C,B {

    function getMessage() public pure override(B,C) returns (string memory) { 
      return  B.getMessage(); 
    }
}