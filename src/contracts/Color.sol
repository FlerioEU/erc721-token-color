// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Color is ERC721Enumerable {
    string[] public colors;
    address public owner;

    mapping(string => bool) _colorExists;

    constructor() ERC721("Color", "COLOR") {
        owner = msg.sender;
    }

    // we would like to restrict the minter to one or more persons
    function mint(string memory _color) public {
        require(msg.sender == owner);
        // check if unique
        require(!_colorExists[_color]);
        // check if hexcode
        require(isHexCode(_color));

        colors.push(_color);
        uint _id = colors.length;
        _mint(msg.sender, _id);

        _colorExists[_color] = true;
    }

   function isHexCode(string memory _str) private pure returns (bool){
        bytes memory b = bytes(_str);
        if (b.length != 7) {
            return false;
        }

        // first character is '#'
        if(b[0] != 0x23) {
            return false;
        }

        for(uint i = 1; i < b.length; i++){
            bytes1 char = b[i];

            // check if character is 0-9 and A-F
            if (!(char >= 0x30 && char <= 0x39) && 
                !(char >= 0x41 && char <= 0x46) ) {
                return false;
            }
        }

        return true;
    }
}