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

  /*

  IMPERSONATE: 0x8323f1C687F7e2296EC71eE3549a7430ea7Ec730
  prop 271 voted FOR



  */

  before("deploy the contract's instances first", async function () {
    //DEPLOY METADATA
    const badgeMetadataFactory = await hre.ethers.getContractFactory('NounsIVotedBadgeMetadata');
    metadataContract = await badgeMetadataFactory.deploy("0x6229c811D04501523C6058bfAAc29c91bb586268", "0x000000000000000000000000000000000000dead");
    await metadataContract.deployed();

    const mainContractFactory = await hre.ethers.getContractFactory('NounsIVotedBadge');
    mainContract = await mainContractFactory.deploy(metadataContract.address);
    await mainContract.deployed();

    [owner, acc1, acc2, acc3] = await ethers.getSigners();


    await new Promise((r) => setTimeout(r, 700));

  });

  it("Should revert with address not voted in proposal", async function () {
    await expect(mainContract.connect(acc1).claimBadge(271)).to.be.revertedWithCustomError(
      mainContract, 
      "AddressNotVotedInProposalError"
    );
  });
  
  it("Should revert with voter has more than zero votes", async function () {

    const impersonatedSigner = await ethers.getImpersonatedSigner("0x36A5Bc205DF1ED65C86301022cfc343a6ce546ff");

    await expect(mainContract.connect(impersonatedSigner).claimBadge(271)).to.be.revertedWithCustomError(
      mainContract, 
      "VoterHasMoreThanZeroVotesError"
    );
  });

  it("Claim a badge", async function () {

    const impersonatedSigner = await ethers.getImpersonatedSigner("0x8323f1C687F7e2296EC71eE3549a7430ea7Ec730");

    await expect(mainContract.connect(impersonatedSigner).claimBadge(271)).to.emit(mainContract, "VoterBadgeMinted");

  });

  it("Should revert with voter already minted proposal badge", async function () {
    const impersonatedSigner = await ethers.getImpersonatedSigner("0x8323f1C687F7e2296EC71eE3549a7430ea7Ec730");

    await expect(mainContract.connect(impersonatedSigner).claimBadge(271)).to.be.revertedWithCustomError(
      mainContract, 
      "AlreadyMintedProposalBadgeError"
    );
  });

  it("Return URI", async function () {

    let tokenUri = await mainContract.tokenURI(1);

    console.log("URI: ", tokenUri);

  });  

});
