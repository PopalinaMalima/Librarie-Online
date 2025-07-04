<?php

$db_server = "127.0.0.1";
$db_user = "root";
$db_pass = "";
$db_name = "librarieonline";
$conn = "";

$conn = mysqli_connect(hostname: $db_server, username: $db_user, password: $db_pass, database: $db_name);

if($conn)
{
    echo "Merge!";
}else 
{
    echo "Nu merge! :(";
}

?>