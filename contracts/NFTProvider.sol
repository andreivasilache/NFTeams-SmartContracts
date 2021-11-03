import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

pragma solidity ^0.8.0;

/**
    The NFTs are created by entity (eg. Company) and can be assigned to multiple users
 */

contract NFTProvider is ERC721URIStorage  {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("GameItem", "ITM") {}

    function awardNFT(address wallet, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(wallet, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
