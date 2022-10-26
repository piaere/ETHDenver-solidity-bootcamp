// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

contract volcanoCoin is Ownable {
    uint256 public totalSupply = 10000;
    address Owner;

    constructor() {
        Owner = owner();

        balances[Owner] = totalSupply;
    }

    mapping(address => uint256) public balances;

    struct Payment {
        address recipient;
        uint amount;
    }

    mapping(address => Payment[]) internal payments;

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
        recordPayment(msg.sender, _recipient, _amount);
        emit transferEvent(_recipient, balances[_recipient]);
    }

    function viewPaymentsRecord(address _addy)
        public
        view
        returns (Payment[] memory)
    {
        return payments[_addy];
    }

    function recordPayment(
        address _from,
        address _to,
        uint _amount
    ) internal {
        payments[_from].push(Payment(_to, _amount));
    }
}
