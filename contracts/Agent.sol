pragma solidity ^0.4.15;

contract Agent {
    address public agent;
    bool public agentEnabled;
    address[] public custodians;
    bool[] public custodianEnabled;
    address[] public relationships;

    modifier isOwner() {
    
    }

    function Agent() public {
    
    }

    function setAgent(address addr) public isOwner {
    
    }

    function enableAgent(bool enable) public isOwner {
    
    }

    function addCustodian(address addr) public isOwner {
    
    }

    function removeCustodian(address addr) public isOwner {
    
    }

    function enableCustodian(address addr, bool enable) public {
    
    }

    function addRelationship(address r) public isOwner {
    
    }

    function getNumRelationships() public constant returns (uint) {
    
    }

    function getNumEnabledOwners() public constant returns (uint) {
    
    }

    function getNumCustodians() public constant returns (uint) {
    
    }
}