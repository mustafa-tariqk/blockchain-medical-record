pragma solidity ^0.4.18;

contract Relationship {
    address public patron;
    address public provider;
    string public providerAddr;
    string public providerName;

    struct Viewer {
        string name;
        string providerAddr;
    }

    address[][] viewerGroups;
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

    function setProviderAddress(string addr) public {
        
    }

    function setProviderName(string name) public {
        
    }

    function addViewerGroup() public isPatron {
    }

    function removeViewerGroup(uint viewerGroup) public isPatron {
        
    }

    function addViewer(string name, uint viewerGroup, address viewer, string provAddr) public isPatron {
        
    }

    function removeViewer(uint viewerGroup, address viewer) public isPatron {
        
    }

    function getNumViewerGroups() public constant returns(uint) {
        
    }

    function getNumViewers(uint group) public constant returns(uint) {
        
    }

    function getViewer(uint group, uint index) public constant returns(address) {
        
    }

    function getViewerByName(string name) public constant returns(address) {
        
    }

    function getViewerName(address addr) public constant returns(string) {

    }

    function terminate() public {
        
    }
}