const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');  //Web3 en mayuscula porque es el constructor
const web3 = new Web3(ganache.provider());  //Crea instancia web3
const {abi,bytecode} = require ('../compile');

/*
beforeEach( () => {
	//get all the accounts
	web3.eth.getAccounts()
	.then(fetchedAccounts => {
		console.log(fetchedAccounts);
	});
	//use one of the accounts to deploy
} );
*/

console.log(abi);
console.log(bytecode);

let accounts;
let messagebox;

describe('Messagebox tests', () => {
	
	before( async() => {  //añadir async 
		//get all the accounts
		accounts = await web3.eth.getAccounts();
		//console.log(accounts[0]);
		//use one of the accounts to deploy
		messagebox = await new web3.eth.Contract(abi)
			.deploy({data: bytecode, arguments: ['initial message']})
			.send({ from: accounts[0], gas: 1000000 });
		
		console.log('contract address:'+messagebox.options.address);
	} );



	it('deploys a contract', () => {
		//console.log(messagebox);
		//console.log('Contract address: '+messagebox.options.address);
		assert.ok(messagebox.options.address); 
		//Check address y methods
	});
	it('has a message',async() => {
		const message = await messagebox.methods.getMessage().call();
		assert.equal(message,"initial message");
	});
	
	it('change message by admin', async () => {
		await messagebox.methods.setMessage('new message').send({
			from: accounts[0]})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
		//Si da excepcion salta error y no continua
		const message = await messagebox.methods.getMessage().call();
		assert.equal(message,"new message");
	});
	
	it('cant be changed by other account', async () => {
		try {
			await messagebox.methods.setMessage('new message by user').send({
			from: accounts[1]})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
			assert.fail(new TypeError('Error-Not Admin should fail'));
		}
		catch (error) {
			console.log(error.message);
			assert(error.message != "Error-Not Admin should fail"	);
		}
	});
	
});

