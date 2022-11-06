const path = require('path');
const fs = require('fs');
const solc = require('solc');

const inboxPath = path.resolve(__dirname, 'contracts', 'rentinel.sol');
const source = fs.readFileSync(inboxPath, 'utf8');



const input = {
  language: 'Solidity',
  sources: {
    'rentinel.sol': {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*'],
      },
    },
  },
};

module.exports = JSON.parse(solc.compile(JSON.stringify(input))).contracts[
  'rentinel.sol'
].Rentinel;

module.exports = solc.compile(source, 1).contracts[':Hello'];
