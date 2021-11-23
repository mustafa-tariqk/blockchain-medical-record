pragma solidity ^0.4.15;

contract DeadmanSwitch {
    address public agent;
    address[] public relationships;
    uint public lastTouch;
    uint public timeout;

    modifier isOwner() {
        if(msg.sender != agent) revert();
        _;
    }

    function DeadmanSwitch() public {
        agent = msg.sender;
    }

    function setAgent(address addr) public isOwner {
        agent = addr;
    }

    function addRelationship(address r) public isOwner {
        relationships.push(r);
    }

    function getNumRelationships() public constant returns (uint) {
        return relationships.length;
    }

    function touch() public isOwner {
        lastTouch = now;
    }

    function setTimeout(uint _timeout) public isOwner {
        timeout = _timeout;
    }

    function isAlive() public constant returns (bool){
        return now <= lastTouch + timeout;
    }
}