// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Metadata.sol';
import './ERC721.sol';

contract ERC721Connector is ERC721Metadata, ERC721 {

    // array to store our nfts;
    string[] public kryptoBirdz;

    mapping(string => bool) _kryptoBirdzExists;

    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {

    }

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdzExists[_kryptoBird], 'Error - krypto bird already exists');

        kryptoBirdz.push(_kryptoBird);
        uint _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptoBird] = true;
    }
}
