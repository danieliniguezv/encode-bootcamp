// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {
	
	uint256 public coins;

	//address owner;

	mapping(address => uint256) userBalances;

	struct Payment {
		//uint256 amount;
		//address recipient;
		uint256 paymentAmount;
		address sender;
		address receiver;
	}

	mapping(address => Payment[]) paymentRegister;
	
	/*modifier onlyOwner {
		if (msg.sender == owner) {
			_;
		}
	}*/
	
	event supplyChange(uint256);

	event coinTransfer(uint256, address);
	
	constructor() {
		//owner = msg.sender;
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
		userBalances[msg.sender] = userBalances[msg.sender] - _amount;
		userBalances[_recipient] = _amount;
		emit coinTransfer(_amount, _recipient);
		//paymentRegister[msg.sender].push(Payment({recipient: _recipient, amount: _amount}));
		recordPayment(msg.sender, _recipient, _amount);
	}
	
	function getPaymentsAddress(address _user) public view returns (Payment[] memory) {
		return paymentRegister[_user];
	}

	function recordPayment(address _sender, address _receiver, uint256 _paymentAmount) public {
		paymentRegister[msg.sender].push(Payment({sender: _sender, receiver: _receiver, paymentAmount: _paymentAmount}));
	}
}
