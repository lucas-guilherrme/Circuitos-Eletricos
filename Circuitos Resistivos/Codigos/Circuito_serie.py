# Autor: Lucas Guilherme
# Data: 2024-06-12

# Simulação de um circuito resistivo em domínio do tempo e fasorial.

#--------------------------| Importando as bibliotecas | --------------------------#
import numpy as np
import matplotlib.pyplot as plt

#--------------------------| Parâmetros do Circuito | --------------------------#
R1 = 220.0
R2 = 22.0
R3 = 33.0

# Circuito em serie - Resistencia total
R_total = R1 + R2 + R3

# Fonte de Tensão
V_rms = 220.0               # Tensão RMS (eficaz)
V_pico = V_rms * np.sqrt(2) # Tensão de Pico
frequencia = 60.0               # frequencia linear 60 Hz
omega = 2 * np.pi * frequencia  # Frequência angular (rad/s)

#--------------------------| Cálculos do Circuito | --------------------------#
# V = R * I  =>  I = V / R
I_pico = V_pico / R_total

# Quedas de Tensão de Pico
V1_pico = R1 * I_pico
V2_pico = R2 * I_pico
V3_pico = R3 * I_pico

#--------------------------| Plotagem dos Resultados | --------------------------#
t = np.linspace(0, 1/frequencia, 1000) 
v_fonte_t = V_pico * np.sin(omega * t)
v1_t = V1_pico * np.sin(omega * t)
v2_t = V2_pico * np.sin(omega * t)
v3_t = V3_pico * np.sin(omega * t)

#--------------------------| Domínio do Tempo | --------------------------#
plt.figure(figsize=(10, 6))
plt.title("Tensão no Circuito Resistivo - Domínio do Tempo")
plt.plot(t, v_fonte_t, 'b--', linewidth=2, label=f'Fonte Total ({V_pico:.1f}V)')
plt.plot(t, v1_t, label=f'V em R1 ({V1_pico:.1f}V)')
plt.plot(t, v2_t, label=f'V em R2 ({V2_pico:.1f}V)')
plt.plot(t, v3_t, label=f'V em R3 ({V3_pico:.1f}V)')
plt.xlabel("Tempo (ms)")
plt.ylabel("Tensão (V)")
plt.grid(True)
plt.legend()

plt.figure(figsize=(10, 6))
plt.title("Corrente no Circuito Resistivo - Domínio do Tempo")
plt.plot(t, I_pico * np.sin(omega * t), 'r', label=f'Corrente ({I_pico:.2f}A)')
plt.xlabel("Tempo (ms)")
plt.ylabel("Corrente (A)")
plt.grid(True)
plt.legend()

#--------------------------| Domínio Fasorial | --------------------------#
plt.figure(figsize=(10, 6))

ax = plt.gca() 
plt.axhline(0, color='black', linewidth=1) # Eixo X
plt.axvline(0, color='black', linewidth=1) # Eixo Y

# Definição dos Fasores (Módulo, Ângulo, Label, Cor, Largura)
fasores = [
    (V_pico, 0, 'Fonte (Total)', 'black', 2), 
    (V3_pico, 0, 'V em R3', 'green', 2),
    (V2_pico, 0, 'V em R2', 'orange', 2),
    (V1_pico, 0, 'V em R1', 'blue', 2)
]

plt.title("Diagrama Fasorial - Plano Complexo")

# Plotar cada fasor como uma seta no plano XY
for modulo, angulo, label, cor, largura in fasores:
    # Converter polar para cartesiano (X, Y)
    # Como o angulo é 0, X = modulo e Y = 0
    x = modulo * np.cos(angulo)  
    y = modulo * np.sin(angulo)
    
    # Desenha a seta saindo da origem (0,0)
    plt.arrow(0, 0, x, y, 
              head_width=3, length_includes_head=True, 
              color=cor, linewidth=largura/1.5, zorder=10-largura) 
              # zorder ajuda a garantir que os mais finos fiquem por cima se desenhados depois

    # Hack para legenda (linha invisível)
    plt.plot([], [], color=cor, linewidth=4, label=label)

# Ajustes visuais do gráfico
limit = V_pico * 1.1
plt.xlim(-limit/5, limit)     # Espaço horizontal
plt.ylim(-limit/2, limit/2)   # Espaço vertical (centrado)
plt.xlabel('Eixo Real (V)')
plt.ylabel('Eixo Imaginário (jV)')
plt.grid(True, linestyle=':', alpha=0.6)
plt.legend(loc='upper right')

plt.show()