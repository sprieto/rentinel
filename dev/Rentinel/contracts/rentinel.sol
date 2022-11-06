pragma solidity ^0.8.10;

//dApp Rentinel: Your deposit is secured
//Author: Sergio Prieto

//Environment = dev

contract Rentinel {
  uint public deposit;
  uint public gracePeriod = endDate + 3;
  address payable public landlord;
  address payable public tenant;
  address payable public adjuster;
  address public rentiner;
  uint public startDate;
  uint public endDate;
  bool public status;
  bool public arbitrage = false;
  string public message;

  struct Property {
    string phAddress;
    string state;
    uint zipCode;
    string country;
  }


  enum State { Active, Locked, Release, Inactive }
  State public state;

  modifier condition(bool condition_) {
          require(condition_);
          _;
  }

  error OnlyTenant();
  error OnlyLandlord();
  error OnlyAdjuster();
  error OnlyRentiner();
  error InvalidState();


  modifier onlyTenant() {
      if (msg.sender != tenant)
          revert OnlyTenant();
      _;
  }

  modifier onlyLandlord() {
      if (msg.sender != landlord)
          revert OnlyLandlord();
      _;
  }

  modifier onlyAdjuster() {
      if (msg.sender != adjuster)
          revert OnlyAdjuster();
      _;
  }

  modifier onlyRentiner() {
      if (msg.sender != rentiner)
          revert OnlyRentiner();
      _;
  }

  modifier inState(State state_) {
      if (state != state_)
          revert InvalidState();
      _;
  }

  //event Aborted();
  //event PurchaseConfirmed();
  //event ItemReceived();
  event tenantRefunded();
  event claimProceed();

  constructor() payable {

      tenant = payable(msg.sender);
      deposit = msg.value;
      state = State.Active;

    }

    function refundDeposit (){
      external
      //Anyone can execute
      if (block.timestamp > gracePeriod || state != 'Locked') {
          inState(State.Release)
      }
      emit tenantRefunded();
      state = State.Inactive;
      tenant.transfer(deposit);

      }


    function initDispute (bool disOn, uint value){
        onlyLandlord
        uint claimAmount = value;
        if (block.timestamp > endDate ){
          arbitrage = true;
          inState(State.Locked)
        }
      }



    function setResolution (bool arbitrage) public {
        onlyAdjuster
        bool deduction;
        uint claimAmount = initDispute.claimAmount;

        if (deduction == false){
          inState(State.Active);
          refundDeposit;

        } else if (deduction == true) {
          deductDeposit(claimAmount);
        }

      }


    function deductDeposit (uint claimAmount){
      onlyAdjuster

      if (value < deposit && state == 'Locked'){
        //send claim ammount
        emit claimProceed();
        landlord.transfer(claimAmount);
        //send remaining balance to tenant
        emit tenantRefunded();
        state = State.Inactive;
        tenant.transfer(deposit);
      }

    }






}
