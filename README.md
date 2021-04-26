Sample ERC712 implementation WIP
===

Description
---

This repository currently follows this [tutorial](https://www.youtube.com/watch?v=YPbgjPPC1d0&ab_channel=DappUniversity) to create a simple [ERC712](http://erc721.org/) implementation. The ERC712 is an interface which defines how [Non-fungible tokens (NFT)](https://ethereum.org/en/nft/) are implemented.

The starterkit from dappuniversity has been used:
https://github.com/dappuniversity/starter_kit


Prerequisites
---

+ [npm](https://www.npmjs.com/get-npm) 
+ Truffle:
`npm install truffle -g`
+ [Ganache](https://www.trufflesuite.com/ganache)
+ [MetaMask Browser Extension](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) or any other wallet capable of connecting to a local ethereum network

<b>Hint</b>: If you are using Visual Studio Code with the Solidity Extension you will need to adjust some settings: https://github.com/juanfranblanco/vscode-solidity#openzeppelin)

Install
---
After cloning this repository run: 
`npm install`
 
If you are using windows and run into the issue that the openzepplin imports are not importing please open the project using [WSL2](https://docs.microsoft.com/de-de/windows/wsl/install-win10) and try again

Run
---

First you need to start Ganache and copy a private key and import it into MetaMask. Keep Ganache running in the background.
You will need to configure the local blockchain created by Ganache into MetaMask. 

Deploy the smart contract: `truffle migrate`

Run the frontend: `npm run start` 

You should get prompted by MetaMask to connect a Wallet to this application.
After connecting your wallet you can enter a new Color Hexcode into the field and hit "MINT". You should get prompted by MetaMask to confirm the transaction

Additional Commands:
---

To run the tests: `truffle test`

To overwrite the current deployed contract after a change: `truffle migrate --reset`

To run the frontend: `npm run start` 

Potential extensions:
---
+ Only the deployer of the contract can mint new tokens
+ Deployer can assign new minters
+ Frontend shows your own tokens in one section and tokens owned by other people in a different section to emphasize ownership

Interesting links:
---
* ERC721 interface: http://erc721.org/
* OpenZepplin library: https://github.com/OpenZeppelin/openzeppelin-contracts
* Truffle suite: https://www.trufflesuite.com/
* Deploying on a test network: https://forum.openzeppelin.com/t/connecting-to-public-test-networks-with-truffle/2960