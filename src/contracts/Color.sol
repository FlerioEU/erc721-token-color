// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Color is ERC721Enumerable {
    string[] public colors;
    address public owner;

    mapping(string => bool) _colorExists;
    mapping(address => bool) public minter;

    constructor() ERC721("Color", "COLOR") {
        owner = msg.sender;
        minter[owner] = true;
    }

    function mint(string memory _color) public {
        require(minter[msg.sender], "Only dedicated minter can mint new tokens!");
        require(!_colorExists[_color], "This color already exists!");
        require(_isHexCode(_color), "This is not a valid Hexcode. Uppercase only!");

        colors.push(_color);
        uint _id = colors.length;
        _safeMint(msg.sender, _id);

        _colorExists[_color] = true;
    }

    function addMinter(address _to) public {
        require(msg.sender == owner, "Only owner can assign new minters!");
        minter[_to] = true;
    }

    function transfer(address from, address to, uint256 tokenId) public {
        _transfer(from, to, tokenId);
    }

   function _isHexCode(string memory _str) private pure returns (bool){
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