
-- Letra I: Funções e Procedimentos
-- Procedimento de inserir um novo plano na tabela Plano.
DELIMITER $$
CREATE PROCEDURE InserirNovoPlano(
    IN p_nome VARCHAR(20),
    IN p_valor DECIMAL(6,2)
)
BEGIN
    INSERT INTO Plano (nome, valor) VALUES (p_nome, p_valor);
END$$
DELIMITER ;

-- Testando:

-- Inserir um plano "Família" de R$ 350,00:
CALL InserirNovoPlano('Família', 350.00);

-- Verificar inserção:
SELECT * FROM Plano WHERE nome = 'Família';

-- Função que retorna a média salarial dos treinadores.
DELIMITER $$
CREATE FUNCTION CalcularMediaSalarial() 
RETURNS DECIMAL(7,2)
DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(7,2);
    SELECT AVG(salario) INTO media FROM Treinador;
    RETURN media;
END$$
DELIMITER ;

-- Testando:

-- Calcular a média salarial:
SELECT CalcularMediaSalarial() AS MediaSalarial;

-- Procedimento que lista clientes associados a um plano específico.
DELIMITER $$
CREATE PROCEDURE ListarClientesPorPlano(
    IN p_idPlano INT
)
BEGIN
    SELECT C.nome AS Cliente, P.nome AS Plano
    FROM Cliente C
    JOIN Plano P ON C.idPlano = P.idPlano
    WHERE C.idPlano = p_idPlano;
END$$
DELIMITER ;

-- Testando:

-- Listar clientes do plano "Básico" (ID 1):
CALL ListarClientesPorPlano(1);


-- Letra J:Triggers
-- Trigger que  registra automaticamente em uma tabela de histórico (HistoricoCliente) quando um novo cliente é inserido.
-- Criação da tabela
CREATE TABLE HistoricoCliente (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    acao VARCHAR(20) NOT NULL,
    dataHora DATETIME NOT NULL
);

-- Criação do trigger
DELIMITER $$
CREATE TRIGGER trigger_AposInsercaoCliente
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO HistoricoCliente (idCliente, acao, dataHora)
    VALUES (NEW.idCliente, 'CLIENTE INSERIDO', NOW());
END$$
DELIMITER ;

-- Testando:

-- Ativação
INSERT INTO Cliente (cpf, nome, cep, bairro, rua, numero, cidade, estado, idPlano, dataInicio, dataFim, idAtividade)
VALUES ('123.456.789-00', 'Joana Dias', '37500-123', 'Centro', 'Rua K', 700, 'Lavras', 'MG', 1, '2025-01-01', '2025-12-31', 1);

-- Conferindo
SELECT * FROM HistoricoCliente;

-- Trigger que registra alterações no valor de um plano em uma tabela de histórico (HistoricoPreco) e validar se o novo valor é positivo.
-- Criação da tabela
CREATE TABLE HistoricoPreco (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    idPlano INT NOT NULL,
    valorAntigo DECIMAL(6,2) NOT NULL,
    valorNovo DECIMAL(6,2) NOT NULL,
    dataHora DATETIME NOT NULL
);

-- Criação do trigger
DELIMITER $$
CREATE TRIGGER trigger_AntesAtualizarPlano
BEFORE UPDATE ON Plano
FOR EACH ROW
BEGIN
    -- Valida se o novo valor é positivo
    IF NEW.valor <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor do plano deve ser maior que zero.';
    END IF;

    -- Registra o histórico se o valor mudou
    IF OLD.valor <> NEW.valor THEN
        INSERT INTO HistoricoPreco (idPlano, valorAntigo, valorNovo, dataHora)
        VALUES (OLD.idPlano, OLD.valor, NEW.valor, NOW());
    END IF;
END$$
DELIMITER ;

-- Testando:

-- Ativação
UPDATE Plano SET valor = -100.00 WHERE idPlano = 2;

-- Não é disparado
UPDATE Plano SET valor = 155.00 WHERE idPlano = 2;

-- Conferindo
SELECT * FROM Historicopreco;

-- Trigger que impede a exclusão de atividades que possuem clientes inscritos.
-- Criação do trigger
DELIMITER $$
CREATE TRIGGER trigger_AntesDeletarAtividade
BEFORE DELETE ON Atividade
FOR EACH ROW
BEGIN
    DECLARE qtdClientes INT;
    
    -- Conta clientes associados à atividade
    SELECT COUNT(*) INTO qtdClientes
    FROM Cliente
    WHERE idAtividade = OLD.idAtividade;
    
    -- Se houver clientes, cancela a exclusão
    IF qtdClientes > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir atividades com clientes inscritos.';
    END IF;
END$$
DELIMITER ;

-- Testando

-- Ativação
DELETE FROM Atividade WHERE idAtividade = 1;

commit;
