require('dotenv').config();
require("@nomicfoundation/hardhat-toolbox");

const { API_URL, PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  defaultNetwork: "polygon_mumbai",
  networks: {
     hardhat: {},
     polygon_mumbai: {
        url: API_URL,
        accounts: [`0x${PRIVATE_KEY}`]
     }
  },
};

