require("dotenv").config();  //dotenvを読み込む
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.9",
  networks: {
    // イーサメインネット
    // ethMain: {
    //     url: process.env.API_URL_ETH_MAIN,
    //     accounts: [process.env.PRIVATE_KEY],
    // },
    // ポリゴンメインネット
    // polygonMain: {
    //     url: process.env.API_URL_POLYGON_MAIN,
    //     accounts: [process.env.PRIVATE_KEY],
    // },
    // Goerliテストネット
    goerli: {
      url: process.env.API_URL_GOERLI,
      accounts: [process.env.PRIVATE_KEY_TEST_ACCOUNT],
    },
    // Mumbaiテストネット
    mumbai: {
      url: process.env.API_URL_MUMBAI,
      accounts: [process.env.PRIVATE_KEY_TEST_ACCOUNT],
    },
  },
  etherscan: {
    // Polygonscan
    // apiKey: process.env.POLYGONSCAN_API_KEY",
    // Etherscan
    apiKey: process.env.SCAN_API_KEY,
  },
};
