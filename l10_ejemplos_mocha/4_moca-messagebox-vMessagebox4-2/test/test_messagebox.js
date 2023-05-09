const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');  //Web3 en mayuscula porque es el constructor
const web3 = new Web3(ganache.provider());  //Crea instancia web3
//const {abi,bytecode} = require ('../compile');
const messageBoxBuild = require ('../build/contracts/Messagebox.json');


//console.log(messageBoxBuild.abi);
//console.log(messageBoxBuild.evm.bytecode);

let accounts;
let messagebox;

describe('Messagebox tests', () => {
	
	before( async() => {  //añadir async 
		//get all the accounts
		accounts = await web3.eth.getAccounts();
		//console.log(accounts[0]);
		//use one of the accounts to deploy
		messagebox = await new web3.eth.Contract(messageBoxBuild.abi)
			.deploy({data: messageBoxBuild.evm.bytecode.object, arguments: []})
			.send({ from: accounts[0], gas: 2000000 });
		
		console.log('contract address:'+messagebox.options.address);
	} );



	it('deploys a contract', () => {
		//console.log(messagebox);
		console.log('Contract address: '+messagebox.options.address);
		assert.ok(messagebox.options.address); 
		//Check address y methods
	});
	it('has a message',async() => {
		const message = await messagebox.methods.messages(0).call();
		assert.equal(message,"Hello World!");
	});
	
	it('1rst message is free', async () => {
		await messagebox.methods.setMessage('new message').send({
			from: accounts[0]})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
		//Si da excepcion salta error y no continua
		const message = await messagebox.methods.getMessages().call();
		assert.equal(message[1],"new message");
	});
	
	it('2n message has a price', async () => {
		try {
			await messagebox.methods.setMessage('2message').send({
			from: accounts[0]})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
			assert.fail(new TypeError('Error-2n message has cost'));
		}
		catch (error) {
			console.log(error.message);
			assert(error.message != "Error-2n message has cost"	);
		}
	});

	it('1ers form other account is free', async () => {
		await messagebox.methods.setMessage('1message_otheraccount').send({
			from: accounts[1]})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
		//Si da excepcion salta error y no continua
		const messages = await messagebox.methods.getMessages().call();
		console.log(messages);
		assert.equal(messages.length,3,"1ers message is free");
	});
	
	it('2n form other account has price', async () => {
		await messagebox.methods.setMessage('2message_otheraccount').send({
			from: accounts[1], value: '1000000000000000'})
			.on('transactionHash', function(transactionHash){ console.log('txid:'+transactionHash); })
			.then(function(receipt){ console.log(receipt); })
			;
		//Si da excepcion salta error y no continua
		const messages = await messagebox.methods.getMessages().call();
		console.log(messages);
		assert.equal(messages.length,4,"2n message has cost");
	});
	
	
});


