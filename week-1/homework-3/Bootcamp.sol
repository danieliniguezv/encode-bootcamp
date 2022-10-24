// SPDX-License-Identifier: None

pragama solidity 0.8.17;

contract BootcampContract {
	
	uint256 number;

	function store(uint256 num) public {
		number = num;
	}

	function retreive() public view returns (uint256) {
		return number;
	}
}
