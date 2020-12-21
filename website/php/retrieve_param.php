<?php

// Pagenation
if (isset($_GET['pageno'])) {
    $pageno = $_GET['pageno'];
} else {
    $pageno = 1;
}

// Retrieve search details
if (isset($_GET['neighborhood'])){
    $neighborhood = $_GET['neighborhood'];
} else {
    $neighborhood = $_POST['neighborhood'];
}

if (isset($_GET['room'])){
    $room = $_GET['room'];
} else {
    $room = $_POST['room'];
}

if (isset($_GET['accomodation'])){
    $accomodation = $_GET['accomodation'];
} else {
    $accomodation = $_POST['accomodation'];
}

if (isset($_GET['bedroom'])){
    $bedroom = $_GET['bedroom'];
} else {
    $bedroom = $_POST['bedroom'];
}

if (isset($_GET['bed'])){
    $bed = $_GET['bed'];
} else {
    $bed = $_POST['bed'];
}

if (isset($_POST['price'])){
    $price = $_POST['price'];
} else {
    $price = $_GET['price'];
}

if (isset($_GET['price_low'])){
    $price_low = $_GET['price_low'];
}

if (isset($_GET['price_high'])){
    $price_high = $_GET['price_high'];
}
 
if (isset($_GET['search'])){
    $search = $_GET['search'];
} else {
    $search = $_POST['search'];
}

if (isset($_GET['sortby'])){
    $sortby = $_GET['sortby'];
} else if (isset($_POST['sortby'])) {
    $sortby = $_POST['sortby'];
} else {
    $sortby = '';
}

$no_of_records_per_page = 10;
$offset = ($pageno - 1) * $no_of_records_per_page;


# regularize price
$price_low = 100;
$price_high = 200;

if ($price == '$0 ~ 100') {
    $price_low = 0;
    $price_high = 100;
} else {
    $price_low = substr($price, 1, 3);
    $price_high = substr($price, 7, 3);
}

?>