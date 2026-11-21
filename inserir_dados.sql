USE industrial_senai;
INSERT INTO unidades_senai (nome_unidade, cidade) VALUES
('SENAI Roberto Mange', 'Campinas'),
('SENAI Suiço-Brasileira', 'São Paulo'),
('SENAI Santo Amaro', 'São Paulo'),
('SENAI Mario Amato', 'São Bernardo do Campo'),
('SENAI Ítalo Bologna', 'Sorocaba');

INSERT INTO linhas_producao (id_unidade, nome_linha) VALUES
(1, 'Linha de Usinagem CNC'),
(1, 'Linha de Soldagem'),
(2, 'Linha de Automação'),
(3, 'Linha de Montagem Mecânica'),
(4, 'Linha de Pintura Industrial');

INSERT INTO tipos_maquina (nome_tipo, horas_revisao_padrao) VALUES
('Torno CNC', 500),
('Fresadora', 400),
('Robô de Solda', 600),
('Prensa Hidráulica', 800),
('Compressor de Ar', 300);

INSERT INTO maquinas_senai (id_linha, id_tipo, tag_patrimonio, data_aquisicao, status_operacao) VALUES
(1, 1, 'PAT-0001', '2021-03-15', 'ATIVA'),
(1, 2, 'PAT-0002', '2022-07-01', 'ATIVA'),
(2, 3, 'PAT-0003', '2023-01-20', 'MANUTENCAO'),
(4, 4, 'PAT-0004', '2020-11-05', 'ATIVA'),
(5, 5, 'PAT-0005', '2019-09-30', 'DESATIVADA');

INSERT INTO componentes_maq (id_maquina, nome_componente, horas_uso_acumulado, limite_horas_alerta) VALUES
(1, 'Spindle Principal', 3200, 4000),
(2, 'Correia de Transmissão', 1500, 2000),
(3, 'Tocha de Solda', 900, 1200),
(4, 'Bomba Hidráulica', 5100, 6000),
(5, 'Pistão do Compressor', 7800, 8000);

INSERT INTO tecnicos (nome_tecnico, especialidade, nivel_certificacao) VALUES
('Carlos Eduardo Lima', 'Mecânica', 'SENIOR'),
('Mariana Souza', 'Elétrica', 'PLENO'),
('Rafael Almeida', 'Automação', 'SPECIALIST'),
('Juliana Ferreira', 'Hidráulica', 'JUNIOR'),
('Pedro Henrique Costa', 'Soldagem', 'PLENO');

INSERT INTO ordens_servico (id_maquina, id_tecnico, data_abertura, tipo_manutencao, status_os) VALUES
(1, 1, '2026-10-02 08:30:00', 'PREVENTIVA', 'CONCLUIDA'),
(3, 5, '2026-10-15 14:10:00', 'CORRETIVA', 'EM_ANDAMENTO'),
(4, 4, '2026-10-20 09:00:00', 'PREDITIVA', 'ABERTA'),
(2, 2, '2026-11-03 10:45:00', 'PREVENTIVA', 'CONCLUIDA'),
(5, 3, '2026-11-10 16:20:00', 'CORRETIVA', 'CANCELADA');

INSERT INTO estoque_pecas (codigo_part_number, descricao, qtd_estoque, preco_unitario) VALUES
('PN-ROL-6204', 'Rolamento rígido de esferas 6204', 40, 38.90),
('PN-COR-B52', 'Correia em V perfil B52', 25, 62.50),
('PN-BIC-TIG', 'Bico de contato para tocha MIG', 100, 12.75),
('PN-VED-HID', 'Kit de vedação hidráulica', 15, 189.90),
('PN-FIL-AR', 'Filtro de ar para compressor', 30, 74.00);

INSERT INTO pecas_os (id_ordem, id_peca, qtd_utilizada, preco_aplicado) VALUES
(1, 1, 2, 38.90),
(2, 3, 5, 12.75),
(3, 4, 1, 189.90),
(4, 2, 1, 62.50),
(5, 5, 2, 74.00);

INSERT INTO historico_sensores (id_ordem, temperatura_medida, vibracao_mm_s, data_hora_leitura) VALUES
(1, 62.40, 2.10, '2026-10-02 08:45:00'),
(2, 148.75, 5.80, '2026-10-15 14:30:00'),
(3, 71.20, 3.45, '2026-10-20 09:15:00'),
(4, 55.90, 1.95, '2026-11-03 11:00:00'),
(5, 98.30, 4.60, '2026-11-10 16:40:00');
