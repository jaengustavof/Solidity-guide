// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";



//Juan Gabriel ---> 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//Juan Amengual ---> 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//María Santos ---> 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

//Interface de nuestro token ERC20
interface IERC20{
    //Devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256);

    //Devuelve la cantidad de rokens para una dirección indicada por parámetro
    function balanceOf(address account) external view returns (uint256);

    //Devuelve el número de token que el spender podrá gastar en nombre del propietario (owner)
    function allowance(address owner, address spender) external view returns (uint256);

    //Devuelve un valor booleano resultado de la operación indicada
    function transfer(address recipient, uint256 amount) external returns (bool);

    //Devuelve un valor booleano con el resultado de la operación de gasto
    function approve(address spender, uint256 amount) external returns (bool);

    //Devuelve un valor booleano con el resultado de la operación de paso de una cantidad de tokens usando el método allowance()
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);



    //Evento que se debe emitir cuando una cantidad de tokens pase de un origen a un destino
    event Transfer(address indexed from, address indexed to, uint256 value);

    //Evento que se debe emitir cuando se establece una asignación con el mmétodo allowance()
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//Implementación de las funciones del token ERC20
contract ERC20Basic is IERC20{

    string public constant name = "ERC20BlockchainAZ";
    string public constant symbol = "ERC";
    uint8 public constant decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed owner, address indexed spender, uint256 tokens);


    using SafeMath for uint256;

    mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allowed; //mapping dentro de un mapping para ver los addresses que tienen permiso a gastar mis tokens y la cantidad. Estos address no tendran tokens sino un permiso para gatarlos

    uint256 totalSupply_;

    constructor (uint256 initialSupply) public{
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }


    function totalSupply() public override view returns (uint256){ //Establece el total de tokens en la creacion. Esto se define en el DEPLOY
        return totalSupply_;
    }

    function increaseTotalSupply(uint newTokensAmount) public { // Incrementa la cantidad de TOKENS
        totalSupply_ += newTokensAmount;
        balances[msg.sender] += newTokensAmount;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256){ //Balance de acuerdo a la address
        return balances[tokenOwner];
    }

    function allowance(address owner, address delegate) public override view returns (uint256){ //vemos cuantos tokens puede utiilzar a nuestro nombre el address. No son del address, sino nuestros(owner). El address puede vender haciendo de intermediario
        return allowed[owner][delegate];
    }

    function transfer(address recipient, uint256 numTokens) public override returns (bool){ //Owner transfiere Tokens
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);//.sub() SafeMath.sol
        balances[recipient] = balances[recipient].add(numTokens);//.add() SafeMath.sol
        emit Transfer(msg.sender, recipient, numTokens);
        return true;
    }

    //TODO: Ejecutar como OwnerOnly
    function approve(address delegate, uint256 numTokens) public override returns (bool){ //Se aprueba una cantidad de tokens para utilizar. No son del delegate, sino que damos un permiso para que el delegate utilice x cantidad de tokens, y actue como un intermediario. 
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    //TODO: address owner debe ser siempre el address que deploya el contrato. Sec 18 - 104
    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner].sub(numTokens);//.sub() SafeMath.sol
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);//.sub() SafeMath.sol
        balances[buyer] = balances[buyer].add(numTokens);//.add() SafeMath.sol
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}