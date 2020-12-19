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
$host_url = $_POST['host_url'];
$host_name = $_POST['host_name'];
$host_since = $_POST['host_since'];
$host_location = $_POST['host_location'];
$host_about = $_POST['host_about'];
$host_response_time = $_POST['host_response_time'];
$host_response_rate = $_POST['host_response_rate'];
$host_response_acceptance_rate = $_POST['host_acceptance_rate'];
$host_is_super_host = $_POST['host_is_superhost'];
$host_thumbnail_url = $_POST['host_thumbnail_url'];
$host_picture_url = $_POST['host_picture_url'];
$host_neighbourhood = $_POST['host_neighbourhood'];
$host_listings_count = $_POST['host_listings_count'];
$host_listings_total_listings_count = $_POST['host_total_listings_count'];
$host_verifications = $_POST['host_verifications'];
$host_has_profile_pic = $_POST['host_has_profile_pic'];
$host_identity_verified = $_POST['host_identity_verified'];

$notNull = array($host_id, $host_url, $host_name, $host_since, $host_location, $host_is_super_host, $host_thumbnail_url, $host_picture_url, $host_neighbourhood, $host_listings_count, $host_listings_total_listings_count, $host_verifications, $host_has_profile_pic, $host_identity_verified);
$stmt = null;

// check if the required not null input fields has null values.
function checkNotNull($array) {
    foreach($array as $v) {
        if(!isset($v) || empty($v)) {
           return false;
        }
     }
    return true;
}

if (checkNotNull($notNull)) {
    $stmt = "CALL UpdateHost('$host_id', '$host_url', '$host_name', '$host_since', '$host_location', 
                            '$host_about', '$host_response_time', '$host_response_rate', '$host_response_acceptance_rate', 
                            '$host_is_super_host', '$host_thumbnail_url', '$host_picture_url', '$host_neighbourhood', 
                            '$host_listings_count', '$host_listings_total_listings_count', '$host_verifications', 
                            '$host_has_profile_pic', '$host_identity_verified')";
    if ($mysqli -> query($stmt)) {
        echo '<script>';
        echo 'alert("Change host data successful.");';
        echo 'window.location.href = "../data_panel.html";';
        echo '</script>';
    } else {
        echo '<script>';
        echo 'alert("Error: %s\n", $mysqli->error);';
        echo 'window.location.href = "../host_data.html";';
        echo '</script>';
    }
} else {
    echo '<script>';
    echo 'alert("Some fields can not be null.");';
    echo 'window.location.href = "../host_data.html";';
    echo '</script>';
}

mysqli_close($mysqli);

 ?>
 </body>
