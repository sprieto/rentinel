pragma solidity ^0.8.10;

//dApp Rentinel: Your deposit is secured

contract Rentinel {
/  address payable landlord;
  address payable tenant;
  address payable property;
  address payable adjuster;
  uint public deposit;
  uint public rent;
  uint public startDate;
  uint public endDate;
  bool public status;

  struct Property {
    string phAddress;
    string state;
    string zipCode;
    string country;
  }

  constructor(){
    property = msg.sender;
  }

// Errors allow you to provide information about
// why an operation failed. They are returned
// to the caller of the function.
  error InsufficientBalance(uint requested, uint available);

  function payDeposit(address property, uint amount) public {
    require(msg.sender == tenant);
    if (amount > balances[msg.sender])
    revert InsufficientBalance({
      requested: amount,
      available: balances[msg.sender]
    });
   balances[msg.sender] -= amount;
   balances[receiver] += amount;
   emit Sent(msg.sender, receiver, amount);
      /* //tenant = msg.sender;
      require(msg.sender == tenant);
      balances[receiver] += amount;
       */
  }





  function payRent() payable external {

  }

  function returnDepositAuto () public payable {
    while(status = true){
      if (block.timestamp > endDate){
        payable(tenant).transfer(deposit);
      }
    }
  }

  function initDispute() {
    if (block.timestamp < startDate
        && block.timestamp < endDate){
          status = false;
    }
  }

}
