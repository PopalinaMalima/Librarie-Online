<?php
// Conectare la baza de date
$conn = mysqli_connect("127.0.0.1", "root", "", "librarieonline");

if (!$conn) {
    die("Conexiune eșuată: " . mysqli_connect_error());
}

if (isset($_GET['query'])) {
    $query = mysqli_real_escape_string($conn, $_GET['query']);

    $sql = "SELECT id_autor, nume_autor, prenume_autor FROM autori
            WHERE nume_autor LIKE ? OR prenume_autor LIKE ?
            ORDER BY nume_autor ASC";

    $stmt = mysqli_prepare($conn, $sql);
    $searchTerm = "%" . $query . "%";
    mysqli_stmt_bind_param($stmt, 'ss', $searchTerm, $searchTerm);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            echo '<div class="suggestion-item" data-id="' . $row['id_autor'] . '">' . htmlspecialchars($row['nume_autor'] . ' ' . $row['prenume_autor']) . '</div>';
        }
    } else {
        echo '<div class="suggestion-item">Niciun autor găsit</div>';
    }

    mysqli_stmt_close($stmt);
}

mysqli_close($conn);
?>