// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const NounsIVotedNFT = await hre.ethers.getContractFactory("NounsIVotedBadge");
  const nounsIVoted = await NounsIVotedNFT.deploy();

  await nounsIVoted.deployed();

  let txn;
  txn = await nounsIVoted.claimBadge(271);
  await txn.wait();

  console.log(`Deployed to: ${nounsIVoted.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
