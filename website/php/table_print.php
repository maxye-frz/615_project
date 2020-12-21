<?php

    function outputResultsTableHeader($result) {
        $fields = $result->fetch_fields();
        echo "<tr>";
        foreach ($fields as $field) {
          echo "<th> $field->name </th>";
        }
        echo "</tr>\n";
    }

    function outputResultsTableRow($result) {
        $row = $result->fetch_row();
        do {
            echo "<tr>";
            for($i = 0; $i < sizeof($row); $i++){
                echo "<td>" . $row[$i] . "</td>";
            }
            echo "</tr>";
        } while($row = $result->fetch_row());
    }
?>