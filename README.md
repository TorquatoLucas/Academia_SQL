# Sistema de Gerenciamento de Dados com PHP, MySQL e XAMPP

Este repositório contém um projeto completo para gerenciamento de dados, incluindo:
- Um **relatório técnico** com diagramas e documentação do banco de dados.
- Códigos **SQL** para criação e manipulação do banco de dados.
- Códigos **PHP/HTML** que, juntamente com o XAMPP, geram uma interface no navegador para manipulação dos dados.

---

## **Estrutura do Repositório**

### 1. **Relatório Técnico**
O pdf `Relatorio` contém a documentação completa do banco de dados, incluindo:
- **Diagrama ER (Entidade-Relacionamento)**: Representação visual das entidades e seus relacionamentos.
- **Dicionário de Dados**: Descrição dos tipos e atributos das tabelas.
- **Tipos de Dados**: Especificação dos tipos de dados que cada atributo armazena.
- **Diagrama Relacional**: Representação das tabelas e suas relações no banco de dados.

### 2. **Códigos SQL**
A pasta `SQL` contém scripts SQL para:
- **Criação do Banco de Dados**: Comandos `CREATE TABLE` para definir a estrutura do banco.
- **Inserção de Dados**: Comandos `INSERT` para popular as tabelas.
- **Consultas**: Comandos `SELECT` para recuperar dados.
- **Atualizações**: Comandos `UPDATE` para modificar dados existentes.
- **Exclusões**: Comandos `DELETE` para remover dados.
- **Entre outros**.

### 3. **Códigos PHP/HTML**
A pasta `php-html` contém os arquivos que geram a interface no navegador:
- **Interface de Usuário**: Formulários e tabelas para adicionar, editar, excluir e visualizar dados.
- **Conexão com o Banco de Dados**: Scripts PHP para conectar ao MySQL e executar operações.
- **Funcionalidades**:
  - Cadastro de novos registros.
  - Edição de registros existentes.
  - Exclusão de registros.
  - Visualização de dados em tabelas.

---

## **Como Executar o Projeto**

### **Pré-requisitos**
1. **XAMPP**: Instale o XAMPP para rodar o servidor Apache e o MySQL.
   - Download: [https://www.apachefriends.org]
2. **Navegador**: Qualquer navegador moderno (Chrome, Firefox, Edge, etc.).

### **Passos para Configuração**

1. **Baixe o Repositório**:

https://github.com/TorquatoLucas/Academia_SQL

2. **Configure o XAMPP**:

- Inicie o Apache e o MySQL no XAMPP Control Panel.

- Coloque a pasta php-html do projeto dentro de C:\xampp\htdocs.

- Renomeie a pasta para `academia`.

3. **Importe o Banco de Dados**:

- Abra o phpMyAdmin: http://localhost/phpmyadmin.

- Crie um novo banco de dados com o nome especificado no projeto.

- Importe o arquivo CREATE.sql da pasta SQL para criar as tabelas e inserir dados iniciais.

4. **Configure a Conexão com o Banco de Dados**:

- Edite o arquivo config.php na pasta php-html para definir as credenciais do banco de dados:

5. **Acesse a Interface**:

- Abra o navegador e acesse: http://localhost/nome-da-pasta/index.php.

- Use a interface para manipular os dados.
