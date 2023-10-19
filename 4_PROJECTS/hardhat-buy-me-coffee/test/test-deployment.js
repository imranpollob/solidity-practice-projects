const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Testing", function () {
  async function getEtherBalance(_address) {
    const balance = await ethers.provider.getBalance(_address);
    return ethers.formatEther(balance);
  }

  async function printBalances(_addresses) {
    for (const address of _addresses) {
      console.log(`Address: ${await address.getAddress()}  Balance: ${await getEtherBalance(address)}`);
    }
  }

  async function printEntries(_entries) {
    for (const entry of _entries) {
      console.log(entry.message);
    }
  }

  it("Should withdraw the total contract balance to the owner", async function () {
    // create some accounts
    const [owner, imran, pollob, tuly] = await ethers.getSigners();

    // deploy the contract
    const buyMeACoffee = await ethers.deployContract("BuyMeACoffee");
    console.log("BuyMeACoffee contract address:", buyMeACoffee.target);

    // print the balance of each accounts
    const addresses = [owner, imran, pollob, tuly];
    console.log("--- Initial balance ---");
    printBalances(addresses);
    const ownerInitialBalance = await ethers.provider.getBalance(owner);
    const imranInitialBalance = await ethers.provider.getBalance(imran);

    // buy some coffee
    const tip = { value: ethers.parseEther("1") };
    console.log("--- Tip ---", tip);
    await buyMeACoffee.connect(imran).buyACoffee("Hi from Imran", tip);
    await buyMeACoffee.connect(pollob).buyACoffee("Pollob says hi", tip);
    await buyMeACoffee.connect(tuly).buyACoffee("Tuly smiles", tip);

    expect(await ethers.provider.getBalance(imran)).to.lessThan(imranInitialBalance);

    // print the balances again
    console.log("--- Balance after buying a coffee ---");
    printBalances(addresses);

    // withdraw the money
    const contractBalance = await ethers.provider.getBalance(buyMeACoffee.target);
    await buyMeACoffee.connect(owner).withdraw(contractBalance);

    // check balance of the owner
    console.log("--- Owner balance: ---", await getEtherBalance(owner.address));

    expect(await ethers.provider.getBalance(buyMeACoffee.target)).to.equal(0);
    expect(await ethers.provider.getBalance(owner)).to.greaterThan(ownerInitialBalance);
  });
});

async function main() {
  // print entries
  const entries = await buyMeACoffee.getEntries();
  console.log("--- Printing Entries ---");
  await printEntries(entries);
}
