<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "librarieonline";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Eroare la conectare: " . $conn->connect_error);
}

$mesaj = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nume = trim($_POST["nume"] ?? "");
    $prenume = trim($_POST["prenume"] ?? "");
    $tara = trim($_POST["tara"] ?? "");

    if (!empty($nume) && !empty($prenume)) {
        $stmt = $conn->prepare("SELECT id_autor FROM autori WHERE nume_autor = ? AND prenume_autor = ?");
        $stmt->bind_param("ss", $nume, $prenume);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $mesaj = "<div class='alert alert-warning mt-3'>Autorul există deja în baza de date.</div>";
        } else {
            $stmt->close();
            $stmt = $conn->prepare("INSERT INTO autori (nume_autor, prenume_autor, tara_origine) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $nume, $prenume, $tara);

            if ($stmt->execute()) {
                $mesaj = "<div class='alert alert-success mt-3'>Autor adăugat cu succes!</div>";
            } else {
                $mesaj = "<div class='alert alert-danger mt-3'>Eroare la adăugare: " . $stmt->error . "</div>";
            }
        }

        $stmt->close();
    } else {
        $mesaj = "<div class='alert alert-warning mt-3'>Numele și prenumele sunt obligatorii.</div>";
    }
}
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Adaugă Autor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f3e8ff;
            font-family: 'Itim', cursive;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
        }

        h2 {
            color: #33186B;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-size: 18px;
            color: #33186B;
            text-align: left;
        }

        input {
            box-sizing: border-box;
            padding: 10px;
            width: 100%;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        button {
            margin-top: 25px;
            padding: 10px 20px;
            background-color: rgb(214, 182, 248);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 18px;
        }

        button:hover {
            background-color: #9d4edd;
        }

        .alert {
            font-size: 16px;
            color: #33186B;
        }

        .alert-warning {
            background-color: #33186B;
            color: #f3e8ff;
        }

        .alert-success {
            background-color: #4caf50;
            color: white;
        }

        .alert-danger {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>♡Adaugă un autor nou♡</h2>
    <form method="POST">
        <label>☆Nume:</label>
        <input type="text" name="nume" required>

        <label>☆Prenume:</label>
        <input type="text" name="prenume" required>

        <label>☆Țara de origine:</label>
        <input type="text" name="tara">

        <button type="submit">Adaugă Autor</button>
    </form>
    <?= $mesaj ?>
</div>

</body>
</html>