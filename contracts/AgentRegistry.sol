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
    mapping(address => address[]) voters;
    mapping(address => mapping(address => bool)) hasVoted;
    mapping(address => mapping(address => bool)) voteInfo;
    mapping(address => uint) yayVotes;
  
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
    
    }

    function clearVotes(address prospective) internal {
    
    }

    function vote(address prospective, bool value) public onlySigners() {
    
    }

    function getAgentByName(string name) public constant returns (address) {
        return agentByName[name];
    }

    function getAgentName(address addr) public constant returns (string) {
        return agentInfo[addr].name;
    }

    function getAgentContractAddr(address addr) public constant returns (address) {
        return agentInfo[addr].contractAddr;
    }

    function getAgentHost(address addr) public constant returns (string) {
        return agentInfo[addr].host;
    }

    function getNumSigners() public constant returns (uint) {
        return signers.length;
    }

    function getSigner(uint idx) public constant returns (address) {
        return signers[idx];
    }

    function getNumVoters(address prospective) public constant returns (uint) {
        return voters[prospective].length;
    }

    function getVoter(address prospective, uint idx) public constant returns (address) {
        return voters[prospective][idx];
    }

    function getVoteInfo(address prospective, address signer) public constant returns (bool) {
        return voteInfo[prospective][singer];
    }

    function getNumYayVotes(address prospective) public constant returns (uint) {
        return yayVotes[prospective].length;
    }

    function getNumProspectives() public constant returns (uint) {
        return prospectives.length;
    }

    function getProspective(uint idx) public constant returns (address) {
        return prospectives[idx];
    }

    function getNumKicked() public constant returns (uint) {
        return kicked.length;
    }

    function getKicked(uint idx) public constant returns (address) {
        return kicked[idx];
    }

    function getProposer(address prospective) public constant returns (address) {
        return proposer[prospective];
    }
}