const { expect } = require("chai");

describe("Deploy the contract", function () {
  it("test it", async function () {
    const [owner] = await ethers.getSigners();
    console.log(owner.address);
    const hardhatToken = await ethers.deployContract("BuyMeACoffee");
    console.log("Contract deployed to:", hardhatToken.target);
    const ownerBalance = owner.balance;
    console.log(ownerBalance);
  });
});
