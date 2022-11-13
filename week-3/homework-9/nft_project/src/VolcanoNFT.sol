//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is ERC721 {

    uint256 public _tokenId;
    
    //Mapping the token ID with the actual NFT.
    mapping(uint256 => string) public nft;
    
    //Pass in the name of the NFT and its symbol.
    constructor(
        string memory _nftName, 
        string memory _nftSymbol) 
        ERC721(_nftName, _nftSymbol){
            _tokenId = 0;
        }

    //This NFT stores a string.
    function mint(string memory _nft) external {
        _tokenId++;
        super._mint(msg.sender, _tokenId);
        nft[_tokenId] = _nft;
    }

    //Transfer the NFT to a given addres.
    function transfer(address from_, address to_, uint256 tokenId_) external {
        super._transfer(from_, to_, tokenId_);
    }
}