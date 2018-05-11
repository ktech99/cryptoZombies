pragma solidity ^0.4.19;
import "./zombiefeeding.sol"

contract Zombiehelper is Zombiefeeding{
  modifier aboveLevel(uint _level, uint _zombieId){
    require(zombies[_zombieID].level >= level);
    _;
  }
}
