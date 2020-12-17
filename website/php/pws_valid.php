<head>
  <title>password validating</title>
 </head>
 <body>
 <?php



// Open a database connection
include 'open.php';
include 'check_pwd.php';

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)


$name = $_POST['name'];
$pwd = $_POST['pwd'];

// Check the name and password
$stmt = checkAdminPwd($name, $pwd, $mysqli);
if (is_null($stmt)){
    echo "<p>Login successful.</p>";
}

// Close the connection created above by including 'open.php' at top of this file
mysqli_close($mysqli);


 ?>
 </body>
