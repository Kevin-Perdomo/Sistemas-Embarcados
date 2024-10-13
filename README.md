# Projeto SAP1 Versão BR

Este repositório contém o desenvolvimento de um **SAP1 (Simple As Possible)**, versão adaptada, como parte da disciplina de **Sistemas Embarcados** da faculdade. O projeto foi dividido em duas provas:

- **Prova 1**: Implementação do SAP1 em diagramas de blocos.
- **Prova 2**: Implementação do SAP1 em Verilog, utilizando o software **Intel Quartus Prime**.

## Descrição do Projeto

O **SAP1 (Simple As Possible 1)** é um computador didático básico utilizado para ensino de arquitetura de computadores. Neste projeto, foi realizada uma adaptação para a versão "BR", abordando conceitos fundamentais de sistemas embarcados.

O projeto está dividido em duas etapas principais:

1. **Diagrama de Blocos (Prova 1)**: Nesta fase, o objetivo foi criar o SAP1 utilizando diagramas de blocos. Esse diagrama descreve os principais componentes e o fluxo de dados dentro do processador, incluindo a Unidade Lógica e Aritmética (ULA), registradores, e barramentos.

2. **Verilog (Prova 2)**: A segunda fase consistiu em implementar o SAP1 utilizando a linguagem de descrição de hardware **Verilog** no software **Intel Quartus Prime**. O Verilog foi utilizado para descrever o comportamento dos componentes do SAP1 e simular o funcionamento do sistema completo.

## Ferramentas Utilizadas

- **Intel Quartus Prime**: Ambiente de desenvolvimento para FPGAs, utilizado para criar o projeto em Verilog e realizar as simulações.
- **Verilog**: Linguagem de descrição de hardware utilizada na Prova 2.
- **Diagramas de Blocos**: Criados para representar a arquitetura do SAP1 na Prova 1.

## Tutorial de Instalação do Intel Quartus Prime

### Passo a Passo para Instalação

1. **Baixe o Intel Quartus Prime Lite Edition versão 21.1.0 ou superior** através do link oficial:
   - [Intel Quartus Prime Lite Edition](https://www.intel.com/content/www/us/en/software-kit/660907/intel-quartus-prime-lite-edition-design-software-version-20-1-1-for-windows.html)

2. **Opções de Instalação Necessárias**:
   - Durante o processo de instalação, certifique-se de marcar as seguintes opções:
     - **Questa Intel FPGA (Starter Edition)**: Essencial para a simulação e verificação de projetos.
     - **MAX 10 FPGA Device Support**: Suporte ao FPGA MAX10 no Quartus Prime, necessário para este projeto.

3. **Conclua a instalação** e configure o ambiente para iniciar o desenvolvimento.

### Requisitos do Sistema

- **Sistema Operacional**: Windows 10 ou superior (64 bits).
- **Espaço em Disco**: Mínimo de 20 GB.
- **Memória RAM**: Recomendado 8 GB ou mais.
