//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test, ERC721 {

    VolcanoNFT public vNFT;

    function setUp() public {
        vNFT = new VolcanoNFT();
    }

    function testMint() public {
        vNFT.mint();
        asserTrue(vNFT._tokenId != 0);
    }
}