//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test {

    VolcanoNFT vNFT;

    function setUp() public {
        vNFT = new VolcanoNFT("Test Volcano NFT", "TVLC");
    }

    function testMint() public {
        vNFT.mint("This is a NFT");
    }

    function testTransfer() public {
        vNFT.mint("This is a NFT");
        vNFT.transfer(address(this), address(this), 1);
    }
}