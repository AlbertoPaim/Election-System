// SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

contract Election {
    address public admin;
    mapping(uint => Candidate) public candidates;
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

        candidates[totalCandidates] = newCandidate;

        totalCandidates++;
    }

    function StartingVote() public {
        require(msg.sender == admin, unicode'Somente o administrador pode começar votação');
        require(totalCandidates > 1, unicode'Para começar eleição precisam de no minimo 2 candidatos');
        require(votingState == VotingState.Registration, unicode'A eleição já esta em andamento ou encerrada');
        votingState = VotingState.Voting;
    }

    function Vote(uint _candidateNumber) public {
        require(votingState == VotingState.Voting, unicode'A fase de votação ainda não começou ou já foi encerrada');
        require(!(hasVoted[msg.sender]), unicode'Cada pessoa só pode votar uma única vez!');
        require(_candidateNumber < totalCandidates, unicode'Candidato inválido');

        candidates[_candidateNumber].voteCount++;

        hasVoted[msg.sender] = true;
    }

    function EndVoting() public {
        require(msg.sender == admin, unicode'Somente o administrador pode encerrar a votação');
        require(votingState == VotingState.Voting, unicode'Votação em fase de registro ou já encerrada');

        votingState = VotingState.Ended;
    }

    function getResult() public view returns (string memory, uint) {
        uint totalVotes;
        string memory winner;

        for (uint i; i < totalCandidates; i++) {
            if (candidates[i].voteCount > totalVotes) {
                totalVotes = candidates[i].voteCount;
                winner = candidates[i].name;
            }
        }

        return (winner, totalVotes);
    }
}
