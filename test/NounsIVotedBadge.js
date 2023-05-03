const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("NounsIVoted", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.

  let mainContract, metadataContract, svgsContract, fontContract;

  before("deploy the contract's instances first", async function () {

    const svgsFactory = await hre.ethers.getContractFactory('NoggleSVGs');
    svgsContract = await svgsFactory.deploy();
    await svgsContract.deployed();

    /*
    const fontFactory = await hre.ethers.getContractFactory('LondrinaRegularFont');
    fontContract = await fontFactory.deploy();
    await fontContract.deployed();
    */

    //DEPLOY METADATA
    const badgeMetadataFactory = await hre.ethers.getContractFactory('NounsIVotedBadgeMetadata');
    metadataContract = await badgeMetadataFactory.deploy(svgsContract.address, svgsContract.address);
    await metadataContract.deployed();


    await new Promise((r) => setTimeout(r, 700));

  });
 
  describe("Token URI Test", function () {
    it("Return URI", async function () {

      let tokenUri = await metadataContract.tokenURI(2, 6713, 1);

      console.log("URI: ", tokenUri);

    });   
  });
});
