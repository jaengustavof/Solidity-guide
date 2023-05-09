// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 < 0.7.0;

contract global_functions{

    // now - returns current block's timestamp
    function Now() public view returns(uint){
        return now;
    }

    // msg.sender Function - returns sender address
    function MsgSender() public view returns(address){
        return msg.sender;
    }

    // block.coinbase - returns miner's address
      function BlockCoinbase() public view returns(address){
        return block.coinbase;
    }

    // block.difficulty - returns blocks difficulty
      function BlockDifficulty() public view returns(uint){
        return block.difficulty;
    }

    // block.numer - returns block number
    function BlockNumber() public view returns(uint){
        return block.number;
    }

    // msg.sig - returns 4 bytes
    function MsgSig() public pure returns(bytes4){ //we add pure to avoid compilation error "Function state mutability can be restricted"
        return msg.sig;
    }

    // tx.gasprice - returns gas price from the transaction
    function txGasPrice() public view returns(uint){
        return tx.gasprice;
    }

}