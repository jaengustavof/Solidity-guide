const assert = require('assert');

class PlayMusic {
	
	constructor(_name) {
		this.name = _name;
	}
	play() {
		return 'lalala';
	}
	stop () {
		return '-';
	}
}

let pm;

describe('Mocha tests', () => {
	
	before(() => {  
		pm = new PlayMusic("myPlaylist");
	} );
	
	beforeEach (() => {
		console.log("init for new test");
	});
	
	it('Start music', () => {
		console.log(pm.name);
		assert.ok(pm.name); 
	});

	it('Start music', () => {
		assert.equal(pm.play(),'lalala');
	});
	it('Stop music', () => {
		assert.equal(pm.stop(),'-');
	});
	
	/*it('Start music - Ejemplo falla', () => {
		assert.equal(pm.play(),'lalala2');
	});
	*/	
});