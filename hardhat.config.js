require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  networks: {
    sepolia: {
      url: 'https://eth-sepolia.g.alchemy.com/v2/F-fqVnfKPkMzxYLjzsPeDbnS5bmc9ZnJ',
      accounts: ['e8d6465235b5d811abffc61051d63b68cab272c14c1ad5286818a81774f3f471'],
    },
  },
};