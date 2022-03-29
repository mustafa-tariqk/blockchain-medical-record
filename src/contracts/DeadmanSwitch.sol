pragma solidity ^0.4.0;

contract DeadmanSwitch {
    address public agent;
    address[] public relationships;
    uint256 public lastTouch;
    uint256 public timeout;

    modifier isOwner() {
        if (msg.sender != agent) revert();
        _;
    }

    constructor() public {
        agent = msg.sender;
    }

    function setAgent(address addr) public isOwner {
        agent = addr;
    }

    function addRelationship(address r) public isOwner {
        relationships.push(r);
    }

    function getNumRelationships() public constant returns (uint256) {
        return relationships.length;
    }

    function touch() public isOwner {
        lastTouch = now;
    }

    function setTimeout(uint256 _timeout) public isOwner {
        timeout = _timeout;
    }

    function isAlive() public constant returns (bool) {
        return now <= lastTouch + timeout;
    }
}
