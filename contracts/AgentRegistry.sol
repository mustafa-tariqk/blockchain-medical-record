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

    function AgentRegistry(
        string name,
        address contractAddr,
        string host
    ) public {}

    function setAgentName(string name) public onlySigners {}

    function setAgentContractAddr(address contractAddr) public {}

    function setAgentHost(string host) public {}

    function propose(string name) public onlySigners {
        require(!isProspective[msg.sender]);
        require(agentByName[name] == msg.sender);

        prospectives.push(msg.sender);
        isProspective[msg.sender] = true;
        proposer[msg.sender] = msg.sender;
        agentInfo[msg.sender].name = name;
    }

    function kick(address rip) public onlySigners {
        require(!isKicked[rip]); //make sure address rip is not already kicked

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
            RemoveSigner(prospective);
        } else {
            signers.push(prospective);
            isSigner[prospective] = true;
            AddSigner(prospective);
        }
        clearVotes(prospective);
    }

    function getAgentByName(string name) public constant returns (address) {}

    function getAgentName(address addr) public constant returns (string) {}

    function getAgentContractAddr(address addr)
        public
        constant
        returns (address)
    {}

    function getAgentHost(address addr) public constant returns (string) {}

    function getNumSigners() public constant returns (uint256) {}

    function getSigner(uint256 idx) public constant returns (address) {}

    function getNumVoters(address prospective)
        public
        constant
        returns (uint256)
    {}

    function getVoter(address prospective, uint256 idx)
        public
        constant
        returns (address)
    {}

    function getVoteInfo(address prospective, address signer)
        public
        constant
        returns (bool)
    {}

    function getNumYayVotes(address prospective)
        public
        constant
        returns (uint256)
    {}

    function getNumProspectives() public constant returns (uint256) {}

    function getProspective(uint256 idx) public constant returns (address) {}

    function getNumKicked() public constant returns (uint256) {}

    function getKicked(uint256 idx) public constant returns (address) {}

    function getProposer(address prospective)
        public
        constant
        returns (address)
    {}
}
