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
        if (msg.sender != patron) revert();
        _;
    }

    function Relationship(address _provider) public {
        patron = msg.sender;
        provider = _provider;
    }

    function setProviderName(string name) public {
        providerName = name;
    }

    function addViewer(string name, address viewer) public isPatron {
        isViewer[viewer] = true;
        viewers.push(viewer);
        viewerInfo[viewer] = Viewer(name, viewer);
    }

    function removeViewer(address viewer) public isPatron {
        for (uint256 i = 0; i < viewers.length; i++) {
            isViewer[viewers[i]] = false; //set all addresses in isViewer to false
        }

        for (uint256 j = 0; j < viewers.length - 1; j++) {
            viewers[j] = viewers[j + 1]; //shift elements to the left
        }

        delete (viewers[viewers.length - 1]); //delete last element
        viewers.length--; //decrement viewers array
        delete (viewerInfo[viewer]);
    }

    function getNumViewers() public constant returns (uint256) {
        return viewers.length;
    }

    function getViewerByName(string name) public constant returns (address) {
        return viewerByName[name];
    }

    function getViewerName(address addr) public constant returns (string) {
        return viewerInfo[addr].name;
    }

    function terminate() public isPatron {
        require(msg.sender == provider);
        selfdestruct(patron);
    }
}
