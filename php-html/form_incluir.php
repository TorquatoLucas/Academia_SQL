<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>
<head>
    <title>Incluir/Editar Plano</title>
    <style>
        input[type="button"], input[type="submit"] {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form name="form1" method="POST" action="incluir.php">
        <?php
        if (isset($_GET["id"])) {    
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
            
            if (!$con) {
                die("Erro ao conectar ao banco de dados: " . mysqli_connect_error());
            }

            $sql = "SELECT * FROM Plano WHERE idPlano=" . intval($_GET['id']);
            $result = mysqli_query($con, $sql);

            if ($result && mysqli_num_rows($result) > 0) {
                $plano = mysqli_fetch_array($result, MYSQLI_ASSOC);
            } else {
                die("Plano não encontrado.");
            }

            mysqli_close($con);
        ?>
        <center><h3>Editar Plano</h3></center>
        <input type="hidden" name="id" value="<?php echo $_GET['id']; ?>">
        <table border="0" align="center" width="35%">
            <tr>
                <td>Nome:</td>
                <td><input type="text" name="nome" value="<?php echo htmlspecialchars($plano['nome']); ?>" required></td>
            </tr>
            <tr>
                <td>Valor:</td>
                <td><input type="number" step="0.01" name="valor" value="<?php echo htmlspecialchars($plano['valor']); ?>" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Salvar"></td>
            </tr>
        </table>
        <?php
        } else {
        ?>
        <center><h3>Cadastrar Novo Plano</h3></center>
        <table border="0" align="center" width="35%">
            <tr>
                <td>Nome:</td>
                <td><input type="text" name="nome" required></td>
            </tr>
            <tr>
                <td>Valor:</td>
                <td><input type="number" step="0.01" name="valor" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Salvar"></td>
            </tr>
        </table>
        <?php
        }
        ?>
    </form>
</body>
</html>
