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
$listing_url = $_POST['listing_url'];
$name = $_POST['name'];
$description = $_POST['description'];
$neighborhood_overview = $_POST['neighborhood_overview'];
$picture_url = $_POST['picture_url'];
$host_id = $_POST['host_id'];
$neighbourhood = $_POST['neighbourhood'];
$neighbourhood_cleansed = $_POST['neighbourhood_cleansed'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$property_type = $_POST['property_type'];
$room_type = $_POST['room_type'];
$accommodates = $_POST['accommodates'];
$bathrooms_text = $_POST['bathrooms_text'];
$bedrooms = $_POST['bedrooms'];
$beds = $_POST['beds'];
$amenities = $_POST['amenities'];
$price = $_POST['price'];
$minimum_nights = $_POST['minimum_nights'];
$maximum_nights = $_POST['maximum_nights'];
$availability_365 = $_POST['availability_365'];
$number_of_reviews = $_POST['number_of_reviews'];
$first_review = $_POST['first_review'];
$last_review = $_POST['last_review'];
$review_scores_rating = $_POST['review_scores_rating'];
$review_scores_accuracy = $_POST['review_scores_accuracy'];
$review_scores_cleanliness = $_POST['review_scores_cleanliness'];
$review_scores_checkin = $_POST['review_scores_checkin'];
$review_scores_communication = $_POST['review_scores_communication'];
$review_scores_location = $_POST['review_scores_location'];
$review_scores_value = $_POST['review_scores_value'];
$instant_bookable = $_POST['instant_bookable'];
$calculated_host_listings_count = $_POST['calculated_host_listings_count'];
$calculated_host_listings_count_entire_homes = $_POST['calculated_host_listings_count_entire_homes'];
$calculated_host_listings_count_private_rooms = $_POST['calculated_host_listings_count_private_rooms'];
$calculated_host_listings_count_shared_rooms = $_POST['calculated_host_listings_count_shared_rooms'];
$reviews_per_month = $_POST['reviews_per_month'];


$notNull = array($listing_id, $listing_url, $name, $description, $neighborhood_overview, $picture_url, $host_id,
                $neighbourhood, $neighbourhood_cleansed, $latitude, $longitude, $property_type, $room_type, $accommodates,
                $bathrooms_text, $bedrooms, $beds, $amenities, $price, $minimum_nights, $maximum_nights, $availability_365,
                $number_of_reviews, $first_review, $last_review, $review_scores_rating, $review_scores_accuracy, 
                $review_scores_cleanliness, $review_scores_checkin, $review_scores_communication, $review_scores_location, 
                $review_scores_value, $instant_bookable, $calculated_host_listings_count, $calculated_host_listings_count_entire_homes, 
                $calculated_host_listings_count_private_rooms, $calculated_host_listings_count_shared_rooms, $reviews_per_month);
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

function checkHost($id, $connection) {
    $stmt = Null;
    $query = "SELECT * FROM Listing WHERE Listing.host_id = '$id'"; 
    if (!isset($connection->query($query)->fetch_row()[0])) {
        $stmt = "SELECT 'Host does not exist' AS 'Error Message'";
    }
    return $stmt;
}

$stmt = checkHost($host_id, $mysqli);

if (!is_null($stmt)){
    echo '<script>';
    echo 'alert("This host does not exist. Must enter an existing host id.");';
    echo 'window.location.href = "../listing_data.html";';
    echo '</script>';
} else {
    if (checkNotNull($notNull)) {
        $stmt = "CALL UpdateListing('$listing_id', '$listing_url', '$name', '$description', '$neighborhood_overview', '$picture_url', '$host_id',
                                    '$neighbourhood', '$neighbourhood_cleansed', '$latitude', '$longitude', '$property_type', '$room_type', '$accommodates',
                                    '$bathrooms_text', '$bedrooms', '$beds', '$amenities', '$price', '$minimum_nights', '$maximum_nights', '$availability_365',
                                    '$number_of_reviews', '$first_review', '$last_review', '$review_scores_rating', '$review_scores_accuracy', 
                                    '$review_scores_cleanliness', '$review_scores_checkin', '$review_scores_communication', '$review_scores_location', 
                                    '$review_scores_value', '$instant_bookable', '$calculated_host_listings_count', '$calculated_host_listings_count_entire_homes', 
                                    '$calculated_host_listings_count_private_rooms', '$calculated_host_listings_count_shared_rooms', '$reviews_per_month')";
        echo 'before';
        if ($mysqli -> query($stmt)) {
            echo 'after';
            echo '<script>';
            echo 'alert("Change listing data successful.");';
            echo 'window.location.href = "../data_panel.html";';
            echo '</script>';
        } else {
            echo '<script>';
            echo 'alert("Database error");';
            echo 'window.location.href = "../listing_data.html";';
            echo '</script>';
        }
    } else {
        echo '<script>';
        echo 'alert("Some fields can not be null.");';
        echo 'window.location.href = "../listing_data.html";';
        echo '</script>';
    }
}

mysqli_close($mysqli);

 ?>
 </body>
