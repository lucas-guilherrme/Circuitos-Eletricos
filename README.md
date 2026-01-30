# Introdução aos Sistemas Elétricos

Este projeto explora os fundamentos e aplicações avançadas de circuitos elétricos, com foco especial na robustez exigida pela indústria automotiva e na eficiência dos modernos sistemas de armazenamento de energia.

## ⚡ Visão Geral: Circuitos Elétricos
Um circuito elétrico é, essencialmente, um caminho fechado que permite o fluxo ordenado de elétrons para realizar trabalho útil. Independentemente da complexidade, todo circuito opera sob três grandezas fundamentais:

* **Tensão ($V$):** A força que impulsiona os elétrons (diferença de potencial).
* **Corrente ($I$):** O fluxo real de elétrons através de um condutor.
* **Impedância ($Z$):** A oposição total ao fluxo de corrente (resistiva e reativa).

> **Princípio Base:** A interação entre essas grandezas é governada pela Lei de Ohm ($V = Z \cdot I$) e pelas Leis de Kirchhoff, que garantem a conservação de energia e carga no sistema.

---

## 🚗 Sistemas Elétricos Automotivos
Diferente dos circuitos residenciais, o ambiente automotivo é hostil e exige alta confiabilidade. Os sistemas operam predominantemente em **Corrente Contínua (DC)**, tipicamente em **12V** (carros de passeio) ou **24V** (veículos pesados).

### Principais Diferenciais:
1.  **Chassi como Terra (GND):** Para economizar fiação, a própria estrutura metálica do veículo é usada como o caminho de retorno (negativo) para a bateria.
2.  **Rede de Comunicação (CAN Bus):** Os componentes modernos não apenas recebem energia, mas conversam entre si. Sensores e atuadores trocam dados binários através de um par de fios trançados, permitindo diagnósticos avançados e controle preciso.
3.  **Alternador e Retificação:** A energia mecânica do motor é convertida em elétrica (AC) e imediatamente retificada para DC para carregar a bateria e alimentar o sistema enquanto o veículo roda.

<img width="750" height="454" alt="Carro eletrico-Photoroom" src="https://github.com/user-attachments/assets/f8254d34-28b3-4ebf-81af-efafe1361827" />

---

## 🔋 Sistemas de Armazenamento de Energia (ESS)
O armazenamento de energia é o coração da mobilidade elétrica e sistemas híbridos. Não se trata apenas de "pilhas", mas de sistemas complexos de gerenciamento químico e elétrico.

### Tecnologias e Gerenciamento
* **Química das Células:** O projeto foca em tecnologias como **Íons de Lítio (Li-Ion)** pela alta densidade energética e **Chumbo-Ácido** para aplicações de partida (SLI).
* **BMS (Battery Management System):** O "cérebro" do pack de baterias. É um sistema eletrônico crítico responsável por:
    * **Monitoramento:** Leitura constante de Tensão, Corrente e Temperatura de cada célula.
    * **Balanceamento:** Garante que todas as células carreguem e descarreguem na mesma taxa, maximizando a vida útil.
    * **Proteção (SOA - Safe Operating Area):** Desconecta o sistema em caso de sobretensão, subtensão ou superaquecimento para evitar falhas catastróficas.

<img width="1000" height="667" alt="Battery-Energy-Storage-System-Photoroom" src="https://github.com/user-attachments/assets/ba7be9c1-fa38-4d1e-afb3-207a30c6d88c" />
