pragma solidity ^0.4.0;

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

    mapping(address => uint256) yayVotes;

    address[] prospectives;
    address[] kicked;
    mapping(address => bool) public isProspective;
    mapping(address => bool) public isKicked;

    mapping(address => address) proposer;

    event AddSigner(address indexed addr);
    event RemoveSigner(address indexed addr);

    modifier onlySigners() {
        require(isSigner[msg.sender]);
        _;
    }

    constructor(
        string name,
        address contractAddr,
        string host
    ) public {
        signers.push(msg.sender);
        agentInfo[msg.sender] = Agent(name, contractAddr, host);
        agentByName[name] = msg.sender;
        agentFromContract[contractAddr] = msg.sender;
        isSigner[msg.sender] = true;
    }

    function setAgentName(string name) public onlySigners {
        //throw if the name is taken.
        require(agentByName[name] == address(0));
        agentInfo[msg.sender].name = name;
        agentByName[name] = msg.sender;
    }

    function setAgentContractAddr(address contractAddr) public {
        agentInfo[msg.sender].contractAddr = contractAddr;
        agentFromContract[contractAddr] = msg.sender;
    }

    function setAgentHost(string host) public {
        agentInfo[msg.sender].host = host;
    }

    function propose(string name) public onlySigners {
        require(!isProspective[msg.sender]);
        require(agentByName[name] == msg.sender);

        prospectives.push(msg.sender);
        isProspective[msg.sender] = true;
        proposer[msg.sender] = msg.sender;

        //throw if name is taken.
        require(agentByName[name] == address(0));
        agentInfo[msg.sender].name = name;
    }

    function kick(address rip) public onlySigners {
        require(isSigner[msg.sender]);
        require(!isKicked[rip]); //make sure address rip is not already kicked
        require(signers.length > 2);

        kicked.push(rip); //push the address rip to list of kicked addresses
        isKicked[rip] = true;
        proposer[rip] = msg.sender;
        vote(rip, true); //vote for rip to be kicked
    }

    function rescind(address prospective) public {
        require(proposer[prospective] == msg.sender);
        clearVotes(prospective);
    }

    function clearVotes(address prospective) internal {
        uint256 i;
        for (i = 0; i < voters[prospective].length; i++) {
            delete voteInfo[prospective][voters[prospective][i]];
            delete hasVoted[prospective][voters[prospective][i]];
        }
        delete voters[prospective];
        delete proposer[prospective];
        delete yayVotes[prospective];

        bool overwrite = false;
        if (isProspective[prospective]) {
            delete isProspective[prospective];
            for (i = 0; i < prospectives.length; i++) {
                if (overwrite) {
                    prospectives[i - 1] = prospectives[i];
                }
                if (prospectives[i] == prospective) {
                    overwrite = true;
                }
            }
            delete (prospectives[prospectives.length - 1]);
            prospectives.length -= 1;
        } else {
            delete isKicked[prospective];
            for (i = 0; i < kicked.length; i++) {
                if (overwrite) {
                    kicked[i - 1] = kicked[i];
                }
                if (kicked[i] == prospective) {
                    overwrite = true;
                }
            }
            delete (kicked[kicked.length - 1]);
            kicked.length -= 1;
        }
    }

    function vote(address prospective, bool value) public onlySigners {
        require(isProspective[prospective] || isKicked[prospective]);

        if (voteInfo[prospective][msg.sender] && !value) {
            yayVotes[prospective] -= 1;
        }
        if (!voteInfo[prospective][msg.sender] && value) {
            yayVotes[prospective] += 1;
        }
        voteInfo[prospective][msg.sender] = value;
        if (!hasVoted[prospective][msg.sender]) {
            voters[prospective].push(msg.sender);
        }
        hasVoted[prospective][msg.sender] = true;

        if (!value) return;
        if (yayVotes[prospective] < (signers.length + 1) / 2) return;
        if (isKicked[prospective]) {
            bool overwrite = false;
            for (uint256 i = 0; i < signers.length; i++) {
                if (overwrite) {
                    signers[i - 1] = signers[i];
                }
                if (signers[i] == prospective) {
                    overwrite = true;
                }
            }
            delete (signers[signers.length - 1]);
            signers.length -= 1;
            isSigner[prospective] = false;
            emit RemoveSigner(prospective);
        } else {
            signers.push(prospective);
            isSigner[prospective] = true;
            emit AddSigner(prospective);
        }
        clearVotes(prospective);
    }

    function getAgentByName(string name) public constant returns (address) {
        return agentByName[name];
    }

    function getAgentName(address addr) public constant returns (string) {
        return agentInfo[addr].name;
    }

    function getAgentContractAddr(address addr)
        public
        constant
        returns (address)
    {
        return agentInfo[addr].contractAddr;
    }

    function getAgentHost(address addr) public constant returns (string) {
        return agentInfo[addr].host;
    }

    function getNumSigners() public constant returns (uint256) {
        return signers.length;
    }

    function getSigner(uint256 idx) public constant returns (address) {
        return signers[idx];
    }

    function getNumVoters(address prospective)
        public
        constant
        returns (uint256)
    {
        return voters[prospective].length;
    }

    function getVoter(address prospective, uint256 idx)
        public
        constant
        returns (address)
    {
        return voters[prospective][idx];
    }

    function getVoteInfo(address prospective, address signer)
        public
        constant
        returns (bool)
    {
        return voteInfo[prospective][signer];
    }

    function getNumYayVotes(address prospective)
        public
        constant
        returns (uint256)
    {
        return yayVotes[prospective];
    }

    function getNumProspectives() public constant returns (uint256) {
        return prospectives.length;
    }

    function getProspective(uint256 idx) public constant returns (address) {
        return prospectives[idx];
    }

    function getNumKicked() public constant returns (uint256) {
        return kicked.length;
    }

    function getKicked(uint256 idx) public constant returns (address) {
        return kicked[idx];
    }

    function getProposer(address prospective)
        public
        constant
        returns (address)
    {
        return proposer[prospective];
    }
}
