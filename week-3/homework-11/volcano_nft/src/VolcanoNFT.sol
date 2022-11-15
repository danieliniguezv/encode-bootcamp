//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/volcano-coin/VolcanoCoin.sol";

contract VolcanoNFT is ERC721, Ownable {

    VolcanoCoin volcanoToken;

    uint256 public _tokenId;
    uint256 public _price;
    uint256 public _volcanoPrice;
    uint256 public volcanoAmount_;
    
    //Mapping the token ID with the actual NFT.
    mapping(uint256 => string) public nft;
    
    //Pass in the name of the NFT and its symbol.
    constructor(
        string memory _nftName, 
        string memory _nftSymbol,
        address _volcanoTokenAddress
        ) 
        ERC721(_nftName, _nftSymbol) {
            volcanoToken = VolcanoCoin(_volcanoTokenAddress);
            _tokenId = 0;
            _price = 0.01 ether;
            _volcanoPrice = 1;
        }
    
    //Pay with Volcano token.
    function payVolcano(uint256 _volcanoAmount) public {
        volcanoAmount_ = _volcanoAmount;
        require(_volcanoAmount == _volcanoPrice, "NFT price is 1 VCC!!");
        volcanoToken.transfer(_volcanoAmount, msg.sender, address(this));
    }

    //This NFT stores a string.
    function mint(string memory _nft) external payable {
        if (msg.value < _price) {
            if (volcanoAmount_ < _volcanoPrice) revert("NFT price is 0.01 ETH or 1 VCC!!");
        }
        volcanoAmount_ = 0;
        _tokenId++;
        super._mint(msg.sender, _tokenId);
        nft[_tokenId] = _nft;
    }

    //Transfer the NFT to a given addres.
    function transfer(address from_, address to_, uint256 tokenId_) external {
        super._transfer(from_, to_, tokenId_);
    }

    //Withdraw NFT sales earnings.
    function withdrawal(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }

    //Volcano token contract balance.
    function getVolcanoContractBalance() public view returns (uint) {
        return volcanoToken.getUserBalances(address(this));
    }

    //Volcano token user balance.
    function getVolcanoUserBalance() public view returns (uint) {
        return volcanoToken.getUserBalances(msg.sender);
    }
}