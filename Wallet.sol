/*Это будет обычный кошелёк, на который можно зачислять и выводить денежные средства, но, по сравнению с обычными кошельками, 
у него будет особенность: возможность совместного доступа. Так, у нашего кошелька будет владелец (тот, кто разместил контракт), 
а также неограниченное количество пользователей. Владелец сможет выводить любые денежные суммы, 
а пользователи — только суммы в пределах установленного лимита. Создавать пользователей и устанавливать для них лимит сможет только владелец.
Такой кошелёк может быть актуален, например, для выплаты вознаграждения участникам проекта, где лидер проекта является также владельцем кошелька.

Вперед*/


// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "/SharedWallet.sol";

contract Wallet is SharedWallet {
    constructor(address initialOwner) SharedWallet(initialOwner) {}
    event MoneyWithdrawn(address indexed _to, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw(uint _amount) external ownerOrWithinLimits(_amount) {
        require(_amount <= getBalance(), "not enoth currency");
        if(!isOwner()) {deduceFromLimit(msg.sender, _amount);}
        payable(msg.sender).transfer(_amount);
    }
    receive() external payable { emit MoneyReceived(_msgSender(), msg.value); }
    function sendToContract() public payable {
    address payable _to = payable(this);
    _to.transfer(msg.value);
        
    emit MoneyReceived(_msgSender(), msg.value); // <----
  }
  
    fallback() external payable { }
    
}
