import "./zombiefactory.sol";

//creates an interface of cryptokitty method
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

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
