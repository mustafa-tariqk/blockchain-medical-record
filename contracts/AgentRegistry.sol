pragma solidity ^0.4.15;

contract AgentRegistry {
    struct Agent {
        string name;
        address contractAddr;
        string host;
    }
    mapping(address => Agent) agentInfo;
    mapping(string => address) agentByName;
    mapping(address => address) public agentFromContract;

    address[] signers;
    mapping(address => bool) public isSigner;
    mapping( address => address[]) voters;
    mapping( address => mapping(address => bool)) hasVoted;
    mapping( address => mapping(address => bool)) voteInfo;
    mapping( address => uint) yayVotes;
  
    address[] prospectives;
    address[] kicked;
    mapping(address => bool) public  isProspective;
    mapping(address => bool) public  isKicked;

    mapping(address => address) proposer;
  
    event AddSigner(address indexed addr);
    event RemoveSigner(address indexed addr);

    modifier onlySigners() {
        require(isSigner[msg.sender]);
        _;
    }
    
    function AgentRegistry(string name, address contractAddr, string host) public {

    }

    function setAgentName(string name) onlySigners() public {
    
    }

    function setAgentContractAddr(address contractAddr) public {
    
    }

    function setAgentHost(string host) public {
    
    }

    function propose(string name) public {
    
    }

    function kick (address rip) public onlySigners {
    
    }
    
    function rescind (address prospective) public {
        require(proposer[prospective] == msg.sender);
        clearVotes(prospective);
    }

    function clearVotes(address prospective) internal {
    
    }

    function vote(address prospective, bool value) public onlySigners() {
    
    }

    function getAgentByName(string name) public constant returns (address) {
        
    }

    function getAgentName(address addr) public constant returns (string) {
        
    }

    function getAgentContractAddr(address addr) public constant returns (address) {
        
    }

    function getAgentHost(address addr) public constant returns (string) {
        
    }

    function getNumSigners() public constant returns (uint) {
        
    }

    function getSigner(uint idx) public constant returns (address) {
        
    }

    function getNumVoters(address prospective) public constant returns (uint) {
        
    }

    function getVoter(address prospective, uint idx) public constant returns (address) {
        
    }

    function getVoteInfo(address prospective, address signer) public constant returns (bool) {
        
    }

    function getNumYayVotes(address prospective) public constant returns (uint) {
        
    }

    function getNumProspectives() public constant returns (uint) {
        
    }

    function getProspective(uint idx) public constant returns (address) {
        
    }

    function getNumKicked() public constant returns (uint) {
        
    }

    function getKicked(uint idx) public constant returns (address) {
        
    }

    function getProposer(address prospective) public constant returns (address) {
        
    }
}
