<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "librarieonline";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Eroare la conectare: " . $conn->connect_error);
}

if (!isset($_GET['id_autor'])) {
    die("Autorul nu a fost specificat.");
}

$id_autor = intval($_GET['id_autor']);

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nume = $_POST['nume_autor'];
    $prenume = $_POST['prenume_autor'];
    $tara = $_POST['tara_origine'];

    $update_sql = "UPDATE autori SET nume_autor=?, prenume_autor=?, tara_origine=? WHERE id_autor=?";
    $stmt = $conn->prepare($update_sql);
    $stmt->bind_param("sssi", $nume, $prenume, $tara, $id_autor);

    if ($stmt->execute()) {
        $success = "Autorul a fost actualizat cu succes!";
    } else {
        $error = "Eroare la actualizare: " . $stmt->error;
    }

    $stmt->close();
}

$select_sql = "SELECT * FROM autori WHERE id_autor=?";
$stmt = $conn->prepare($select_sql);
$stmt->bind_param("i", $id_autor);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows !== 1) {
    die("Autorul nu a fost găsit.");
}

$autor = $result->fetch_assoc();
$stmt->close();
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Actualizare Autor</title>
    <style>
        body {
            background-color: #f3e8ff;
            font-family: 'Itim', cursive;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
        }

        h2 {
            color: #33186B;
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            color: #33186B;
            font-weight: bold;
        }

        input[type="text"] {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .btn-submit {
            background-color: #d6b6f8;
            color: #33186B;
            padding: 10px 15px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-submit:hover {
            background-color: #c19bf5;
        }

        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            background-color: #e6dcfd;
            color: #33186B;
            border: 1px solid #d6b6f8;
        }

        .error {
            background-color: #ffe2e2;
            color: #ff4f4f;
            border: 1px solid #ff6b6b;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Actualizează Autorul</h2>

    <?php if (isset($success)): ?>
        <div class="message success"><?php echo $success; ?></div>
    <?php elseif (isset($error)): ?>
        <div class="message error"><?php echo $error; ?></div>
    <?php endif; ?>

    <form method="POST">
        <label for="nume_autor">Nume</label>
        <input type="text" id="nume_autor" name="nume_autor" value="<?php echo htmlspecialchars($autor['nume_autor']); ?>" required>

        <label for="prenume_autor">Prenume</label>
        <input type="text" id="prenume_autor" name="prenume_autor" value="<?php echo htmlspecialchars($autor['prenume_autor']); ?>" required>

        <label for="tara_origine">Țara de origine</label>
        <input type="text" id="tara_origine" name="tara_origine" value="<?php echo htmlspecialchars($autor['tara_origine']); ?>" required>

        <button type="submit" class="btn-submit">Salvează Modificările</button>
    </form>
</div>
</body>
</html>

<?php
$conn->close();
?>