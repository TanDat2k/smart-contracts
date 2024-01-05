require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-etherscan');
const metamask_private_key =
  '0x' + '0d2b6bc308dfeb787e104a09f97d0499ebe802174d10d544a657dd2107973b8a';
const etherscanAPIKey = 'QI8P7Z4BY8PVUMD2ZQ4HXAYA4HFKAX1ND2';
module.exports = {
  solidity: '0.8.0',
  networks: {
    sepolia: {
      url: 'https://eth-sepolia.g.alchemy.com/v2/F-fqVnfKPkMzxYLjzsPeDbnS5bmc9ZnJ',
      accounts: [metamask_private_key],
    },
  },
  etherscan: {
    apiKey: etherscanAPIKey,
  },
};
