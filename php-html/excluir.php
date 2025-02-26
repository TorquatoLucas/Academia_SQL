<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);

// Verificar se o id foi passado via GET
if(isset($_GET["id"])){
    // Excluir o plano com base no id
    $sql = "DELETE FROM Plano WHERE idPlano=" . intval($_GET["id"]);
    mysqli_query($con, $sql);
}

// Redirecionar de volta para a página principal
header("location: ./index.php");
?>

