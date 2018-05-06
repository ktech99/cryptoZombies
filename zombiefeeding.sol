import "./zombiefactory.sol";

contract zombieFeeding is zombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]); // requires feeder to be owner
    //storage stores to blockchain
    //memory stores to ram
    Zombie storage myZombie = zombies[_zombieId]; // adding zombie to blockchain storage
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna)/2;
    _createZombie("NoName", newDna);
  }
}
