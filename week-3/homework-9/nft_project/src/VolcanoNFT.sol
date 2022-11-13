//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is ERC721 {

    uint256 public tokenId_;
    
    //Mapping the token ID with the actual NFT.
    mapping(uint256 => string) public nft;
    
    //Pass in the name of the NFT and its symbol.
    constructor(
        string memory _nftName, 
        string memory _nftSymbol) 
        ERC721(_nftName, _nftSymbol){
            tokenId_ = 0;
        }

    //This NFT stores a string.
    function mint(uint256 _tokenId, string memory _nft) external {
        super._safeMint(msg.sender, _tokenId);
        nft[_tokenId] = _nft;
    }

    //Transfer the NFT to a given addres.
    function transfer(address _from, address _to, uint256 _tokenId) external {
        super.safeTransferFrom(_from, _to, _tokenId);
    }
}