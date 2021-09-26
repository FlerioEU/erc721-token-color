Sample ERC-712 implementation
===

Description
---

This repository has followed this [tutorial](https://www.youtube.com/watch?v=YPbgjPPC1d0&ab_channel=DappUniversity) to create a simple [ERC-712](http://erc721.org/) implementation but has evolved a bit since then. The ERC-712 is an interface which defines how [Non-fungible tokens (NFT)](https://ethereum.org/en/nft/) are implemented.

Prerequisites
---

+ [yarn](https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable) 
+ [Truffle](https://www.trufflesuite.com/tutorial)
`npm install truffle -g` or `yarn global add truffle`
+ [Ganache](https://www.trufflesuite.com/ganache)
+ [MetaMask Browser Extension](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) or any other wallet capable of connecting to a local ethereum network

<b>Hint</b>: If you are using Visual Studio Code with the Solidity Extension you might need to adjust some settings: https://github.com/juanfranblanco/vscode-solidity#openzeppelin)

Install
---
After cloning this repository run: 
`yarn install`
 
If you are using windows and run into the issue that the openzepplin imports are not importing please open the project using [WSL2](https://docs.microsoft.com/de-de/windows/wsl/install-win10) and try again

Run
---

First you need to start Ganache and copy a private key and import it into MetaMask. Keep Ganache running in the background.
You will need to configure the local blockchain created by Ganache into MetaMask. 

Deploy the smart contract: `truffle migrate`

Run the frontend: `yarn serve` 

You should get prompted by MetaMask to connect a Wallet to this application.
After connecting your wallet you can enter a new Color Hexcode into the field and hit "MINT". You should get prompted by MetaMask to confirm the transaction

Additional Commands:
---

To run the tests: `truffle test`

To overwrite the current deployed contract after a change: `truffle migrate --reset`

Deployment
---
To deploy this project to a public network you have to do some stuff. Deployment on the public test network `ropsten` is already preconfigured but a `secrets.json` is required at the root of the project. This file needs to look like this:

```json
{ 
    "mnemonic": "<your-mnemonic>",
    "endpoint": "<your-project-endpoint>"
}
```

To generate a mnemonic you can run the command `npx mnemonics`. This will generate a phrase for you. Put the generated phrase into the mnemonic. It will look something like this: `siege unaware display comic ball sing above view cradle alter chaos idea`.
The mnemonic is used to generate some wallet keys.

For deployment you will need some funds within your wallet. For public test networks you can use a `faucet`. I used [this](https://faucet.ropsten.be/) faucet for the ropsten test network. Receiving funds might differ from network to network. On this site you have to enter a public adress that you can get using your mnemonic. For the ropsten network enter the truffle console using `truffle console --network ropsten`. After entering the console run `web3.eth.getAccounts()`. You should see a list of adresses. Take the first and enter it into the `faucet`. After some time you should receive a bit of ETH. You can check your balance within the truffle console using `web3.eth.getBalance("<wallet-address>")`

Now your wallet it ready but you still need a node which can deploy the Smart Contract for you. For this i created an account on infura.io and created an Ethereum Project. After creating the project you should find a URL that looks something like this: `wss://<public-network>.infura.io/ws/v3/<your-project-id>`. Copy this and enter it into the `endpoint` field of your `secrets.json`. 

**Note:** In theory you could also run your own node instead but i have no experience with it yet. :)

**Now you are ready to deploy it!** Go back into the truffle console using `truffle console --network ropsten` and run `truffle migrate`. After the process has finished you can get the address of the smart contract by using `let c = await Color.deployed()` followed by `Color.address`. 

**Don't forget to import the account you generated with the mnemonics into `Metamask` and switch to the network  you deployed to.**

---

Hint: The `/abis/Color.json` folder retains the address of the Smart Contract on each different network.

Hint: If you want to use a different network other than ropsten you need to add it to `truffle-config.js`. You can use the `ropsten` configuration as a template

---
Potential extensions:
---
+ Owner of token can transfer it (webclient)
+ Token owner can create offer or receive offer for their token

Interesting links:
---
* ERC721 interface: http://erc721.org/
* OpenZepplin library: https://github.com/OpenZeppelin/openzeppelin-contracts
* Truffle suite: https://www.trufflesuite.com/
* Deploying on a test network: https://www.youtube.com/watch?v=roHoOZXIxYs
