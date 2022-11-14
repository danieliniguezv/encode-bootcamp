//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract VolcanoNFT is ERC721, Ownable {

    uint256 public _tokenId;
    uint256 private _price;
    
    //Mapping the token ID with the actual NFT.
    mapping(uint256 => string) public nft;
    
    //Pass in the name of the NFT and its symbol.
    constructor(
        string memory _nftName, 
        string memory _nftSymbol) 
        ERC721(_nftName, _nftSymbol){
            _tokenId = 0;
            _price = 0.01 ether;
        }

    //This NFT stores a string.
    function mint(string memory _nft) external payable {
        require(msg.value == _price);
        _tokenId++;
        super._mint(msg.sender, _tokenId);
        nft[_tokenId] = _nft;
    }

    //Transfer the NFT to a given addres.
    function transfer(address from_, address to_, uint256 tokenId_) external {
        super._transfer(from_, to_, tokenId_);
    }

    //Withdraw NFT sales earnings.
    function withdrawl(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }
}