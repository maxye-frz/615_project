<head>
  <title>password validating</title>
 </head>
 <body>
 <?php



// Open a database connection
include 'open.php';
include 'table_print.php';

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)


$name = $_POST['name'];
$pwd = $_POST['pwd'];

function checkAdminPwd($name, $pwd, $mysqli) {
    $stmt = Null;
    if (strlen($name) == 0) {
        $stmt = "SELECT 'Missing admin name' AS 'Error Message'";
    } else if (strlen($pwd) == 0) {
        $stmt = "SELECT 'Missing password' AS 'Error Message'";
    } else {
        $query = "SELECT * FROM Admin WHERE Admin.name = '$name' AND Admin.pwd = '$pwd'";
        
        if (!isset($mysqli->query($query)->fetch_row()[0])) {
            $stmt = "SELECT 'Admin is not found or password is not correct' AS 'Error Message'";
        }
    }
    
    return $stmt;
}

// Check the name and password
$stmt = checkAdminPwd($name, $pwd, $mysqli);
if (is_null($stmt)){
    echo '<script>';
    echo 'alert("Login successful. Directing you to next page.");';
    echo 'window.location.href = "../admin_panel.html";';
    echo '</script>';
} else {
    echo '<script>';
    echo 'alert("Login failed. Directing you to previous page.");';
    echo 'window.location.href = "../login.html";';
    echo '</script>';
}

// Call the select statement
if ($mysqli->multi_query($stmt)) {

    // Check if a result was returned after the call
    do {
        if ($result = $mysqli->store_result()) {
            echo "<table border=\"1px solid black\">";

            // Output appropriate table header row
            outputResultsTableHeader($result);
        
            // Output each row of resulting relation
            outputResultsTableRow($result);
        

            echo "</table><br>";
            $result->close();
        }
    } while ($mysqli->more_results() && $mysqli->next_result());

}
// Close the connection created above by including 'open.php' at top of this file
mysqli_close($mysqli);


 ?>
 </body>
