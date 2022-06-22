// SPDX-License-Identifier: MIT

// specifying the solidity version
pragma solidity >=0.6.0 <0.9.0;

// creat token XYZ
contract XYZ {

   /*    "minter" will store the address of the person who deploy the contract
         "amount" will store the total amount of token
         "mapping" will return the balance of given address
         "hardaccount" will store the given address at which 50% of transaction is sent
         "event" is create to send tokens
   */

    address public minter;    
    uint amount;              
    mapping (address => uint) public balances;  
    address hardAccount;     
    event Sent(address from, address to, uint amount);   


   /*     constructor is created to  set the account of minter, tokens, address
         and minter will get the all tokens
   */

    constructor(){                                                   
        minter = msg.sender;                                         
        amount = 100000;                                             
        hardAccount = 0x9A020cFcA5F5CFcE8FE48E92c55eB14C07A6495d;   
        balances[msg.sender] = amount;                               
    }

    function send(uint sentAmount) public {

      //  condition to check weither account will have sufficent amount of tokens
        require(amount <= balances[msg.sender], "Insufficient balance.");

      // subtract the tokens which are send to other account
        balances[msg.sender] -= sentAmount;

      // 20% of sending amount will be burn
        balances[address(this)] += (sentAmount * 20/100);
        emit Sent(msg.sender, address(this), sentAmount);

      // 30% of sending amount will go to contract owner address
        balances[msg.sender] += (sentAmount * 30/100);
        emit Sent(msg.sender, msg.sender, sentAmount);

      // 50% of sending amount will go to the given address
        balances[hardAccount] += (sentAmount * 50/100);
        emit Sent(msg.sender, hardAccount, sentAmount);
   }
}