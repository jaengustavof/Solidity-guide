// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.4;
/*
  HAY QUE PONER UN VALOR EN EL DEPLOY PARA QYE PUEDE DESPLEGARSE
*/
contract Register  {

    mapping (address => bool) registeredAddresses;
    uint public aportacionMinima;
    address public administrador;

    modifier onlyAdmin() {
        require(administrador==msg.sender,"only admin");
        _;
    }


     modifier costs(uint price) {
        if (msg.value >= price) {   //solo para ejemplo test, el value se está quedando al SC aunque incumpla
            _;
        }
    }

    constructor(uint initialPrice) {
         aportacionMinima = initialPrice; 
         administrador = msg.sender;
    }

    // It is important to also provide the
    // `payable` keyword here, otherwise the function will
    // automatically reject all Ether sent to it.
    function register() public payable  costs(aportacionMinima) {
        registeredAddresses[msg.sender] = true;
    }

    function checkregistered(address _a) public view returns(bool) {
        return registeredAddresses[_a];
    }

    function getRecaudado() public view returns (uint){
       return address(this).balance;
    }

    function changeAportacionMinima(uint newPrice) onlyAdmin public {
          aportacionMinima = newPrice;
    }

    function deleteSomeValues () onlyAdmin public {
        delete aportacionMinima;
        delete administrador;
        delete registeredAddresses[msg.sender];
    }
    
}