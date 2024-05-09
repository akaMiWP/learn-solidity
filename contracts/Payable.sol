// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Payable {
    
    event Deposit(address sender, uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    event Transfer(address to, uint amount, uint balance);

    address payable public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be a sender");
        _;
    }

    // Allow deploy with ethers topup
    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    // A transaction with ethers sent to this contract will fail
    function notPayable() public {

    }

    function withdraw(uint _amount) public onlyOwner {
        owner.transfer(_amount);
        emit Withdraw(_amount, address(this).balance);
    }

    function transfer(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
        emit Transfer(_to, _amount, address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

/// Payable functions and constructors can receive ethers
/// Payable address can send ethers