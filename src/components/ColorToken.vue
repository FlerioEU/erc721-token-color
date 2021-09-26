<template>
    <v-container>
        <v-row>
            <v-col md="4" offset-md="4">
                <v-text-field
                    color="primary"
                    v-model="color"
                    placeholder="#FFFFFF">
                    <template v-slot:append>
                        <v-btn
                            depressed 
                            tile
                            color="primary"
                            class="ma-0"
                            @click="mint">
                            Mint
                        </v-btn>
                    </template>
                </v-text-field>
            </v-col>
        </v-row>
        <p><strong>My Tokens</strong> - Connected as: {{ account }}</p>
        <v-row>
            <v-col md="3" v-for="color in myTokens" :key="color.color">
                <v-container class="text-center">
                    <div class="token mb-3" :style="{ backgroundColor: color.color }"/>
                    <p>{{ color.color }}</p>
                    <p>{{ truncate(color.owner) }}</p>
                </v-container>
            </v-col>
        </v-row>
        <p><strong>Others Tokens</strong></p>
        <v-row>
            <v-col md="3" v-for="color in othersTokens" :key="color.color">
                <v-container class="text-center">
                    <div class="token mb-3" :style="{ backgroundColor: color.color }"/>
                    <p>{{ color.color }}</p>
                    <p>{{ truncate(color.owner) }}</p>
                </v-container>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
import Web3 from "web3";
import Color from "../abis/Color.json"

export default {
    name: 'ColorToken',
    data: () => ({
            color: "",
            colors: [],
            account: {},
            totalSupply: 0, 
            contract: {}
        }),
    computed: {
        myTokens() {
            let myTokens = []
            for(const color of this.colors) {
                if(color.owner === this.account) {
                    myTokens = [...myTokens, color]
                }
            }
            return myTokens
        },
        othersTokens() {
            let othersTokens = []
            for(const color of this.colors) {
                if(color.owner !== this.account) {
                    othersTokens = [...othersTokens, color]
                }
            }
            return othersTokens
        }
    },
    async beforeMount() {
        await this.loadWeb3();
        await this.loadBlockChainData();
    },
    methods: {
        // Smart Contract access
        async loadWeb3() {
            if (window.ethereum) {
                window.web3 = new Web3(window.ethereum);
                return window.ethereum.enable();
            }

            if (window.web3) {
                window.web3 = new Web3(window.web3.currentProvider);
                return;
            }

            window.alert("Non-Ethereum browser detected. You should consider trying MetaMask!");
        },
        async loadBlockChainData() {
            const web3 = window.web3;
            // load account
            const accounts = await web3.eth.getAccounts();

            // TODO https://docs.metamask.io/guide/ethereum-provider.html#using-the-provider
            this.account = accounts[0]
            

            const networkId = await web3.eth.net.getId();
            const networkData = Color.networks[networkId];

            if (networkData) {
                const abi = Color.abi;
                const address = networkData.address;
                const contract = new web3.eth.Contract(abi, address);
                const totalSupply = await contract.methods.totalSupply().call();


                this.contract = contract
                this.totalSupply = totalSupply

                for (let i = 1; i <= totalSupply; i++) {
                    const color = await contract.methods.colors(i - 1).call();
                    const tokenOwner = await contract.methods.ownerOf(i).call();
                    this.colors = [...this.colors, {color: color, owner: tokenOwner}]
                }

            } else {
                alert("This smart contract is not deployed on this network!");
            }
        },
        mint()  {
            this.contract.methods.mint(this.color).send({ from: this.account })
            .once("receipt", () => {
                this.colors = [...this.colors, {color: this.color, owner: this.account}]
            });
        },
        // Some helper methods
        truncate(address) {
            // truncate address to '0x877d...529D'
            const prefix = address.substring(0, 6)
            const suffix = address.substring(38, 42)

            return prefix + "..." + suffix
        }
    }
}
</script>

<style>
.token {
     overflow: hidden; 
     height: 150px;
     width: 150px;
     border-radius: 50%;
     display: inline-block;
     border: 1px solid black;
}

.v-application p {
    margin-bottom: 0px;
}
</style>