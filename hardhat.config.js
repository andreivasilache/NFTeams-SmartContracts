require("@nomiclabs/hardhat-waffle");
const { INFURA_KEY, DEPLOY_WALLET_SECRET } = require("./secret");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    ropsten: {
      url: INFURA_KEY, //Infura url with projectId
      accounts: [DEPLOY_WALLET_SECRET], // add the account that will deploy the contract (private key)
    },
  },
};
