// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Base {
    uint public x;
    constructor(uint _x) { x = _x; }
}

// Either directly specify in the inheritance list...
contract Derived1 is Base(7) {
    string public registry;
    constructor(string memory r) {
        registry = r;
    }
}

// or through a "modifier" of the derived constructor.
contract Middle is Base {
    string public registry;
    constructor(string memory r, uint _y) Base(_y) {
        registry = r;
    }
}

contract Derived3 is Middle {
    address public owner;
    constructor(string memory r, uint y) Middle(r,y) {
        owner = msg.sender;
    }
}
