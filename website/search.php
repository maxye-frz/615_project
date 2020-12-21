<?php

// Open a database connection
include 'php/open.php';
// Load html 
include('header.html');
include('listings.html');
// Retrieve parameters
include('php/retrieve_param.php');
include('php/prepare_search_stmt.php');

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)

// Get total page number 
$page_result = $mysqli->query($total_pages_sql);
$total_rows = $page_result->fetch_row()[0];
$total_pages = ceil($total_rows / $no_of_records_per_page);
$mysqli->next_result();

$locations = [];

// Display neighborhood information
if ($mysqli->multi_query($covid_stmt)) {
    if ($covid_result = $mysqli->store_result()) {
        $row = $covid_result->fetch_row();
        $resident_population = $row[2];
        $covid_case = $row[3];
        $park_score = $row[7];
        echo "<div class=\"container\">
                <div class=\"row justify-content-center\">
                    <div class=\"col-lg-8\">
                        <h5 class=\"mbr-section-title mb-5 align-center mbr-fonts-style display-5\">
                            <strong>Neighborhood Information in $neighborhood</strong></h5>

                        <div class=\"countdown-cont align-center mb-5\" style=\"font-family:Arial\">
                            <div class=\"row\">
                                <div class=\"col\">
                                    <h6><strong>COVID Cases  </strong></h6> <h2 style=\"color:#3399ff\">$covid_case</h2>
                                </div>
                                <div class=\"col\">
                                    <h6><strong>Resident Population  </strong></h6> <h2 style=\"color:#3399ff\">$resident_population</h2>
                                </div>
                                <div class=\"col\">
                                    <h6><strong>Park Score  </strong></h6> <h2 style=\"color:#3399ff\">$park_score</h2>
                                </div>
                            </div>
                        </div>
                        <p class=\"mbr-text mb-5 align-center mbr-fonts-style display-7\"></p>
                    </div>
                </div>
            </div>";
        $mysqli->next_result();
    }
} else { // we've called a stored procedure that does not exist, or that database connection is broken
        printf("<br>Error: %s\n", $mysqli->error);
}


// Display listing items
if ($mysqli->multi_query($stmt)) {
    echo "<section class=\"team2 cid-sj23QabDy9\" xmlns=\"http://www.w3.org/1999/html\" id=\"team2-x\">";
    
    echo "<div class=\"container\">
        <form action=\"search.php\" method=\"POST\" class=\"justify-content-center\">
            <div class=\"row justify-content-center\">
                <label class=\"radio-container\">Price&nbsp&nbsp
                    <input type=\"radio\" value=\"price\" name=\"sortby\">
                    <span class=\"checkmark\"></span>
                </label>
                <label class=\"radio-container\">Review Number&nbsp&nbsp
                    <input type=\"radio\"  value=\"review\" name=\"sortby\">
                    <span class=\"checkmark\"></span>
                </label>
                <label class=\"radio-container\">Rating&nbsp&nbsp
                    <input type=\"radio\"  value=\"rating\" name=\"sortby\">
                    <span class=\"checkmark\"></span>
                </label>
            </div>
            
            <div class=\"row justify-content-center\">
                <button type=\"submit\" class=\"btn btn-danger \" >  Sort </button>
            </div>";
        echo "<input type=\"hidden\" name=\"neighborhood\" value=\"$neighborhood\">";
        echo "<input type=\"hidden\" name=\"room\" value=\"$room\">";
        echo "<input type=\"hidden\" name=\"accomodation\" value=\"$accomodation\">";
        echo "<input type=\"hidden\" name=\"bedroom\" value=\"$bedroom\">";
        echo "<input type=\"hidden\" name=\"bed\" value=\"$bed\">";
        echo "<input type=\"hidden\" name=\"price\" value=\"$price\">";
        echo "<input type=\"hidden\" name=\"search\" value=\"$search\">";
        echo "</form></div> <br>";
    // Check if a result was returned after the call
    do {
        if ($result = $mysqli->store_result()) { 
            $row = $result->fetch_row();

            if ($row[0] == 'No data is found.'){
                echo "<div class=\"container justify-content-center\"><h5  style=\"text-align:center\">Sorry, no listing found</h5></div>";
            }
            else {
                do {
                    $listing_id = $row[0];
                    $listing_url = $row[1];
                    $listing_name = $row[2];
                    $description = $row[3];
                    $neighborhood_overview = $row[4];
                    $picture_url = $row[5];
                    $host_id = $row[6];
                    $property_type = $row[7];
                    $amenities = $row[8];
                    $listing_price = $row[9];
                    $review_num = $row[10];
                    $review_scores_rating = $row[11];
                    $bath = $row[12];
                    $listing_lat = $row[13];
                    $listing_long = $row[14];
                    $location = [];
                    $location['lat'] = $listing_lat;
                    $location['long'] = $listing_long;
                    $location['name'] = $listing_name;
                    $locations[] = $location;
                    
                    echo "<div class=\"container\"  >
                              <div class=\"card\">
                                <div class=\"card-wrapper\">
                                    <div class=\"row align-items-center\">
                                        <div class=\"col-12 col-sm-3\">
                                            <div class=\"image-wrapper\">
                                                <img style=\"width:250px!important; height:250px!important\" src=" .$picture_url. "> 
                                            </div>
                                        </div>
                                        <div class=\"col-12 col-sm \">
                                            <div class=\"card-box\">
                                                <h5 class=\"card-title mbr-fonts-style m-0 display-5\">"
                                                    .$listing_name. 
                                                "</h5>

                                                <h6 class=\"mbr-fonts-style mb-3 display-4\">"
                                                    .$property_type. " in " .$neighborhood.
                                                "</h6>
                                                
                                                <hr>

                                                <p class=\"mbr-text mbr-fonts-style display-7\">"
                                                    .$bedroom. " bedroom, " .$bed. " bed, " .$bath. " <br></p>
                                                <div class=\"row display-7\">
                                                    <div class=\"col\">
                                                        <strong> Rating: ".$review_scores_rating." </strong>(" .$review_num. ")
                                                    </div>
                                                    <div class=\"card float-right col \">
                                                        <div class=\"row \">
                                                            <h5 class=\"mbr-fonts-style mb-0 display-5\">
                                                                <strong>$".$listing_price. "</strong>
                                                            </h5>/night
                                                        </div>
                                                        <div class=\"row mbr-section-btn\">
                                                            <a href=\"listing-specific.php?listingid=" .$listing_id. "\" class=\" btn btn-primary display-4\">Researve Now</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <bbr>";
                    
                    echo "</div>";
                } while($row = $result->fetch_row());
            }
            $result->close();
        } // end if 
    } while ($mysqli->more_results() && $mysqli->next_result());
} else { // we've called a stored procedure that does not exist, or that database connection is broken
        printf("<br>Error: %s\n", $mysqli->error);
}

include('pagination.html');
include('map.html');
echo "</section>";
include('footer.html');

// Close the connection created above by including 'open.php' at top of this file
mysqli_close($mysqli);

?>