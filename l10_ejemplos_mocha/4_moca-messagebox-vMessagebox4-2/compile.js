const path = require('path');
const fs = require('fs-extra');
const solc = require('solc');

const buildPath = path.resolve(__dirname, 'build/contracts');
fs.removeSync(buildPath);
fs.ensureDirSync(buildPath);

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

//pas 2  exportar para test
//const contractsCompiled = JSON.parse(solc.compile(JSON.stringify(input))).contracts['messagebox.sol']['Messagebox'];
const contractsCompiled = JSON.parse(solc.compile(JSON.stringify(input))).contracts['messagebox.sol'];

//console.log("\nABI:"+messageboxcompile.abi);
//console.log("\bytecode:"+messageboxcompile.evm);
for (let contract in contractsCompiled) {
	fs.outputJsonSync(
		path.resolve(buildPath, contract+'.json'),
		contractsCompiled[contract]);	
}
