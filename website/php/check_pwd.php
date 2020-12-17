<?php
        function checkAdminPwd($name, $pwd, $mysqli) {
            $stmt = Null;
            if (strlen($name) == 0) {
                $stmt = "SELECT 'Invalid admin name' AS 'Error Message'";
            } else if (strlen($pwd) == 0) {
                $stmt = "SELECT 'Invalid password' AS 'Error Message'";
            } else {
                $query = "SELECT * FROM Admin WHERE Admin.name = '$name' AND Admin.pwd = '$pwd'";
                if (!$mysqli->query($query)->fetch_row()[0]) {
                    $stmt = "SELECT 'Admin is not found or password is not correct' AS 'Error Message'";
                }
            }
            
        return $stmt;
        }
?>