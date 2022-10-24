// SPDX-License-Identifier: None

pragama solidity 0.8.17;

contract BootcampContract {
	
	uint256 number;

	address owner;

	address foreign;

	constructor {
		owner = msg.sender;
		foreign = 0x000000000000000000000000000000000000dEaD;
	}

	function store(uint256 num) public {
		number = num;
	}

	function retreive() public view returns (uint256) {
		return number;
	}

	function deployer() external view returns (address) {
		if (msg.sender == owner) {
			return foreign;
		}
		else {
			return owner;
		}
}
