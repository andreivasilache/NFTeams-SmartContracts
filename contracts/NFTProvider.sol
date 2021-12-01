import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

import "@openzeppelin/contracts/utils/Counters.sol";

pragma solidity ^0.8.0;

/**
    The NFTs are created by entity (eg. Company) and can be assigned to multiple users
 */

contract NFTProvider is ERC721URIStorage, ERC721Enumerable  {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("ASSIST NFT", "GAME-NFT") {}

    function awardNFT(address wallet, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(wallet, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

     function awardMultipleWallets(address[] memory  wallets, string memory tokenURI) public returns (uint256) {
          for(uint index = 0; index<wallets.length; index++){
            this.awardNFT(wallets[index], tokenURI);
        }
    }

    function getAllTokensOfOwner(address _owner) public view returns (string[] memory) {
        
        string[] memory _NFTSOfOwner = new string[](ERC721.balanceOf(_owner));
        uint i;
        uint currentTokenID;

        for (i=0;i<ERC721.balanceOf(_owner);i++){
            currentTokenID = ERC721Enumerable.tokenOfOwnerByIndex(_owner, i);
            _NFTSOfOwner[i] = tokenURI(currentTokenID);
        }
        return (_NFTSOfOwner);
    }
    
     function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}
