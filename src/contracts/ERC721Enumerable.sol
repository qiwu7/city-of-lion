// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private tokenIndexes;

    // mapping of owner to list of all owner token IDs
    mapping(address => uint256[]) private ownerTokens;

    // mapping from token Id to index of the owner token list
    mapping(uint256 => uint256) private ownerTokensIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256) {
        return allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns (uint256) {
        require(_index < totalSupply(), 'index is out of range');
        return allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {
        require(_index < balanceOf(_owner), 'owner index is out of range');
        return ownerTokens[_owner][_index];
    }

    function _mint(address _to, uint256 _tokenId) internal override(ERC721) {
        super._mint(_to, _tokenId);
        _addTokenToAllTokensEnumeration(_tokenId);
        _addTokenToOwnerEnumeration(_to, _tokenId);
    }

    function _addTokenToAllTokensEnumeration(uint256 _tokenId) private {
        tokenIndexes[_tokenId] = allTokens.length;
        allTokens.push(_tokenId);
    }

    function _addTokenToOwnerEnumeration(address _owner, uint256 _tokenId) private {
        ownerTokensIndex[_tokenId] = ownerTokens[_owner].length;
        ownerTokens[_owner].push(_tokenId);
    }
}