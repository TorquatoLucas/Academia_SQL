<?php
include("./config.php");

$con = mysqli_connect($host, $login, $senha, $bd);

if (!$con) {
    die("Erro ao conectar ao banco de dados: " . mysqli_connect_error());
}

// Validar e limpar os dados recebidos
$nome = isset($_POST["nome"]) ? mysqli_real_escape_string($con, trim($_POST["nome"])) : '';
$valor = isset($_POST["valor"]) ? floatval($_POST["valor"]) : 0;

if (empty($nome) || $valor <= 0) {
    die("Erro: Nome e valor são obrigatórios.");
}

if (isset($_POST["id"])) {
    // Atualizar plano existente
    $id = intval($_POST["id"]);
    $sql = "UPDATE Plano SET nome='$nome', valor=$valor WHERE idPlano=$id";
} else {
    // Inserir novo plano
    $sql = "INSERT INTO Plano (valor, nome) VALUES ($valor, '$nome')";
}

if (mysqli_query($con, $sql)) {
    header("Location: ./index.php");
} else {
    echo "Erro ao executar a operação: " . mysqli_error($con);
}

mysqli_close($con);
?>
