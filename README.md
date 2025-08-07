# 🗳️ Election Smart Contract

Este projeto implementa um contrato inteligente de **eleição descentralizada** utilizando Solidity.  
Permite que um administrador cadastre candidatos, inicie e encerre a votação, e que usuários votem de forma segura (somente uma vez).

---

## 📋 Funcionalidades

- **Cadastro de candidatos** (somente pelo administrador)
- **Controle de fases da eleição**:
  - Registro
  - Votação
  - Encerrada
- **Sistema de votação seguro**:
  - Cada endereço só pode votar uma vez
  - Apenas candidatos válidos podem receber votos
- **Exibição do resultado final** (nome do vencedor e quantidade de votos)

---

## ⚙️ Estrutura do Contrato

### **Variáveis principais**
- `admin`: endereço do administrador da eleição
- `candidates`: mapeamento de candidatos cadastrados
- `hasVoted`: mapeamento para controlar quem já votou
- `votingState`: estado atual da eleição (`Registration`, `Voting`, `Ended`)
- `totalCandidates`: contador de candidatos

### **Estruturas**
```solidity
struct Candidate {
    uint id;
    string name;
    string description;
    uint voteCount;
}
