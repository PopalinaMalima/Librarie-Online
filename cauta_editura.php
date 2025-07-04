<?php
$conn = mysqli_connect("127.0.0.1", "root", "", "librarieonline");

if (!$conn) {
    die("Conexiune eșuată: " . mysqli_connect_error());
}

if (isset($_GET['query'])) {
    $query = mysqli_real_escape_string($conn, $_GET['query']);
    
    $sql = "SELECT id_editura, nume_editura, oras, tara 
            FROM edituri 
            WHERE nume_editura LIKE '%$query%' 
            OR oras LIKE '%$query%' 
            OR tara LIKE '%$query%' 
            LIMIT 10";
    
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            echo "<div class='editura-item' data-id='" . $row['id_editura'] . "'>";
            echo htmlspecialchars($row['nume_editura']) . " - " . htmlspecialchars($row['oras']) . " (" . htmlspecialchars($row['tara']) . ")";
            echo "</div>";
        }
    } else {
        echo "<div class='editura-item no-suggestions'>Nicio editura găsită</div>";
    }
}

mysqli_close($conn);
?>