
-- Letra D: modificações em tabelas
-- Atualizando valores nas tabelas
UPDATE Cliente SET idPlano = 2 WHERE idCliente = 1;
UPDATE Treinador SET salario = 1800.00 WHERE idTreinador = 3;
UPDATE Atividade SET maxAlunos = 25 WHERE idAtividade = 1;
UPDATE Plano SET valor = 175.00 WHERE idPlano = 2;
UPDATE Equipamento SET nome = 'Leg Press 45' WHERE idEquipamento = 2;
-- Aumenta em 10% o salrio do treinador que estiver ministrando mais de 2 atividades
UPDATE Treinador
SET salario = salario * 1.10  
WHERE idTreinador IN (
    SELECT idTreinador
    FROM Ministra
    GROUP BY idTreinador
    HAVING COUNT(idAtividade) > 2
);



-- Letra E: excluindo dados das tabelas
-- Excluindo dados das tabelas
DELETE FROM FoneCliente WHERE idCliente = 3;
DELETE FROM FoneTreinador WHERE idTreinador = 2;
DELETE FROM EmailCliente WHERE idCliente = 5;
DELETE FROM EmailTreinador WHERE idTreinador = 1;
DELETE FROM Utiliza WHERE idAtividade = 3;
-- Exclui as atividades que não possui clientes inscritos
DELETE FROM Atividade
WHERE idAtividade NOT IN (
    SELECT idAtividade
    FROM Cliente
    WHERE idAtividade IS NOT NULL
);


-- Letra F: Consultas na Tabela
-- Consulta para encontrar qual atividade cada cliente realiza dentro da academia
SELECT C.nome, A.descricao 
FROM Cliente AS C INNER JOIN atividade AS A ON C.idAtividade = A.idAtividade;

-- Consulta para obter o treinador, o id da sua atividade ministrada e uma breve descrição dessa atividade.
SELECT T.nome AS Treinador, M.idAtividade AS IDAtividade, A.descricao AS Descricao 
FROM Treinador AS T LEFT JOIN Ministra AS M ON T.idTreinador = M.idTreinador LEFT JOIN Atividade AS A on M.idAtividade = A.idAtividade; 

-- Retorna todos os treinadores e seus respectivos salários ordenados de forma descrescente.
SELECT nome AS NomeTreinador, salario AS Salarios 
FROM treinador 
ORDER BY salario DESC;

-- Conta quantos clientes cada plano possui.
SELECT P.nome AS NomePlano, COUNT(C.idPlano) AS TotalClientes 
FROM Plano AS P LEFT JOIN Cliente AS C ON P.idPlano = C.idPlano 
GROUP BY P.nome;

-- Recupera o nome do plano e a quantidade de assinantes desde que seja maior que 2.
SELECT P.nome AS NomePlano, COUNT(C.idPlano) AS TotalClientes 
FROM Plano AS P LEFT JOIN Cliente AS C ON P.idPlano = C.idPlano 
GROUP BY P.nome 
HAVING TotalClientes > 2;

-- Busca todos os cadastrados na academia, incluindo clientes e treinadores
SELECT nome AS Cadastros, cpf, cep 
FROM Cliente 
UNION
SELECT nome, cpf, cep 
FROM Treinador; 

-- Busca por treinadores, exceto os que dão aulas de musculação
SELECT nome, especialidade 
FROM Treinador AS T NATURAL JOIN Ministra NATURAL JOIN Atividade
WHERE tipoAtividade NOT IN ('Musculação')
GROUP BY T.idTreinador;

-- Busca por clientes com a primeira letra do nome sendo 'a' a tendo a matrícula iniciada entre 2024 e 2025
SELECT nome, cpf 
FROM Cliente 
WHERE UPPER(nome) LIKE 'A%' 
AND YEAR(dataInicio) BETWEEN 2024 AND 2025;

-- Busca pelos Clientes que não cadastraram o seu bairro
SELECT nome, cpf 
FROM cliente 
WHERE bairro IS NULL;

-- Busca clientes cujo plano tenha valor maior que pelo menos um dos planos do tipo "Básico" ou "Intermediário"
SELECT c.nome AS Cliente, p.nome AS Plano, p.valor AS Valor_Plano
FROM Cliente c
JOIN Plano p ON c.idPlano = p.idPlano
WHERE p.valor > ANY (
    SELECT valor
    FROM Plano
    WHERE nome IN ('Básico', 'Intermediário')
);

-- Busca treinadores cujo salário é maior que todos os salários dos treinadores que ministram aulas de "Judô"
SELECT t.nome AS Treinador, t.salario
FROM Treinador t
WHERE t.salario > ALL (
    SELECT salario
    FROM Treinador
    WHERE especialidade = 'Judô'
);

--  Busca atividades que possuem pelo menos um equipamento associado na tabela Utiliza.
SELECT a.descricao AS Atividade
FROM Atividade a
WHERE EXISTS (
    SELECT 1
    FROM Utiliza u
    WHERE u.idAtividade = a.idAtividade
);