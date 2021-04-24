const { assert } = require("chai");

const Color = artifacts.require("./Color.sol")

require("chai")
    .use(require("chai-as-promised"))
    .should();

contract("Color", (accounts) => {
    let contract;

    describe("deployment", async() => {
        it("is deployed", async () => {
            contract = await Color.deployed();
            const address = contract.address;
            assert.notEqual(address, "");
        });
    });
});