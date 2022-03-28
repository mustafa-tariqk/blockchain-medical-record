pragma solidity ^0.4.15;

contract Agent {
    address public agent;
    bool public agentEnabled;
    address[] public custodians;
    bool[] public custodianEnabled;
    address[] public relationships;

    modifier isOwner() {
        bool enable;
        if (agentEnabled && msg.sender == agent) enable = true;
        for (uint i = 0; i < custodians.length; i++) {
            if (custodianEnabled[i] && msg.sender == custodians[i]) {
                enable = true;
                break;
            }
        }
        if (!enable) revert();
        _;
    }

    function Agent() public {
        agent = agent.sender;
        agentEnabled = true;
    }

    function setAgent(address addr) public isOwner {
        agent = addr;
    }

    function enableAgent(bool enable) public isOwner {
        agentEnabled = enable;
        require(getNumEnabledOwners() > 0);
    }

    function addCustodian(address addr) public isOwner {
        custodians.push(addr);
        custodianEnabled.push(true);
    }

    function removeCustodian(address addr) public isOwner {
        bool overwrite = false;
        for (uint i = 0; i < custodians.length; i++) {
            if (overwrite) {
                custodians[i - 1] = custodians[i];
                custodianEnabled[i - 1] = custodianEnabled[i];
            }

            if (custodians[i] == addr) {
                overwrite = true;
            }
        }


        //decrement arrays by 1
        //delete last element of both arrays.
        delete custodianEnabled[custodianEnabled.length - 1];
        delete custodians[custodians.length - 1];
        custodianEnabled.length--;
        custodians.length--;
        require(getNumEnabledOwners() > 0);
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
        if (agentEnabled) numEnabled++;
        for (uint i = 0; i < custodianEnabled.length; i++) {
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
