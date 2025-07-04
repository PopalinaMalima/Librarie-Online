<?php
$host = "localhost";
$user = "root";
$pass = "";
$db = "librarieonline";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Eroare la conectare: " . $conn->connect_error);
}

if (isset($_GET['delete_id'])) {
    $delete_id = intval($_GET['delete_id']);
    $delete_sql = "DELETE FROM autori WHERE id_autor = ?";
    $stmt = $conn->prepare($delete_sql);
    $stmt->bind_param("i", $delete_id);

    if ($stmt->execute()) {
        echo "<div class='message success'>Autorul a fost șters cu succes!</div>";
    } else {
        echo "<div class='message error'>Eroare la ștergere: " . $stmt->error . "</div>";
    }

    $stmt->close();
}

$sql = "SELECT * FROM autori ORDER BY nume_autor ASC";
$result = $conn->query($sql);

if (!$result) {
    die("Eroare la interogarea bazei de date: " . $conn->error);
}
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Lista Autorilor</title>
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
            width: 80%;
            max-width: 900px;
        }

        h2 {
            color: #33186B;
            margin-bottom: 30px;
            text-align: center;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #d6b6f8;
            color: #33186B;
            font-weight: bold;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #e0e0e0;
        }

        .actions {
            display: flex;
            gap: 5px;
            justify-content: center;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .btn-danger {
            background-color: #ff6b6b;
            color: white;
        }

        .btn-danger:hover {
            background-color: #ff4f4f;
        }

        .btn-warning {
            background-color: #ffda6b;
            color: #33186B;
        }

        .btn-warning:hover {
            background-color: #ffc83d;
        }

        .message {
            margin-top: 20px;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 16px;
            color: #33186B;
            background-color: #e6dcfd;
            border: 1px solid #d6b6f8;
        }

        .message.error {
            color: #ff4f4f;
            background-color: #ffe2e2;
            border: 1px solid #ff6b6b;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Lista Autorilor</h2>
    <table class="table">
        <thead>
        <tr>
            <th>☆ID</th>
            <th>☆Nume</th>
            <th>☆Prenume</th>
            <th>☆Țara</th>
            <th>☆Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <?php while ($row = $result->fetch_assoc()) { ?>
            <tr>
                <td><?php echo $row['id_autor']; ?></td>
                <td><?php echo htmlspecialchars($row['nume_autor']); ?></td>
                <td><?php echo htmlspecialchars($row['prenume_autor']); ?></td>
                <td><?php echo htmlspecialchars($row['tara_origine']); ?></td>
                <td class="actions">
                    <a href="update_autori.php?id_autor=<?php echo $row['id_autor']; ?>" class="btn btn-warning btn-sm">Actualizează☆</a>
                    <a href="lista_autori.php?delete_id=<?php echo $row['id_autor']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Sigur vrei să ștergi acest autor?')">Șterge♡</a>
                </td>
            </tr>
        <?php } ?>
        </tbody>
    </table>
</div>
</body>
</html>

<?php
$conn->close();
?>