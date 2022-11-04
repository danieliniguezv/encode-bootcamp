//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCoinTest is Test, Ownable {
    
    VolcanoCoin public vCoin;
    
    function setUp() public {
        vCoin = new VolcanoCoin();
    }
    
    function testTotalSupply() public {
        vCoin.totalSupply();
        assertTrue(vCoin.coins() == 10000);
    }
    
    function testIncreaseSupply() public {
        vCoin.increaseSupply();
        assertTrue(vCoin.coins() == 11000);
    }

    function testOwnerIncreaseSupply() public onlyOwner {
        testIncreaseSupply();
    }
}
