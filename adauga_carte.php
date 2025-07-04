<?php
$conn = mysqli_connect("127.0.0.1", "root", "", "librarieonline");

if (!$conn) {
    die("Conexiune eșuată: " . mysqli_connect_error());
}

$mesaj = "";

$sql_edituri = "SELECT id_editura, nume_editura FROM edituri ORDER BY nume_editura ASC";
$result_edituri = mysqli_query($conn, $sql_edituri);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $titlu = mysqli_real_escape_string($conn, $_POST['titlu']);
    $gen = mysqli_real_escape_string($conn, $_POST['gen']);
    $pret = floatval($_POST['pret']);
    $id_autor = intval($_POST['id_autor']);
    $id_editura = intval($_POST['id_editura']);

    $check_sql = "SELECT * FROM carti WHERE titlu = '$titlu' AND id_autor = $id_autor";
    $check_result = mysqli_query($conn, $check_sql);

    if (mysqli_num_rows($check_result) > 0) {
        $mesaj = "Această carte există deja!";
    } else {
        $insert_sql = "INSERT INTO carti (titlu, gen, pret, id_autor, id_editura)
                        VALUES ('$titlu', '$gen', $pret, $id_autor, $id_editura)";
        if (mysqli_query($conn, $insert_sql)) {
            $mesaj = "Cartea a fost adăugată cu succes!";
        } else {
            $mesaj = "Eroare: " . mysqli_error($conn);
        }
    }
}
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Adaugă carte</title>
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
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
            position: relative;
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

        input, select {
            box-sizing: border-box;
            padding: 10px;
            width: 100%;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        .suggestions, .editura-suggestions {
            max-height: 90px;
            max-width: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-top: none;
            position: absolute;
            background-color: #fff;
            width: 100%;
            z-index: 999;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;     
        }

        .suggestion-item, .editura-item {
            padding: 6px 10px;
            cursor: pointer;
            font-size: 14px;
            color: #33186B;
        }

        .suggestion-item:hover, .editura-item:hover {
            background-color: #e0e0e0;
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
        }

        a {
            font-size: 14px;
            display: block;
            margin-top: 8px;
            color: #5e548e;
            text-decoration: none;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#author-input").keyup(function () {
                var query = $(this).val();
                if (query.length > 2) {
                    $.ajax({
                        url: "cauta_autori.php",
                        method: "GET",
                        data: {query: query},
                        success: function (data) {
                            $(".suggestions").html(data).show();
                        }
                    });
                } else {
                    $(".suggestions").hide();
                }
            });

            $("#editura-input").keyup(function () {
                var query = $(this).val();
                if (query.length > 2) {
                    $.ajax({
                        url: "cauta_editura.php",
                        method: "GET",
                        data: {query: query},
                        success: function (data) {
                            $(".editura-suggestions").html(data).show();
                        }
                    });
                } else {
                    $(".editura-suggestions").hide();
                }
            });

            $(document).on("click", ".suggestion-item", function () {
                var autorId = $(this).data("id");
                var autorText = $(this).text();
                $("#author-input").val(autorText);
                $("#author-id").val(autorId);
                $(".suggestions").hide();
            });

            $(document).on("click", ".editura-item", function () {
                var edituraId = $(this).data("id");
                var edituraText = $(this).text();
                $("#editura-input").val(edituraText);
                $("#editura-id").val(edituraId);
                $(".editura-suggestions").hide();
            });

            $("#author-input, #editura-input").blur(function () {
                setTimeout(() => {
                    $(".suggestions, .editura-suggestions").hide();
                }, 200);
            });
        });
    </script>
</head>
<body>
<div class="form-container">
    <h2>♡Adaugă carte♡</h2>
    <form method="POST">
        <label>☆Titlu:</label>
        <input type="text" name="titlu" required>

        <label>☆Gen:</label>
        <input type="text" name="gen" required>

        <label>☆Preț:</label>
        <input type="number" step="0.01" name="pret" required>

        <label>☆Autor:</label>
        <input type="text" id="author-input" placeholder="Caută autorul..." autocomplete="off" required>
        <input type="hidden" name="id_autor" id="author-id">
        <div class="suggestions"></div>
        <a href="adauga_autor.php">Adaugă autor nou</a>

        <label>☆Editura:</label>
        <input type="text" id="editura-input" placeholder="Caută editura..." autocomplete="off" required>
        <input type="hidden" name="id_editura" id="editura-id">
        <div class="editura-suggestions"></div>

        <button type="submit">Adaugă♡</button>
    </form>

    <?php if (!empty($mesaj)) echo "<div class='message'>$mesaj</div>"; ?>
</div>
</body>
</html>
