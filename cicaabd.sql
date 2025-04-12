-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS cicada;
USE cicada;

-- Tabela USUARIO
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    tipo ENUM('candidato', 'empresa', 'admin') NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_usuario_email (email),
    INDEX idx_usuario_tipo (tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela CANDIDATO
CREATE TABLE candidato (
    id_candidato INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    endereco TEXT,
    sobre TEXT,
    curriculo_path VARCHAR(255),
    linkedin_url VARCHAR(255),
    github_url VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    INDEX idx_candidato_cpf (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela EMPRESA
CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    cnpj VARCHAR(18) UNIQUE,
    razao_social VARCHAR(100),
    nome_fantasia VARCHAR(100),
    descricao TEXT,
    logo_path VARCHAR(255),
    website VARCHAR(255),
    ramo_atividade VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    INDEX idx_empresa_cnpj (cnpj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela VAGA
CREATE TABLE vaga (
    id_vaga INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    tipo_contrato ENUM('estagio', 'clt', 'pj', 'aprendiz') NOT NULL,
    modalidade ENUM('presencial', 'remoto', 'hibrido') NOT NULL,
    localizacao VARCHAR(100),
    salario_min DECIMAL(10,2),
    salario_max DECIMAL(10,2),
    data_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_encerramento DATETIME,
    ativa BOOLEAN DEFAULT TRUE,
    vagas_disponiveis INT DEFAULT 1,
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE,
    INDEX idx_vaga_titulo (titulo),
    INDEX idx_vaga_tipo (tipo_contrato),
    INDEX idx_vaga_modalidade (modalidade),
    INDEX idx_vaga_data (data_publicacao),
    INDEX idx_vaga_ativa (ativa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela REQUISITO
CREATE TABLE requisito (
    id_requisito INT AUTO_INCREMENT PRIMARY KEY,
    id_vaga INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    tipo ENUM('obrigatorio', 'diferencial') NOT NULL,
    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga) ON DELETE CASCADE,
    INDEX idx_requisito_vaga (id_vaga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela BENEFICIO
CREATE TABLE beneficio (
    id_beneficio INT AUTO_INCREMENT PRIMARY KEY,
    id_vaga INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga) ON DELETE CASCADE,
    INDEX idx_beneficio_vaga (id_vaga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela CANDIDATURA
CREATE TABLE candidatura (
    id_candidatura INT AUTO_INCREMENT PRIMARY KEY,
    id_vaga INT NOT NULL,
    id_candidato INT NOT NULL,
    data_aplicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT,
    curriculo_enviado VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga) ON DELETE CASCADE,
    FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
    UNIQUE KEY uk_candidatura_vaga_candidato (id_vaga, id_candidato),
    INDEX idx_candidatura_vaga (id_vaga),
    INDEX idx_candidatura_candidato (id_candidato),
    INDEX idx_candidatura_data (data_aplicacao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela STATUS_CANDIDATURA
CREATE TABLE status_candidatura (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    id_candidatura INT NOT NULL,
    status ENUM('pendente', 'visualizada', 'entrevista', 'rejeitada', 'contratada') NOT NULL,
    data_status DATETIME DEFAULT CURRENT_TIMESTAMP,
    feedback TEXT,
    FOREIGN KEY (id_candidatura) REFERENCES candidatura(id_candidatura) ON DELETE CASCADE,
    INDEX idx_status_candidatura (id_candidatura),
    INDEX idx_status_tipo (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela FORMACAO
CREATE TABLE formacao (
    id_formacao INT AUTO_INCREMENT PRIMARY KEY,
    id_candidato INT NOT NULL,
    instituicao VARCHAR(100) NOT NULL,
    curso VARCHAR(100) NOT NULL,
    nivel ENUM('ensino_medio', 'tecnologo', 'graduacao', 'pos_graduacao', 'mestrado', 'doutorado') NOT NULL,
    ano_inicio INT,
    ano_conclusao INT,
    cursando BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
    INDEX idx_formacao_candidato (id_candidato)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela EXPERIENCIA
CREATE TABLE experiencia (
    id_experiencia INT AUTO_INCREMENT PRIMARY KEY,
    id_candidato INT NOT NULL,
    empresa VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    atual BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
    INDEX idx_experiencia_candidato (id_candidato),
    INDEX idx_experiencia_empresa (empresa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela HABILIDADE
CREATE TABLE habilidade (
    id_habilidade INT AUTO_INCREMENT PRIMARY KEY,
    id_candidato INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    tipo ENUM('tecnica', 'comportamental') NOT NULL,
    nivel ENUM('basico', 'intermediario', 'avancado') NOT NULL,
    FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
    INDEX idx_habilidade_candidato (id_candidato),
    INDEX idx_habilidade_nome (nome),
    UNIQUE KEY uk_habilidade_candidato_nome (id_candidato, nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela MENSAGEM
CREATE TABLE mensagem (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    assunto VARCHAR(100),
    conteudo TEXT NOT NULL,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    lida BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_remetente) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_destinatario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    INDEX idx_mensagem_remetente (id_remetente),
    INDEX idx_mensagem_destinatario (id_destinatario),
    INDEX idx_mensagem_data (data_envio),
    INDEX idx_mensagem_lida (lida)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Inserção de dados iniciais (opcional)
INSERT INTO usuario (nome, email, senha_hash, tipo) VALUES 
('Admin', 'admin@cicada.com', '$2y$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi', 'admin');

-- Gatilhos e procedimentos armazenados

-- Atualiza status inicial da candidatura
DELIMITER //
CREATE TRIGGER after_candidatura_insert
AFTER INSERT ON candidatura
FOR EACH ROW
BEGIN
    INSERT INTO status_candidatura (id_candidatura, status)
    VALUES (NEW.id_candidatura, 'pendente');
END//
DELIMITER ;
