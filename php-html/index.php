<?php
header("Content-Type: text/html; charset=UTF-8");
?>
<html>
<head>
    <meta charset="utf-8">
    <title>Cadastro de Planos</title>
</head>
<body>
<center><h3>Cadastro de Planos</h3></center>
<table border="0" align="center" width="60%">
    <?php
    include("./config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);

    if (!$con) {
        die('Erro ao conectar: ' . mysqli_connect_error());
    }

    // Consultar os planos cadastrados
    $sql = "SELECT * FROM Plano ORDER BY nome";
    $tabela = mysqli_query($con, $sql);

    if (!$tabela) {
        die('Erro na consulta: ' . mysqli_error($con));
    }

    // Verificar se existem planos cadastrados
    if (mysqli_num_rows($tabela) == 0) {
        echo "<tr><td align='center'>Não há nenhum plano cadastrado.</td></tr>";
    } else {
        echo "<tr bgcolor='grey'><td width='40%'>Nome</td><td width='20%'>Valor</td><td width='20%'></td></tr>";
        
        while ($dados = mysqli_fetch_assoc($tabela)) {
            echo "<tr>";
            echo "<td>{$dados['nome']}</td>";
            echo "<td>R$ " . number_format($dados['valor'], 2, ',', '.') . "</td>";
            echo "<td align='center'>";
            echo "<input type='button' value='Excluir' onclick=\"location.href='excluir.php?id={$dados['idPlano']}'\">";
            echo "<input type='button' value='Editar' onclick=\"location.href='form_incluir.php?id={$dados['idPlano']}'\">";
            echo "</td>";
            echo "</tr>";
        }
    }

    mysqli_close($con);
    ?>
    <tr><td colspan="3" align="center"><input type="button" value="Incluir Novo Plano" onclick="location.href='form_incluir.php'"></td></tr>
</table>
</body>
</html>
