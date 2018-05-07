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

  //initialising kittyInterface with ckAdress
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(msg.sender == zombieToOwner[_zombieId]); // requires feeder to be owner
    //storage stores to blockchain
    //memory stores to ram
    Zombie storage myZombie = zombies[_zombieId]; // adding zombie to blockchain storage
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna)/2;
    if(keccak256(_species) == keccak256("kitty")){
      newDna = newDna % 100 + 99; // making the last 2 digits of dna 99 if kitty
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieID, uint _kittyId) public {
      uint kittyDna;
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //storing gene from kitty
      feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}
