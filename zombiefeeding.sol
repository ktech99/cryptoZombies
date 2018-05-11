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
    KittyInterface kittyContract;

    //initialising kittyInterface with ckAdress
    //only Owner can change method(me)
    function setKittyContractAddress(address _address) external onlyOwner{
      kittyContract = KittyInterface(_address);
    }

    //storage can only be accessed by internal or private function
    function _triggerCooldown (Zombie storage _zombie) internal {
      _zombie.readyTime = uint32(now + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns(bool){
      return (zombie.readyTime <= now);
    }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal {
      require(msg.sender == zombieToOwner[_zombieId]); // requires feeder to be owner
      //storage stores to blockchain
      //memory stores to ram
      Zombie storage myZombie = zombies[_zombieId]; // adding zombie to blockchain storage
      require(_isReady(myZombie));
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna)/2;
      if(keccak256(_species) == keccak256("kitty")){
        newDna = newDna % 100 + 99; // making the last 2 digits of dna 99 if kitty
      }
      _createZombie("NoName", newDna);
      _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint _zombieID, uint _kittyId) public {
      uint kittyDna;
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //storing gene from kitty
      feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
  }
