<head>
  <title>host</title>
 </head>
 <body>
 <?php



// Open a database connection
include 'open.php';
include 'table_print.php';

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)


$host_id = $_POST['host_id'];

$stmt = null;

if (!isset($host_id) || empty($host_id)) {
    echo '<script>';
    echo 'alert("Host id can not be null.");';
    echo 'window.location.href = "../host_delete.html";';
    echo '</script>';
} else {
    $stmt = "CALL DeleteHost('$host_id')";
    if ($mysqli -> query($stmt)) {
        echo '<script>';
        echo 'alert("Delete host data successful.");';
        echo 'window.location.href = "../data_panel.html";';
        echo '</script>';
    } else {
        echo '<script>';
        echo 'alert("Host not exists");';
        echo 'window.location.href = "../host_delete.html";';
        echo '</script>';
    }
}

mysqli_close($mysqli);

 ?>
 </body>
