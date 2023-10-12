// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

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

async function main() {
  // create some accounts
  const [owner, imran, pollob, tuly] = await ethers.getSigners();

  // deploy the contract
  const buyMeACoffee = await ethers.deployContract("BuyMeACoffee");
  console.log("BuyMeACoffee contract address:", buyMeACoffee.target);

  // // print the balance of each accounts
  const addresses = [owner, imran, pollob, tuly];
  console.log("--- Initial balance ---");
  printBalances(addresses);

  // // buy some coffee
  const tip = { value: ethers.parseEther("1") };
  console.log("--- Tip ---",tip);
  await buyMeACoffee.connect(imran).buyACoffee("Hi from Imran", tip);
  await buyMeACoffee.connect(pollob).buyACoffee("Pollob says hi", tip);
  await buyMeACoffee.connect(tuly).buyACoffee("Tuly smiles", tip);

  // print the balances again
  console.log("--- Balance after buying a coffee ---");
  printBalances(addresses);

  // withdraw the money
  const contractBalance = await ethers.provider.getBalance(buyMeACoffee.target);
  await buyMeACoffee.connect(owner).withdraw(contractBalance);

  // check balance of the owner
  console.log("--- Owner balance: ---", await getEtherBalance(owner.address));

  // print entries
  const entries = await buyMeACoffee.getEntries();
  console.log("--- Printing Entries ---");
  await printEntries(entries);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
