Sample ERC712 implementation WIP
===

Description
---

This repository currently follows this [tutorial](https://www.youtube.com/watch?v=YPbgjPPC1d0&ab_channel=DappUniversity) to create a simple [ERC712](http://erc721.org/) implementation. The ERC712 is an interface which defines how [Non-fungible tokens (NFT)](https://ethereum.org/en/nft/) are implemented.

The starterkit from dappuniversity has been used:
https://github.com/dappuniversity/starter_kit


Prerequisites
---

+ NPM: https://www.npmjs.com/get-npm
+ Truffle:
`npm install truffle -g`
+ Ganache: https://www.trufflesuite.com/ganache

<b>Hint</b>: If you are using Visual Studio Code with the Solidity Extension you will need to adjust some settings: https://github.com/juanfranblanco/vscode-solidity#openzeppelin)

Install
---
After cloning this repository run: 
`npm install`
 
If you are using windows and run into the issue that the openzepplin imports are not importing please open the project using [WSL2](https://docs.microsoft.com/de-de/windows/wsl/install-win10) and try again

Run
---

To deploy the smart contract: `truffle migrate`

To run the frontend: `npm run dev` 


Interesting links:
* ERC721 interface: http://erc721.org/
* OpenZepplin library: https://github.com/OpenZeppelin/openzeppelin-contracts
* Truffle suite: https://www.trufflesuite.com/