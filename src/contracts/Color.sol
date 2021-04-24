// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Color is ERC721Enumerable {
    string[] public colors;
    mapping(string => bool) _colorExists;

    constructor() ERC721("Color", "COLOR") {
    }

    // we would like to restrict the minter to one or more persons
    function mint(string memory _color) public {
        

        // check if unique
        require(!_colorExists[_color]);

        colors.push(_color);
        uint _id = colors.length;
        _mint(msg.sender, _id);

        // can i use the colors array to check if the color already exists and should not be minted?
        _colorExists[_color] = true;
    }
}