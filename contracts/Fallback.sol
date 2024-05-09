// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Fallback {

    event Log(uint gas);

    /// This is a fallback function when receive send/ transfer/ call function
    /// send, transfer forwards 2300 gas to this fallback function
    /// call forwards all gas
    receive() external payable {
        emit Log(gasleft());
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call { value: msg.value }("");
        require(sent, "Failed to send ether");
    }
}