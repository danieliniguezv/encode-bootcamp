//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is ERC721 {

    //Mapping the token ID with the actual NFT.
    mapping(uint256 => string) public nft;
    
    //Pass in the name of the NFT and its symbol.
    constructor() ERC721("Volcano NFT", "VLC"){}

    //This NFT stores a string.
    function mint(uint256 _tokenId, string memory _nft) external {
        super._safeMint(msg.sender, _tokenId);
        nft[_tokenId] = _nft;
    }

    //Transfer the NFT to a given addres.
    function transfer(address from_, address to_, uint256 tokenId_) external {
        super.safeTransferFrom(from_, to_, tokenId_);
    }
}