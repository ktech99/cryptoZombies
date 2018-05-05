pragma solidity ^0.4.19;

contract ZombieFactory {

  // creating an event to tell frontend that zombie created
  event NewZombie(uint zombieId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;

  //creating an object
  struct Zombie {
    string name;
    uint dna;
  }

  Zombie[] public zombies; // Array of type zombies

  mapping (uint => address) public zombieToOwner; //mapping the zombie to an address
  mapping (address => uint) ownerZombieCount; // mapping an adress to number of zombies

  function _createZombie(string _name, uint _dna) private {
    // array.push()-1 returns value last added to array
    uint id = zombies.push(Zombie(_name, _dna)) - 1;
    //Firing the event
    NewZombie(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomZombie(string _name) public {
    uint randDna = _generateRandomDna(_name);
    _createZombie(_name, randDna);
  }

}
