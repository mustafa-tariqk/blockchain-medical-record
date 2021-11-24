pragma solidity ^0.4.15;

contract Agent {
    address public agent;
    bool public agentEnabled;
    address[] public custodians;
    bool[] public custodianEnabled;
    address[] public relationships;

    modifier isOwner() {}

    function Agent() public {}

    function setAgent(address addr) public isOwner {}

    function enableAgent(bool enable) public isOwner {}

    function addCustodian(address addr) public isOwner {}

    function removeCustodian(address addr) public isOwner {
        for (uint256 i = 0; i < custodians.length; i++) {
            custodians[i - 1] = custodians[i];
            custodianEnabled[i - 1] = custodianEnabled[i];
            if (custodians[i] == addr) {
                delete custodians[i];
                delete custodianEnabled[i];
                break;
            }
        }

        //decrement arrays by 1
        //delete last element of both arrays.
        delete custodianEnabled[custodianEnabled.length - 1];
        delete custodians[custodians.length - 1];
        custodianEnabled.length--;
        custodians.length--;
    }

    function enableCustodian(address addr, bool enable) public {
        for (uint256 i = 0; i < custodians.length; i++) {
            if (custodians[i] == addr) {
                custodianEnabled[i] = enable;
                break;
            }
        }
    }

    function addRelationship(address r) public isOwner {
        relationships.push(r);
    }

    function getNumRelationships() public constant returns (uint256) {
        return relationships.length;
    }

    function getNumEnabledOwners() public constant returns (uint256) {
        uint256 numEnabled = 0;
        for (int256 i = 0; i < custodianEnabled.length; i++) {
            if (custodianEnabled[i]) {
                numEnabled++;
            }
        }
        return numEnabled;
    }

    function getNumCustodians() public constant returns (uint256) {
        return custodians.length;
    }
}
