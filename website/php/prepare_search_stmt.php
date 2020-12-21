<?php


$covid_stmt = "CALL NeighborhoodInfo('$neighborhood')";
// default search statement
$stmt = "CALL ListingSearchSortByReview('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
$total_pages_sql = "CALL CountListingSearch('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high')";

if ($sortby == '') {
    if (!isset($search) || empty($search)) { // no sorts
        $stmt = "CALL ListingSearch('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
        $total_pages_sql = "CALL CountListingSearch('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high')";
    } else {
        $stmt = "CALL WordListingSearch('$search', '$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
        $total_pages_sql = "CALL CountWordSearch('$search','$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high')";
    }

} else if ($sortby == 'price') { //  sort by price
    if (!isset($search) || empty($search)) {
        $stmt = "CALL ListingSearchSortByPrice('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    } else {
        $stmt = "CALL WordListingSearchSortByPrice('$search', '$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    }

} else if ($sortby == 'review') { // sort by review
     //sort by review
     if (!isset($search) || empty($search)) {
        $stmt = "CALL ListingSearchSortByReview('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    } else {
        $stmt = "CALL WordListingSearchSortByReview('$search', '$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    }

} else if ($sortby == 'rating') { //sort by rating 
    if (!isset($search) || empty($search)) {
        $stmt = "CALL ListingSearchSortByRating('$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    } else {
        $stmt = "CALL WordListingSearchSortByRating('$search', '$neighborhood', '$room', '$accomodation', '$bedroom', '$bed', '$price_low', '$price_high', '$offset', '$no_of_records_per_page')";
    }
}

?>