// SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

contract Election {
    address public admin;
    mapping(uint => Candidate) public Candidates;
    mapping(address => bool) hasVoted;
    VotingState public votingState;
    uint public totalCandidates;

    constructor() {
        admin = msg.sender;
        votingState = VotingState.Registration;
    }

    enum VotingState {
        Registration,
        Voting,
        Ended
    }

    struct Candidate {
        uint id;
        string name;
        string description;
        uint voteCount;
    }

    function addCandidate(string memory _name, string memory _description) public {
        require(msg.sender == admin, unicode'Somente o administrador pode criar um candidato');

        require(votingState == VotingState.Registration, unicode'Fazer de registro já acabou');

        require(bytes(_name).length > 0 && bytes(_description).length > 0, unicode'Preisa de nome e descrição');

        Candidate memory newCandidate = Candidate(totalCandidates, _name, _description, 0);

        Candidates[totalCandidates] = newCandidate;

        totalCandidates++;
    }
}
