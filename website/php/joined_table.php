<head>
  <title>Show Listing Table</title>
  <style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  margin-left:auto;
  margin-right:auto;
}
</style>    
 </head>
 <body>
 <?php


// Open a database connection
// The call below relies on files named open.php and dbase-conf.php
// It initializes a variable named $mysqli, which we use below
include 'open.php';
include 'table_print.php';

// Configure error reporting settings
ini_set('error_reporting', E_ALL); // report errors of all types
ini_set('display_errors', true);   // report errors to screen (don't hide from user)


$stmt = 'CALL AllAnalysis';



if ($mysqli->multi_query($stmt)) {
    
    do {
        if ($result = $mysqli->store_result()) {
            echo "<table>";

            // Output appropriate table header row
            outputResultsTableHeader($result);

            // Output each row of resulting relation
            outputResultsTableRow($result);

            echo "</table><br>";
            $result->close();
        }
    } while ($mysqli->more_results() && $mysqli->next_result());

// The "multi_query" call did not end successfully, so report the error
// This might indicate we've called a stored procedure that does not exist,
// or that database connection is broken
} else {
    printf("<br>Error: %s\n", $mysqli->error);
}

// Close the connection created above by including 'open.php' at top of this file
mysqli_close($mysqli);


 ?>
 </body>