<?php
    $link = mysqli_connect('mysql1.php.xdomain.ne.jp','ryotakaneko_1','ohs80538','ryotakaneko_smartendance');
    mysqli_set_charset($link,'utf8');
    $data = mysqli_query($link,"SELECT * FROM teaches");
    mysqli_close($link);

    $record = [];
    while($row = mysqli_fetch_assoc($data)){
        $record[] = $row;
    }

    var_dump($record);
