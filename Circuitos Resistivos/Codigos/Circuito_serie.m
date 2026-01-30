% Autor: Lucas Guilherme
% Data: 2024-06-12
% Conversão para MATLAB
% Simulação de um circuito resistivo em domínio do tempo e fasorial.

clear; clc; close all;

%--------------------------| Parâmetros do Circuito | --------------------------%
R1 = 220.0;
R2 = 22.0;
R3 = 33.0;

% Circuito em serie - Resistencia total
R_total = R1 + R2 + R3;

% Fonte de Tensão
V_rms = 220.0;              % Tensão RMS (eficaz)
V_pico = V_rms * sqrt(2);   % Tensão de Pico
frequencia = 60.0;          % Frequencia linear 60 Hz
omega = 2 * pi * frequencia; % Frequência angular (rad/s)

%--------------------------| Cálculos do Circuito | --------------------------%
% V = R * I  =>  I = V / R
I_pico = V_pico / R_total;

% Quedas de Tensão de Pico
V1_pico = R1 * I_pico;
V2_pico = R2 * I_pico;
V3_pico = R3 * I_pico;

%--------------------------| Preparação dos Dados | --------------------------%
% Vetor de tempo (0 a 2 ciclos)
t = linspace(0, 2/frequencia, 1000);

% Ondas senoidais (usando cosseno como no original)
v_fonte_t = V_pico * cos(omega * t);
v1_t = V1_pico * cos(omega * t);
v2_t = V2_pico * cos(omega * t);
v3_t = V3_pico * cos(omega * t);
i_t = I_pico * cos(omega * t);

%--------------------------| Domínio do Tempo (Tensões) | --------------------------%
figure('Name', 'Domínio do Tempo - Tensões', 'Color', 'w');
hold on;
% Plotagem
plot(t, v_fonte_t, 'b--', 'LineWidth', 2); % t*1000 para ms
plot(t*1000, v1_t, 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5);
plot(t*1000, v2_t, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5); % Laranja
plot(t*1000, v3_t, 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 1.5); % Verde

title('Tensão no Circuito Resistivo - Domínio do Tempo');
xlabel('Tempo (ms)');
ylabel('Tensão (V)');
grid on;

% Legendas formatadas com sprintf
legend(sprintf('Fonte Total (%.1fV)', V_pico), ...
       sprintf('V em R1 (%.1fV)', V1_pico), ...
       sprintf('V em R2 (%.1fV)', V2_pico), ...
       sprintf('V em R3 (%.1fV)', V3_pico));
hold off;

%--------------------------| Domínio do Tempo (Corrente) | --------------------------%
figure('Name', 'Domínio do Tempo - Corrente', 'Color', 'w');
plot(t*1000, i_t, 'r', 'LineWidth', 1.5);
title('Corrente no Circuito Resistivo - Domínio do Tempo');
xlabel('Tempo (ms)');
ylabel('Corrente (A)');
grid on;
legend(sprintf('Corrente (%.2fA)', I_pico));

%--------------------------| Domínio Fasorial | --------------------------%
figure('Name', 'Diagrama Fasorial', 'Color', 'w');
hold on;

% Desenhar Eixos X e Y (cruz no centro)
yline(0, 'k', 'LineWidth', 1);
xline(0, 'k', 'LineWidth', 1);

% Definição dos Fasores em uma célula (Célula de arrays mistos)
% {Módulo, Ângulo, Label, Cor, Largura}
% Nota: MATLAB usa 'k' para preto, 'g' verde, 'b' azul, etc.
fasores = {
    V_pico,  0, 'Fonte (Total)', 'k', 1;
    V3_pico, 0, 'V em R3',       [0.4660 0.6740 0.1880], 1; % Verde RGB
    V2_pico, 0, 'V em R2',       [0.8500 0.3250 0.0980], 1; % Laranja RGB
    V1_pico, 0, 'V em R1',       'b', 1
};

% Loop para plotar (quiver é usado para vetores)
[num_fasores, ~] = size(fasores);

for i = 1:num_fasores
    modulo = fasores{i, 1};
    angulo = fasores{i, 2};
    label_txt = fasores{i, 3};
    cor = fasores{i, 4};
    largura = fasores{i, 5};
    
    % Conversão Polar para Cartesiano
    x = modulo * cos(angulo);
    y = modulo * sin(angulo);
    
    % Desenha a seta saindo de (0,0)
    % quiver(x0, y0, u, v) -> u e v são os deslocamentos
    q = quiver(0, 0, x, y, 'Color', cor, 'LineWidth', largura, ...
        'MaxHeadSize', 0.5, 'AutoScale', 'off');
    
    % Hack para legenda (plot invisível para gerar entrada na legenda)
    % No MATLAB, 'DisplayParameter' do quiver nem sempre funciona bem com legendas complexas
    % então usamos plots vazios para garantir as cores corretas na caixa de legenda
end

title('Diagrama Fasorial - Plano Complexo');
xlabel('Eixo Real (V)');
ylabel('Eixo Imaginário (jV)');
grid on;
axis equal; % Mantém a proporção de aspecto igual (círculos parecem círculos)

% Ajuste de Limites
limit = V_pico * 1.1;
xlim([-limit/5, limit]);
ylim([-limit/2, limit/2]);

% Criar legendas manuais baseadas na lista de fasores
labels = fasores(:, 3);
legend(labels, 'Location', 'northeast');

hold off;