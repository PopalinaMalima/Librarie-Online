<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "librarieonline";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Eroare la conectare: " . $conn->connect_error);
}

if (isset($_GET['id_carte'])) {
    $id_carte = intval($_GET['id_carte']);

    $sql = "SELECT c.*, a.nume_autor, e.nume_editura
            FROM carti c
            INNER JOIN autori a ON c.id_autor = a.id_autor
            INNER JOIN edituri e ON c.id_editura = e.id_editura
            WHERE c.id_carte = ?";
    
    if (!$stmt = $conn->prepare($sql)) {
        die("Eroare la pregătirea interogării: " . $conn->error);
    }

    $stmt->bind_param("i", $id_carte);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 0) {
        die("Cartea nu există.");
    }

    $carte = $result->fetch_assoc();

    $sql_autori = "SELECT id_autor, nume_autor FROM autori ORDER BY nume_autor ASC";
    $result_autori = $conn->query($sql_autori);
    $autori = [];
    if ($result_autori && $result_autori->num_rows > 0) {
        while ($row = $result_autori->fetch_assoc()) {
            $autori[] = $row;
        }
    }

    $sql_edituri = "SELECT id_editura, nume_editura FROM edituri ORDER BY nume_editura ASC";
    $result_edituri = $conn->query($sql_edituri);
    $edituri = [];
    if ($result_edituri && $result_edituri->num_rows > 0) {
        while ($row = $result_edituri->fetch_assoc()) {
            $edituri[] = $row;
        }
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $titlu = mysqli_real_escape_string($conn, $_POST['titlu']);
        $gen = mysqli_real_escape_string($conn, $_POST['gen']);
        $pret = floatval($_POST['pret']);
        $id_autor = intval($_POST['id_autor']);
        $id_editura = intval($_POST['id_editura']);

        $update_sql = "UPDATE carti SET titlu = ?, gen = ?, pret = ?, id_autor = ?, id_editura = ? WHERE id_carte = ?";
        if (!$stmt = $conn->prepare($update_sql)) {
            die("Eroare la pregătirea interogării de actualizare: " . $conn->error);
        }

        $stmt->bind_param("ssdiis", $titlu, $gen, $pret, $id_autor, $id_editura, $id_carte);

        if ($stmt->execute()) {
            echo "<div class='message success'>Cartea a fost actualizată cu succes!</div>";
        } else {
            echo "<div class='message error'>Eroare la actualizare: " . $stmt->error . "</div>";
        }
    }
} else {
    die("ID-ul cărții nu a fost furnizat.");
}

?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Actualizează Cartea</title>
    <style>
        body {
            background-color: #f3e8ff;
            font-family: 'Itim', cursive;
            display: flex;
            justify-content: center;
            align-items: center;
            height: auto;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
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

        input[type="text"], input[type="number"], select {
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

        .message {
            margin-top: 20px;
            font-size: 18px;
            color: #33186B;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
        }

        .message.error {
            color: red;
            background-color: #ffe0e0;
            border: 1px solid #ffaaaa;
        }

        .message.success {
            color: green;
            background-color: #e0ffe0;
            border: 1px solid #aaffaa;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Actualizează Cartea</h2>
        <form method="POST" action="">
            <div class="mb-3">
                <label for="titlu" class="form-label">☆Titlu:</label>
                <input type="text" class="form-control" id="titlu" name="titlu" value="<?php echo htmlspecialchars($carte['titlu']); ?>" required>
            </div>
            <div class="mb-3">
                <label for="gen" class="form-label">☆Gen:</label>
                <input type="text" class="form-control" id="gen" name="gen" value="<?php echo htmlspecialchars($carte['gen']); ?>" required>
            </div>
            <div class="mb-3">
                <label for="pret" class="form-label">☆Preț:</label>
                <input type="number" class="form-control" id="pret" name="pret" value="<?php echo htmlspecialchars($carte['pret']); ?>" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="id_autor" class="form-label">☆Autor:</label>
                <select class="form-control" id="id_autor" name="id_autor" required>
                    <option value="">-- Selectează autorul --</option>
                    <?php foreach ($autori as $autor): ?>
                        <option value="<?php echo $autor['id_autor']; ?>" <?php if ($autor['id_autor'] == $carte['id_autor']) echo 'selected'; ?>>
                            <?php echo htmlspecialchars($autor['nume_autor']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="mb-3">
                <label for="id_editura" class="form-label">☆Editura:</label>
                <select class="form-control" id="id_editura" name="id_editura" required>
                    <option value="">-- Selectează editura --</option>
                    <?php foreach ($edituri as $editura): ?>
                        <option value="<?php echo $editura['id_editura']; ?>" <?php if ($editura['id_editura'] == $carte['id_editura']) echo 'selected'; ?>>
                            <?php echo htmlspecialchars($editura['nume_editura']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Actualizează</button>
        </form>
    </div>
</body>
</html>

<?php
$conn->close();
?>
