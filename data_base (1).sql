DROP DATABASE IF EXISTS industrial_senai;
CREATE DATABASE industrial_senai CHARACTER SET utf8mb4;
USE industrial_senai;

/** IAS **/
CREATE TABLE unidades_senai(
    id_unidade INT AUTO_INCREMENT,
    nome_unidade VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_unidades PRIMARY KEY(id_unidade)
);

/** IAS **/
CREATE TABLE tipos_maquina(
    id_tipo INT AUTO_INCREMENT,
    nome_tipo VARCHAR(50) NOT NULL,
    horas_revisao_padrao INT NOT NULL,
    CHECK(horas_revisao_padrao > 0),
    CONSTRAINT pk_id_tipos PRIMARY KEY(id_tipo)
);

/** IAS **/
CREATE TABLE tecnicos(
    id_tecnico INT AUTO_INCREMENT,
    nome_tecnico VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50) NOT NULL,
    nivel_certificacao VARCHAR(30) NOT NULL,
    CHECK(nivel_certificacao IN ('JUNIOR', 'PLENO', 'SENIOR', 'SPECIALIST')),
    CONSTRAINT pk_id_tecnicos PRIMARY KEY(id_tecnico)
);

/** IAS **/
CREATE TABLE estoque_pecas(
    id_peca INT AUTO_INCREMENT,
    codigo_part_number VARCHAR(50) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    qtd_estoque INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    CHECK(qtd_estoque >= 0),
    CHECK(preco_unitario > 0.00),
    CONSTRAINT pk_id_pecas PRIMARY KEY(id_peca),
    CONSTRAINT uq_codigo_part_number UNIQUE(codigo_part_number)
);

/** IAS **/
CREATE TABLE linhas_producao(
    id_linha INT AUTO_INCREMENT,
    id_unidade INT NOT NULL,
    nome_linha VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_linhas PRIMARY KEY(id_linha),
    CONSTRAINT fk_unidades_senai_linhas_producao FOREIGN KEY(id_unidade) REFERENCES unidades_senai(id_unidade)
);

/** IAS **/
CREATE TABLE maquinas_senai(
    id_maquina INT AUTO_INCREMENT,
    id_linha INT NOT NULL,
    id_tipo INT NOT NULL,
    tag_patrimonio VARCHAR(30) NOT NULL,
    data_aquisicao DATE NOT NULL,
    status_operacao VARCHAR(20) NOT NULL,
    CHECK(status_operacao IN ('ATIVA', 'MANUTENCAO', 'DESATIVADA')),
    CONSTRAINT pk_id_maquinas PRIMARY KEY(id_maquina),
    CONSTRAINT uq_tag_patrimonio UNIQUE(tag_patrimonio),
    CONSTRAINT fk_linhas_producao_maquinas_senai FOREIGN KEY(id_linha) REFERENCES linhas_producao(id_linha),
    CONSTRAINT fk_tipos_maquina_maquinas_senai FOREIGN KEY(id_tipo) REFERENCES tipos_maquina(id_tipo)
);

/** IAS **/
CREATE TABLE componentes_maq(
    id_componente INT AUTO_INCREMENT,
    id_maquina INT NOT NULL,
    nome_componente VARCHAR(100) NOT NULL,
    horas_uso_acumulado INT NOT NULL DEFAULT 0,
    limite_horas_alerta INT NOT NULL,
    CHECK(horas_uso_acumulado >= 0),
    CONSTRAINT pk_id_componentes PRIMARY KEY(id_componente),
    CONSTRAINT fk_maquinas_senai_componentes_maq FOREIGN KEY(id_maquina) REFERENCES maquinas_senai(id_maquina)
);

/** IAS **/
CREATE TABLE ordens_servico(
    id_ordem INT AUTO_INCREMENT,
    id_maquina INT NOT NULL,
    id_tecnico INT NOT NULL,
    data_abertura DATETIME NOT NULL,
    tipo_manutencao VARCHAR(20) NOT NULL,
    status_os VARCHAR(20) NOT NULL,
    CHECK(tipo_manutencao IN ('PREVENTIVA', 'CORRETIVA', 'PREDITIVA')),
    CHECK(status_os IN ('ABERTA', 'EM_ANDAMENTO', 'CONCLUIDA', 'CANCELADA')),
    CONSTRAINT pk_id_ordens PRIMARY KEY(id_ordem),
    CONSTRAINT fk_maquinas_senai_ordens_servico FOREIGN KEY(id_maquina) REFERENCES maquinas_senai(id_maquina),
    CONSTRAINT fk_tecnicos_ordens_servico FOREIGN KEY(id_tecnico) REFERENCES tecnicos(id_tecnico)
);

/** IAS **/
CREATE TABLE pecas_os(
    id_ordem INT NOT NULL,
    id_peca INT NOT NULL,
    qtd_utilizada INT NOT NULL,
    preco_aplicado DECIMAL(10,2) NOT NULL,
    CHECK(qtd_utilizada > 0),
    CONSTRAINT pk_id_pecas_os PRIMARY KEY(id_ordem, id_peca),
    CONSTRAINT fk_ordens_servico_pecas_os FOREIGN KEY(id_ordem) REFERENCES ordens_servico(id_ordem),
    CONSTRAINT fk_estoque_pecas_pecas_os FOREIGN KEY(id_peca) REFERENCES estoque_pecas(id_peca)
);

/** IAS **/
CREATE TABLE historico_sensores(
    id_leitura INT AUTO_INCREMENT,
    id_ordem INT NOT NULL,
    temperatura_medida DECIMAL(5,2) NOT NULL,
    vibracao_mm_s DECIMAL(5,2) NOT NULL,
    data_hora_leitura DATETIME NOT NULL,
    prompt_geracao_ia VARCHAR(100) DEFAULT 'GERADO_POR_LLM',
    CHECK(temperatura_medida BETWEEN -50.00 AND 300.00),
    CONSTRAINT pk_id_leituras PRIMARY KEY(id_leitura),
    CONSTRAINT fk_ordens_servico_historico_sensores FOREIGN KEY(id_ordem) REFERENCES ordens_servico(id_ordem)
);
