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

    function _mint(address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), 'ERC721: minting to the zero address');
        require(!_exists(_tokenId), 'ERC721: token already minted');

        _tokenOwner[_tokenId] = _to;
        _ownerTokenCount[_to] += 1;

        emit Transfer(address(0), _to, _tokenId);
    }

    // check if tokenId exists
    function _exists(uint256 tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), 'owner queries about zero address');
        return _ownerTokenCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];

        require(owner != address(0), 'tokenId does not exist');

        return owner;
    }
}
