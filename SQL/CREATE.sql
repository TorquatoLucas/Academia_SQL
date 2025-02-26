-- Letra A: criando o schema
CREATE SCHEMA Academia;
USE Academia;

-- Tabela Plano
CREATE TABLE Plano (
  idPlano INT NOT NULL AUTO_INCREMENT,
  valor DECIMAL(6,2) NOT NULL,
  nome VARCHAR(20) NOT NULL,
  CONSTRAINT pk_plano PRIMARY KEY (idPlano)
);

-- Tabela Sala
CREATE TABLE Sala (
  numSala 	INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  CONSTRAINT pk_sala PRIMARY KEY (numSala)
);


-- Tabela Atividade
CREATE TABLE Atividade (
  idAtividade INT NOT NULL AUTO_INCREMENT,
  maxAlunos INT NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  tipoAtividade VARCHAR(30) NOT NULL DEFAULT 'Musculação',
  numSala INT NOT NULL,
  CONSTRAINT pk_atividade PRIMARY KEY (idAtividade),
  CONSTRAINT fk_Atividade_Sala1 FOREIGN KEY (numSala)
    REFERENCES Sala (numSala)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

-- Tabela Cliente
CREATE TABLE Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  cpf 	CHAR(14) NOT NULL UNIQUE,
  nome 	VARCHAR(50) NOT NULL,
  cep 	CHAR(9) NOT NULL,
  bairro VARCHAR(30) NULL,
  rua VARCHAR(30) NOT NULL,
  numero INT NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado CHAR(2) NOT NULL,
  idPlano INT NOT NULL,
  dataInicio DATE NOT NULL,
  dataFim DATE NOT NULL,
  idAtividade INT NOT NULL,
  CONSTRAINT pk_Cliente PRIMARY KEY (idCliente),
  CONSTRAINT fk_Cliente_Plano FOREIGN KEY (idPlano)
    REFERENCES Plano (idPlano)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Cliente_Atividade FOREIGN KEY (idAtividade)
    REFERENCES Atividade (idAtividade)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


-- Tabela Treinador
CREATE TABLE Treinador (
  idTreinador INT NOT NULL,
  cpf CHAR(14) NOT NULL UNIQUE,
  nome VARCHAR(50) NOT NULL,
  cep CHAR(9) NOT NULL,
  bairro VARCHAR(30) NULL,
  rua VARCHAR(30) NOT NULL,
  numero INT NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado CHAR(2) NOT NULL,
  especialidade VARCHAR(30) NOT NULL,
  CONSTRAINT pk_Treinador PRIMARY KEY (idTreinador)
);


-- Tabela Equipamento
CREATE TABLE Equipamento (
  idEquipamento INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(30) NOT NULL,
  nome VARCHAR(30) NOT NULL,
  CONSTRAINT pk_Equipamento PRIMARY KEY (idEquipamento)
);

-- Tabela Utiliza(Relacionamento entre atividade e equipamento)
CREATE TABLE Utiliza (
  idAtividade INT NOT NULL,
  idEquipamento INT NOT NULL,
  CONSTRAINT pk_utiliza PRIMARY KEY (idAtividade, idEquipamento),
  CONSTRAINT fk_Utiliza_Equipamento FOREIGN KEY (idEquipamento)
    REFERENCES Equipamento (idEquipamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Atividade_Utiliza FOREIGN KEY (idAtividade)
    REFERENCES Atividade (idAtividade)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Tabela Ministra(Relacionamento entre treiandor e atividade)
CREATE TABLE Ministra (
  idTreinador INT NOT NULL,
  idAtividade INT NOT NULL,
  CONSTRAINT pk_Ministra PRIMARY KEY (idTreinador, idAtividade),
  CONSTRAINT fk_Treinador_Ministra FOREIGN KEY (idTreinador)
    REFERENCES Treinador (idTreinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Ministra_Atividade FOREIGN KEY (idAtividade)
    REFERENCES Atividade (idAtividade)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- Tabela Telefone do Cliente
CREATE TABLE FoneCliente (
  idCliente INT NOT NULL,
  telefone CHAR(14) NOT NULL,
  CONSTRAINT pk_FoneCli PRIMARY KEY (idCliente, telefone),
  CONSTRAINT fk_FoneCliente_Cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- Tabela Email do Cliente
CREATE TABLE EmailCliente (
  idCliente INT NOT NULL,
  email VARCHAR(30) NOT NULL,
  CONSTRAINT pk_EmailCli PRIMARY KEY (idCliente, email)
);


-- Tabela Telefone do Treinador
CREATE TABLE FoneTreinador (
  idTreinador INT NOT NULL,
  telefone CHAR(14) NOT NULL,
  CONSTRAINT pk_FoneTrei PRIMARY KEY (idTreinador, telefone),
  CONSTRAINT fk_FoneTreinador_Treinador FOREIGN KEY (idTreinador)
    REFERENCES Treinador (idTreinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- Tabela Email do Treiandor
CREATE TABLE EmailTreinador (
  idTreinador INT NOT NULL,
  email VARCHAR(30) NOT NULL,
  CONSTRAINT pk_EmailTre PRIMARY KEY (idTreinador, email)
);


-- Letra B: modificações e exclusão
CREATE TABLE Produto (
	Id INT NOT NULL,
    Valor DECIMAL(7,2),
    Descrição VARCHAR(50),
    CONSTRAINT pk_Produto PRIMARY KEY (Id)
);

-- Adiciona a coluna salário na tabela Treinador
ALTER TABLE Treinador
ADD COLUMN salario DECIMAL(7,2) NOT NULL DEFAULT 1300.00;

-- Adiciona chave estrangeira em EmailTreinador
ALTER TABLE EmailTreinador
ADD CONSTRAINT fk_Email_Treinador FOREIGN KEY (idTreinador)
		REFERENCES Treinador (idTreinador)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

-- Adiciona chave estrangeira em EmailCliente
ALTER TABLE EmailCliente
ADD CONSTRAINT fk_Email_Cliente FOREIGN KEY (idCliente)
		REFERENCES Cliente (idCliente)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
        
DROP TABLE Produto;

-- Letra C: inserções
-- Inserindo dados na tabela Plano
INSERT INTO Plano (valor, nome) VALUES (100.00, 'Básico');
INSERT INTO Plano (valor, nome) VALUES (150.00, 'Intermediário');
INSERT INTO Plano (valor, nome) VALUES (200.00, 'Avançado');
INSERT INTO Plano (valor, nome) VALUES (250.00, 'Premium');
INSERT INTO Plano (valor, nome) VALUES (300.00, 'VIP');

-- Inserindo dados na tabela Sala
INSERT INTO Sala (numSala, descricao) VALUES (101, 'Sala de Musculação');
INSERT INTO Sala (numSala, descricao) VALUES (102, 'Sala de Dança');
INSERT INTO Sala (numSala, descricao) VALUES (103, 'Sala de Judo');
INSERT INTO Sala (numSala, descricao) VALUES (104, 'Sala de Pilates');
INSERT INTO Sala (numSala, descricao) VALUES (105, 'Sala Multifuncional');

-- Inserindo dados na tabela Atividade
INSERT INTO Atividade (maxAlunos, descricao, tipoAtividade, numSala) VALUES
(25, 'Treino de força', 'Musculação', 101),
(30, 'Aula de Zumba', 'Dança', 102),
(10, 'Judo Infantil', 'Judô', 103),
(25, 'Treino funcional', 'Musculação', 105),
(15, 'Spinning intenso', 'Musculação', 101),
(20, 'Aula de Samba', 'Dança', 102),
(12, 'Aula de Balé', 'Dança', 102),
(10, 'Judo Iniciante', 'Judô', 103),
(8, 'Judo Avançado', 'Judô', 103),
(20, 'Treino Full Body', 'Musculação', 101),
(20, 'Pilates para idosos', 'Pilates', 104);

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (cpf, nome, cep, bairro, rua, numero, cidade, estado, idPlano, dataInicio, dataFim, idAtividade)
VALUES 
('111.222.333-44', 'Carlos Silva', '37500-000', 'Centro', 'Rua A', 100, 'Lavras', 'MG', 1, '2025-01-01', '2025-12-31', 1),
('222.333.444-55', 'Ana Souza', '37501-111', 'Jardins', 'Rua B', 150, 'Lavras', 'MG', 2, '2025-02-01', '2025-11-30', 2),
('333.444.555-66', 'Bruno Rocha', '37502-222', null, 'Rua C', 200, 'Lavras', 'MG', 3, '2025-03-01', '2025-10-31', 3),
('444.555.666-77', 'Mariana Lima', '37503-333', 'São Pedro', 'Rua D', 250, 'Lavras', 'MG', 1, '2025-04-01', '2025-09-30', 1),
('555.666.777-88', 'Gabriela Torres', '37504-444', 'Vila Nova', 'Rua E', 300, 'Lavras', 'MG', 2, '2025-05-01', '2025-08-31', 2),
('666.777.888-99', 'João Oliveira', '37505-555', 'Centro', 'Rua F', 400, 'Lavras', 'MG', 3, '2025-06-01', '2025-07-31', 6),
('777.888.999-00', 'Maria Santos', '37506-666', 'Jardins', 'Rua G', 450, 'Lavras', 'MG', 4, '2025-07-01', '2025-08-31', 7),
('888.999.000-11', 'Pedro Costa', '37507-777', 'Boa Vista', 'Rua H', 500, 'Lavras', 'MG', 5, '2025-08-01', '2025-09-30', 8),
('999.000.111-22', 'Luiza Mendes', '37508-888', 'São Pedro', 'Rua I', 550, 'Lavras', 'MG', 1, '2025-09-01', '2025-10-31', 9),
('000.111.222-33', 'Rafael Torres', '37509-999', null, 'Rua J', 600, 'Lavras', 'MG', 2, '2025-10-01', '2025-11-30', 10);


-- Inserindo dados na tabela treinador
INSERT INTO Treinador (idTreinador, cpf, nome, cep, bairro, rua, numero, cidade, estado, especialidade, salario)
VALUES 
(1, '666.777.888-99', 'Lucas Pereira', '37500-000', 'Centro', 'Av. Principal', 101, 'Lavras', 'MG', 'Musculação', 2000.00),
(2, '777.888.999-00', 'Fernanda Costa', '37501-111', 'Jardins', 'Rua das Flores', 202, 'Lavras', 'MG', 'Dança', 2200.00),
(3, '888.999.000-11', 'Ricardo Almeida', '37502-222', 'Boa Vista', 'Rua da Paz', 303, 'Lavras', 'MG', 'Judô', 2500.00),
(4, '999.000.111-22', 'Carla Mendes', '37503-333', 'São Pedro', 'Rua do Sol', 404, 'Lavras', 'MG', 'Crossfit', 2300.00),
(5, '000.111.222-33', 'Eduardo Lima', '37504-444', 'Vila Nova', 'Rua das Palmeiras', 505, 'Lavras', 'MG', 'Alongamento', 2100.00);

-- Inserindo dados na tabela equipamento
INSERT INTO Equipamento (tipo, nome) VALUES 
('Halteres', 'Halter 10kg'),
('Esteira', 'Esteira Pro'),
('Bicicleta', 'Bicicleta Ergométrica'),
('Banco', 'Banco de Supino'),
('Corda', 'Corda de Pular');

-- Inserindo dados na tabela utiliza
INSERT INTO Utiliza (idAtividade, idEquipamento) VALUES 
(1, 1),  
(1, 4),  
(2, 5),  
(3, 2),  
(4, 3);

-- Inserindo dados na tabela ministra
INSERT INTO Ministra (idTreinador, idAtividade) VALUES 
(1, 1),  
(2, 2), 
(3, 3),  
(4, 4),  
(5, 5),
(2, 6), 
(2, 7), 
(3, 8),  
(3, 9), 
(1, 10), 
(5, 11);

-- Inserindo dados na tabela fonecliente
INSERT INTO FoneCliente (idCliente, telefone) VALUES 
(1, '(35) 9999-8888'),
(2, '(35) 8888-7777'),
(3, '(35) 7777-6666'),
(4, '(35) 6666-5555'),
(5, '(35) 5555-4444'),
(6, '(35) 4444-3333'),
(7, '(35) 3333-2222'),
(8, '(35) 2222-1111'),
(9, '(35) 1111-0000'),
(10, '(35) 0000-9999');

-- Inserindo dados na tabela emailcliente
INSERT INTO EmailCliente (idCliente, email) VALUES 
(1, 'carlos.silva@email.com'),
(2, 'ana.souza@email.com'),
(3, 'bruno.rocha@email.com'),
(4, 'mariana.lima@email.com'),
(5, 'gabriela.torres@email.com'),
(6, 'joao.oliveira@email.com'),
(7, 'maria.santos@email.com'),
(8, 'pedro.costa@email.com'),
(9, 'luiza.mendes@email.com'),
(10, 'rafael.torres@email.com');

-- Inserindo dados na tabela fonetreinador
INSERT INTO FoneTreinador (idTreinador, telefone) VALUES 
(1, '(35) 9999-1111'),
(2, '(35) 8888-2222'),
(3, '(35) 7777-3333'),
(4, '(35) 6666-4444'),
(5, '(35) 5555-5555');

-- Inserindo dados na tabela emailtreinador
INSERT INTO EmailTreinador (idTreinador, email) VALUES 
(1, 'lucas.pereira@email.com'),
(2, 'fernanda.costa@email.com'),
(3, 'ricardo.almeida@email.com'),
(4, 'carla.mendes@email.com'),
(5, 'eduardo.lima@email.com');
