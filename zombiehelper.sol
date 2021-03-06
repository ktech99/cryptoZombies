pragma solidity ^0.4.19;
import "./zombiefeeding.sol"

contract Zombiehelper is Zombiefeeding{
  modifier aboveLevel(uint _level, uint _zombieId){
    require(zombies[_zombieID].level >= level);
    _;
  }

  // be allowed to change name after level 2
  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId){
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  // be allowed to change dna after level 20
  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId){
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[]){
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for(uint i = 0; i < zombies.length; i++){
      if(zombieToOwner[i] == _owner){
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
}
