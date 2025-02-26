-- Letra H:Usuários
-- Primeiro Usuário com acesso para fazer consultas no banco de dados
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'consultor';
GRANT SELECT ON Academia.* TO 'usuario1'@'localhost';

REVOKE SELECT ON Academia.* FROM 'usuario1'@'localhost';
DROP USER 'usuario1'@'localhost';

-- Usuário com permissão para inserir novos dados
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'cadastro';
GRANT SELECT,INSERT ON Academia.* TO 'usuario2'@'localhost';

REVOKE SELECT,INSERT ON Academia.* FROM 'usuario2'@'localhost';
DROP USER 'usuario2'@'localhost';