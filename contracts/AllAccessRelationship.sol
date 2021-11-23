pragma solidity ^0.4.18;

contract AllAccessRelationship {
    address public patron;
    address public provider;
    string public providerName;

    struct Viewer {
        string name;
        address addr;
    }

    address[] public viewers;
    mapping(address => bool) public isViewer;
    mapping(address => Viewer) viewerInfo;
    mapping(string => address) viewerByName;

    uint256 constant UINT256_MAX = ~uint256(0);

    modifier isPatron() {
        if(msg.sender != patron) revert();
        _;
    }

    function Relationship(address _provider) public {
        
    }

    function setProviderName(string name) public {
        
    }

    function addViewer(string name, address viewer) public isPatron {
        
    }

    function removeViewer(address viewer) public isPatron {
        
    }

    function getNumViewers() public constant returns(uint) {
        
    }

    function getViewerByName(string name) public constant returns(address) {
        
    }

    function getViewerName(address addr) public constant returns(string) {
        
    }

    function terminate() public {
        
    }
}