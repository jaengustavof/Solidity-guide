// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

interface Mamifero {
    function ruidNacer() external pure  returns (string memory);
}

abstract contract Felinio {
    function rugido() public pure virtual returns (string memory);
    
    function numeroDePatas() public pure returns(uint8) {
        return 4;
    }
}

contract Gato is Felinio,Mamifero {
    function rugido() public pure override returns (string memory) { return "miaow"; }
    function ruidNacer() public pure  returns (string memory) { return "aaa"; }
}
