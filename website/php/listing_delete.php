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


$listing_id = $_POST['listing_id'];

$stmt = null;

if (!isset($listing_id) || empty($listing_id)) {
    echo '<script>';
    echo 'alert("Listing id can not be null.");';
    echo 'window.location.href = "../listing_delete.html";';
    echo '</script>';
} else {
    $stmt = "CALL DeleteListing('$listing_id')";
    if ($mysqli -> query($stmt)) {
        echo '<script>';
        echo 'alert("Delete listing data successful.");';
        echo 'window.location.href = "../data_panel.html";';
        echo '</script>';
    } else {
        echo '<script>';
        echo 'alert("Error: %s\n", $mysqli->error);';
        echo 'window.location.href = "../listing_delete.html";';
        echo '</script>';
    }
}

mysqli_close($mysqli);

 ?>
 </body>
