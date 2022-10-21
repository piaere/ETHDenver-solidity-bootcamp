// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8;

contract volcanoCoin {
    uint256 public totalSupply = 10000;
    address Owner;

    constructor() {
        Owner = msg.sender;

        balances[Owner] = totalSupply;
        totalSupply = 0;
    }

    modifier onlyOwner() {
        if (msg.sender == Owner) {
            _;
        }
    }

    mapping(address => uint256) public balances;

    struct Payment {
        address recipient;
        uint amount;
    }

    event newTotalSupply(uint256);
    event transferEvent(address, uint256);

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit newTotalSupply(totalSupply);
    }

    function getUserBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function transfer(uint256 _amount, address _recipient) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit transferEvent(_recipient, balances[_recipient]);
    }
}