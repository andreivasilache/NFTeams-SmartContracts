import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.0;

/**
    The NFTs are created by entity (eg. Company) and can be assigned to multiple users
 */

// for testing purposes, delete on implementation
contract FactoryNFT is ERC721URIStorage { 

    using Counters for Counters.Counter; 
    Counters.Counter private _tokenIds;

    constructor() ERC721("Factory NFT", "FTN") {
    }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
