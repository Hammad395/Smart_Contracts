// SPDX-License-Identifier: MIT

pragma solidity >= 0.7.0;
contract Receiver {
    // "owner" will store the address of the person who deploy the contract
    // "event" is create to receive to Ethers
    address owner;
    event Received(address receiverAddress, uint value);
    
    // In constructor  address of owner is assigned to "owner"
    constructor(){
        owner = msg.sender;
    }

    // function will emit the event to receive Ethers
    function reciever() public payable {
        emit Received(owner, msg.value);
    }
    
    // function to show the balance 
    function getBalance() public view returns (uint256) {
        return msg.sender.balance;
    }
}
