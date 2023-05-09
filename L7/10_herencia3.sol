// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract owned {
    constructor() { owner = payable(msg.sender); }
    address payable owner;
}

contract Registered is owned {
    string public registry;
    function register(string memory reg) virtual public {
        if (msg.sender == owner) registry = string(abi.encodePacked(reg,"-Registered"));
    }
}

contract Base1 is Registered {
    function register(string memory reg) public virtual override { /* toddo base1 */ super.register(string(abi.encodePacked(reg,"-Base 1"))); }
}


contract Base2 is Registered {
    function register(string memory reg) public virtual override { /* tododo base2 */ super.register(string(abi.encodePacked(reg,"-Base 2"))); }
}

contract Final is Base1, Base2 {
    function register(string memory reg) public override(Base1, Base2) { super.register(string(abi.encodePacked(reg,"-Final"))); }
}

//Final -> Base2 -> Base 1 -> Registed -> Owned
