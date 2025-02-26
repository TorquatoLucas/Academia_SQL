
-- Letra G: criando visões
--  Mostrar detalhes dos clientes junto com o nome e valor do plano que possuem.
CREATE VIEW visao_ClientesPlanos AS
SELECT 
  C.nome AS Cliente,
  P.nome AS Plano,
  P.valor AS ValorPlano,
  C.dataInicio AS InicioContrato
FROM Cliente C
JOIN Plano P ON C.idPlano = P.idPlano;

-- Exemplo de uso:

-- Listar todos os clientes e seus planos:
SELECT * FROM visao_ClientesPlanos;

-- Filtrar clientes com planos acima de R$ 200:
SELECT Cliente, Plano, ValorPlano 
FROM visao_ClientesPlanos
WHERE ValorPlano > 200;

--  Exibir atividades e sua lotação atual em relação à capacidade máxima.
CREATE VIEW visao_AtividadesLotacao AS
SELECT 
  A.idAtividade,
  A.descricao AS Atividade,
  A.maxAlunos AS CapacidadeMaxima,
  COUNT(C.idCliente) AS AlunosInscritos,
  (A.maxAlunos - COUNT(C.idCliente)) AS VagasRestantes
FROM Atividade A
LEFT JOIN Cliente C ON A.idAtividade = C.idAtividade
GROUP BY A.idAtividade;

-- Exemplos de uso:

-- Ver atividades com vagas disponíveis:
SELECT Atividade, VagasRestantes 
FROM visao_AtividadesLotacao
WHERE VagasRestantes > 0;

-- Listar todas as atividades e lotação:
SELECT * FROM visao_AtividadesLotacao;

--  Listar treinadores e as atividades que ministram, incluindo a sala.
CREATE VIEW visao_TreinadoresAtividades AS
SELECT 
  T.nome AS Treinador,
  A.descricao AS Atividade,
  S.descricao AS Sala
FROM Treinador T
JOIN Ministra M ON T.idTreinador = M.idTreinador
JOIN Atividade A ON M.idAtividade = A.idAtividade
JOIN Sala S ON A.numSala = S.numSala;

-- Exemplos de uso:

-- Listar todas as aulas do treinador "Ricardo Almeida":
SELECT Atividade, Sala 
FROM visao_TreinadoresAtividades
WHERE Treinador = 'Ricardo Almeida';

-- Ver todas as atividades na "Sala de Musculação":
SELECT Treinador, Atividade 
FROM visao_TreinadoresAtividades
WHERE Sala = 'Sala de Musculação';