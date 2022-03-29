require("babel-register");
require("babel-polyfill");
require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    mumbai: {
      provider: () =>
        new HDWalletProvider(
          process.env.MNEMONIC,
          `https://rpc-mumbai.maticvigil.com/v1/bd76d9f2e2c3993bbfef0082f25c30d017fc1feb`
        ),
      network_id: 80001,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      gas: 6000000,
      gasPrice: 10000000000,
    },
    polygon: {
      provider: () =>
        new HDWalletProvider(process.env.MNEMONIC, `https://polygon-rpc.com/`),
      network_id: 137,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      gas: 6000000,
      gasPrice: 160000000000,
    },
  },
  contracts_directory: "./src/contracts/",
  contracts_build_directory: "./src/abis/",
  compilers: {
    solc: {
      version: "^0.4.0",
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
