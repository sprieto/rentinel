const Web3 = require("web3");
const ganache = require("ganache");
const web3 = new Web3(ganache.provider());


var assert = require('assert');

beforeEach(() => {
  // Get a list of all accounts
  web3.eth.getAccounts().then((fetchedAccounts) => {
    console.log(fetchedAccounts);
  });
});

describe("Rentinel", () => {
  it("deploys a contract", () => {});
});
