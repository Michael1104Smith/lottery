const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
  'output cat six practice patch travel party country announce clutch chief skirt',
  'https://rinkeby.infura.io/v3/4958272017084c51a75ac539bc44f59d'
);
const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account', accounts[0]);

    const result = await new web3.eth.Contract(interface)
        .deploy({ data: bytecode })
        .send({ gas: '1000000', from: accounts[0] });

    console.log(JSON.stringify(interface));
    console.log('Contract deployed to', result.options.address);
};
deploy();
