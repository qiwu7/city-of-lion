// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * a. nft to point to an address
 * b. keep track of the token ids
 * c. keey track of token owner addresses to token ids
 * d. keep track of how many tokens an owner address has
 * e. create an event that emits a transfer log - contract address,
 *    where it is being minted to, the id
 */
contract ERC721 {

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;
    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownerTokenCount;

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), 'ERC721: minting to the zero address');
        require(!_exists(tokenId), 'ERC721: token already minted');

        _tokenOwner[tokenId] = to;
        _ownerTokenCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    // check if tokenId exists
    function _exists(uint256 tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }
}
