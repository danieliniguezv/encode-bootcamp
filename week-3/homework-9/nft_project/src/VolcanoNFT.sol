//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is ERC721 {
    
    constructor() ERC721("Volcano NFT", "VLC"){}

    function mint(address _to, uint256 _tokenId) external {
        super._safeMint(_to, _tokenId);
    } 
}