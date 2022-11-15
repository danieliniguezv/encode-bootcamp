//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../src/VolcanoNFT.sol";
import "../lib/volcano-coin/VolcanoCoin.sol";

contract VolcanoNFTTest is Test, Ownable {

    VolcanoNFT vNFT;
    VolcanoCoin vToken;

    address user = address(1);
    address payable withdraw = payable(address(2));

    function setUp() public {
        vToken = new VolcanoCoin();
        vNFT = new VolcanoNFT("Test Volcano NFT", "TVLC", address(vToken));
    }

    function testPayVolcano() public {
        vNFT.payVolcano(vNFT._volcanoPrice());
        vNFT.mint("This is a NFT.");
        assertTrue(vNFT._tokenId() != 0);
        assertTrue(vNFT.balanceOf(address(this)) == 1);
    }

    function testMint() public {
        vNFT.mint{value: vNFT._price()}("This is a NFT.");
        assertTrue(vNFT._tokenId() != 0);
        assertTrue(vNFT.balanceOf(address(this)) == 1);
    }

    function testTransfer() public {
        vNFT.mint{value: 0.01 ether}("This is a NFT.");
        vNFT.transfer(address(this), user, 1);
        assertTrue(vNFT.balanceOf(user) != 0);
    }

    function testWithdrawal() public onlyOwner {
        require(withdraw != address(0));
        vNFT.withdrawal(withdraw);
    }

    function testFailWithdrawal() public onlyOwner {
        vm.prank(address(3));
        vm.expectRevert(bytes("You are not the owner!!"));
        vNFT.withdrawal(withdraw);
    }
}