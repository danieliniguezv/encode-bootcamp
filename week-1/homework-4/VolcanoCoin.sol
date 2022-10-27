// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
	
	uint256 coins;

	address owner;

	mapping(address => uint256) userBalances;

	struct Payment {
		uint256 amount;
		address recipient;
	}

	Payment payer;

	mapping(address => Payment) paymentRegister;
	
	modifier onlyOwner {
		if (msg.sender == owner) {
			_;
		}
	}
	
	event supplyChange(uint256);

	event coinTransfer(uint256, address);
	
	constructor() {
		owner = msg.sender;
		coins = 10000;
		userBalances[msg.sender] = coins;
	}
	
	function totalSupply() public view returns(uint256) {
		return coins;
	}
	
	function increaseSupply() public onlyOwner {
		coins = coins + 1000;
		emit supplyChange(coins);
	}
	
	function getUserBalances(address user) public view returns (uint256) {
		return userBalances[user];
	}
	
	function transfer(uint256 _amount, address _recipient) public {
		payer.amount = _amount;
		payer.recipient = _recipient;
		userBalances[owner] = userBalances[owner] - _amount;
		userBalances[_recipient] = _amount;
		emit coinTransfer(_amount, _recipient);
	}
	
	function getPaymentsAddress(address _user) public view returns (uint256, address) {
		return paymentRegister[_user];
	}
}
