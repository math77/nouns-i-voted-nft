require('dotenv').config();

require("@nomicfoundation/hardhat-toolbox");
require('hardhat-contract-sizer');

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: {
    version: '0.8.18',
    settings: {
      optimizer: {
        enabled: true,
        runs: 10_000,
      },
    },
  },

  networks: {
    hardhat: {
      forking: {
        url: `https://eth-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}`,
        blockNumber: 17190600
      }
    }
  },

  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
    only: []
  },

};
