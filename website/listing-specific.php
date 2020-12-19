<?php
// Open a database connection
include 'php/open.php';
// Load html 
include('header.html');

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)


$listing_id = 0;
# retrieve listing_id from url parametter
if (isset($_GET['listingid'])) {
    $listing_id = $_GET['listingid'];
} else {
    echo 'Listing id not passed.';
}

$listing_stmt = "CALL FindListingByID('$listing_id')";
$review_stmt = "CALL FindReviewByListingID('$listing_id')";
$host_id = 1169;

// Call the select statement
if ($mysqli->multi_query($listing_stmt)) {

    // Check if a result was returned after the call
    if ($result = $mysqli->store_result()) {
        $row = $result->fetch_row();
        $listing_name = $row[0]; 
        $neighborhood = $row[1];
        $picture_url = $row[2];
        $description = $row[3];
        $amenities = explode(",", trim(trim($row[4], '['),']'));
        $host_id = $row[5];
        $neighborhood_overview = $row[6];
        $property_type = $row[7];
        $price = $row[8];
        $number_of_reviews = $row[9]; 
        $review_scores_rating = $row[10]; 
        $bathrooms_text = $row[11];
        echo "<section class=\"gallery5 mbr-gallery cid-sj24Fs6IYs\" id=\"gallery5-10\">
                <div class=\"container\">
                    <div class=\"mbr-section-head\">
                        <h3 class=\"mbr-section-title mbr-fonts-style align-center m-0 display-2\"><strong>".$listing_name."</strong></h3>
                        <h4 class=\"mbr-section-subtitle mbr-fonts-style align-center mb-0 mt-2 display-5\">".$neighborhood.", San Francisco</h4>
                        <h5 class=\"mbr-section-subtitle mbr-fonts-style align-center mb-0 mt-2 display-7\">$property_type, $bathrooms_text</h4>
                    </div>
                    <div class=\"row mbr-gallery mt-4  justify-content-center\">
                        <div class=\"col-12 col-md-6 col-lg-3 item gallery-image\">
                            <div class=\"item-wrapper\" data-toggle=\"modal\" data-target=\"#sj5i91bkh8-modal\">
                                <img class=\"w-100\" src=\"".$picture_url."\" data-slide-to=\"0\" data-target=\"#lb-sj5i91bkh8\">
                                <div class=\"icon-wrapper\">
                                    <span class=\"mobi-mbri mobi-mbri-search mbr-iconfont mbr-iconfont-btn\"></span>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- image -->
                    <div class=\"modal mbr-slider\" tabindex=\"-1\" role=\"dialog\" aria-hidden=\"true\" id=\"sj5i91bkh8-modal\">
                        <div class=\"modal-dialog\" role=\"document\">
                            <div class=\"modal-content\">
                                <div class=\"modal-body\">
                                    <div class=\"carousel slide\" id=\"lb-sj5i91bkh8\" data-interval=\"5000\">
                                        <div class=\"carousel-inner\">
                                            <div class=\"carousel-item active\">
                                                <img class=\"d-block w-100\" src=\"".$picture_url."\" alt=\"\"> <!-- change image -->
                                            </div>
                                        <a role=\"button\" href=\"\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class=\"content15 cid-sj25179nyF\" id=\"content15-14\">

                <!-- description -->
                <div class=\"container\">
                    <div class=\"row justify-content-center\">
                        <div class=\"card col-md-12 col-lg-10\">
                            <div class=\"card-wrapper\">
                                <div class=\"card-box align-left\">
                                    <h4 class=\"card-title mbr-fonts-style mbr-white mb-3 display-5\">
                                        <strong>Description</strong></h4>
                                    <p id=\"textArea\" class=\"mbr-text mbr-fonts-style display-7\">".$description."</p>
                                    <a style=\"color:black\" id=\"toggleButton\"  href=\"javascript:void(0);\">(Show More)</a>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class=\"content8 cid-sj24HxkczS\" id=\"content8-11\">
                
                <div class=\"container\">
                    <div class=\"row justify-content-center\">
                        <div class=\"counter-container col-md-12 col-lg-10\">
                            
                            <div class=\"mbr-text mbr-fonts-style display-7\">
                                <ul>
                                    <li><strong> ".trim($amenities[0],"\""). " provided </strong></li>
                                    <li><strong> ".trim($amenities[1],"\""). " provided </strong></li>
                                    <li><strong> ".trim($amenities[2],"\""). " provided </strong></li>

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>";
        $mysqli->next_result();
        $result->close();
    }
} else {
        printf("<br>Error: %s\n", $mysqli->error);
}

// display host info
$host_stmt = "CALL FindHostByID('1169')";   
if ($result = $mysqli->query($host_stmt)) {
    $row = $result->fetch_row();
    $host_id = $row[0];
    $host_name = $row[1];
    $host_since = $row[2]; 
    $host_about = $row[3];
    $host_picture_url = $row[4];
    $host_neighbourhood = $row[5];

    echo "<section class=\"testimonails3 carousel slide testimonials-slider cid-sj259aZNn2\" data-interval=\"false\" id=\"testimonials3-15\">
            <div class=\"text-center container\">
                <h3 class=\"mb-4 mbr-fonts-style display-2\"><strong>Host</strong></h3>

                <div class=\"carousel slide\" role=\"listbox\" data-pause=\"true\" data-keyboard=\"false\" data-ride=\"carousel\" data-interval=\"5000\">

                    <div class=\"carousel-inner\">
                        <div class=\"col-md-12 offset-md-2 \">
                            <div class=\"user col-md-8\">
                                <div class=\"user_image\">
                                    <img src=\"".$host_picture_url."\"> 
                                </div>
                                <div class=\"user_text mb-4\">
                                    <p class=\"mbr-fonts-style display-7\"> 
                                        ".$host_about."
                                    </p>
                                </div>
                                <div class=\"user_name mbr-fonts-style mb-2 display-7\">
                                    <strong>".$host_name."</strong> 
                                </div>
                                <div class=\"user_desk mbr-fonts-style display-7\"> 
                                    ".$host_since." 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>";
    $mysqli->next_result();
    $result->close();
} else {

        printf("<br>Error: %s\n", $mysqli->error);
}

// display review info
if ($mysqli->multi_query($review_stmt)) {
    echo "<section class=\"content14 cid-sj24IOsbjW\" id=\"content14-12\">
                            <div class=\"container\">
                                <div class=\"row justify-content-center\">
                                    <div class=\"col-md-12 col-lg-10\">
                                            <h3 class=\"mbr-section-title mbr-fonts-style mb-4 display-5\">
                                                <strong>Reviews</strong></h3>
                                        <ul class=\"list mbr-fonts-style display-7\">";
    do {
        if ($result = $mysqli->store_result()) { 
            $row = $result->fetch_row();
            do {   
                    $row = $result->fetch_row();
                    $date = $row[0];
                    $comments = $row[1];
                    $name = $row[2]; 
                    echo "<li><strong>$name, $date: </strong>$comments<br></li>";
            } while($row = $result->fetch_row());
            $result->close();
        } // end if 
    } while ($mysqli->more_results() && $mysqli->next_result());
    echo "</ul></div></div></div></section>";
} else {

        printf("<br>Error: %s\n", $mysqli->error);
}
include('map.html');
include('footer.html');
// Close the connection created above by including 'open.php' at top of this file
mysqli_close($mysqli);
?>