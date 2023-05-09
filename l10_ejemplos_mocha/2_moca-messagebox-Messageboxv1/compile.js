const path = require('path');
const fs = require('fs');
const solc = require('solc');

const messageboxPath = path.resolve(__dirname, 'contracts', 'messagebox.sol');
const source = fs.readFileSync(messageboxPath, 'UTF-8');

var input = {
    language: 'Solidity',
    sources: {
        'messagebox.sol' : {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ '*' ]
            }
        }
    }
}; 

//https://docs.soliditylang.org/en/v0.8.19/using-the-compiler.html#basic-usage
//console.log(JSON.parse(solc.compile(JSON.stringify(input))));
//console.log(JSON.parse(solc.compile(JSON.stringify(input))).contracts['messagebox.sol']['Messagebox']);



//pas 2  exportar para test
const messageboxcompile = JSON.parse(solc.compile(JSON.stringify(input))).contracts['messagebox.sol']['Messagebox'];

console.log("\nABI:"+messageboxcompile.abi);
console.log("\bytecode:"+messageboxcompile.evm);

module.exports = {
	abi : messageboxcompile.abi,
	bytecode : messageboxcompile.evm.bytecode.object
}