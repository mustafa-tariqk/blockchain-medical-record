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
        isViewer[viewer] = true;
        viewerGroups[viewerGroup].push(viewer);
        viewerByName[name] = viewer;
        viewerInfo[viewer] = Viewer({name:name, providerAddr:provAddr});
    }

    function removeViewer(uint viewerGroup, address viewer) public isPatron {
        delete isViewer[viewer];
        for (int i = 0; i < viewerGroups[viewerGroup].length; i++) {
            if (viewerGroups[viewerGroup][i] == viewer) {
                delete viewerGroups[viewerGroup][i];
            }
        }
        delete viewerByName[viewerInfo[viewer].name];
        delete viewerInfo[viewer];
    }

    function getNumViewerGroups() public constant returns(uint) {
        return viewerGroups.length;
    }

    function getNumViewers(uint group) public constant returns(uint) {
        return viewerGroups[group].length;
    }

    function getViewer(uint group, uint index) public constant returns(address) {
        return viewerGroups[group][index];
    }

    function getViewerByName(string name) public constant returns(address) {
        return viewerByName[name];
    }

    function getViewerName(address addr) public constant returns(string) {
        return viewerInfo[viewer].name;
    }

    function terminate() public {
        require(msg.sender ==  patron);
        selfdestruct(msg.sender);
    }
}