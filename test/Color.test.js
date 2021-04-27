const { assert } = require("chai");

const Color = artifacts.require("./Color.sol")

require("chai")
    .use(require("chai-as-promised"))
    .should();

contract("Color", (accounts) => {
    let contract;

    let owner = accounts[0];
    let nonOwner = accounts[1];
    let minter = accounts[2];

    before(async() => {
        contract = await Color.deployed();
    });

    describe("deployment", async() => {
        it("is deployed", async () => {
            const address = contract.address;
            assert.notEqual(address, "");
            assert.notEqual(address, 0x0);
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
        });

        it("has a name", async() => {
            const name = await contract.name();
            assert.equal(name, "Color");
        });

        it("has a symbol", async() => {
            const symbol = await contract.symbol();
            assert.equal(symbol, "COLOR");
        });
    });

    describe("security", async() => {
        it("non owner cannot create new tokens", async () => {
            await contract.mint("#FFFFF2", {from : nonOwner}).should.be.rejected;
        });

        it("minter can create new tokens", async() => {
            await contract.addMinter(minter).should.be.fulfilled;
            await contract.mint("#FFFFF3", {from: minter}).should.be.fulfilled;
        });
    });

    describe("minting", async() => {
        it("creates a new token", async() => {
            const result = await contract.mint("#EC058E");
            const totalSupply = await contract.totalSupply();
            const event = result.logs[0].args;

            assert.equal(totalSupply, 1);
            assert.equal(event.tokenId.toNumber(), 1, "id is wrong");
            assert.equal(event.from, 0x0000000000000000000000000000000000000000, "from is wrong");
            assert.equal(event.to, accounts[0], "to is wrong");
        });

        it("only creates unique tokens", async () => {
            await contract.mint("#FFFFFF").should.be.fulfilled;
            await contract.mint("#FFFFFF").should.be.rejected;
        });

        it("only creates valid tokens", async () => {
            await contract.mint("Kappa123").should.be.rejected;
            await contract.mint("FF#1231").should.be.rejected;
            await contract.mint("#ffffff").should.be.rejected;
            await contract.mint("#01f").should.be.rejected;
            await contract.mint("").should.be.rejected;
            await contract.mint(null).should.be.rejected;
            await contract.mint(undefined).should.be.rejected;
            await contract.mint(10).should.be.rejected;
        });
    });

    describe("indexing", async() => {
        it("lists all colors", async() => {
            const promise1 = contract.mint("#5386E4");
            const promise2 = contract.mint("#FFFFF1");
            const promise3 = contract.mint("#000000");

            await Promise.all([promise1, promise2, promise3]).should.be.fulfilled;
            const totalSupply = await contract.totalSupply();

            let color;
            let result = [];

            for(let i = 1; i <= totalSupply; i++) {
                color = await contract.colors(i - 1);
                result.push(color);
            }

            const expected = ["#5386E4", "#EC058E","#FFFFFF", "#FFFFF1", "#000000", "#FFFFF3"]

            result.sort();
            expected.sort();
            
            assert.equal(result.join(","), expected.join(","));
        });
    });
});