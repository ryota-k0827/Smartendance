<?php
    $class_room_number = $_GET['class_room']; //swiftから送られてきた値
    $userId = $_GET['user_id'];
    $classes_id = $_GET['class_id'];

    $day_of_the_week = date('w');  //本日の曜日の番号（0〜6）のいずれかを格納
    //$day_of_the_week = 1; //テスト用
    $date = date('Y/m/d');
    $time = date('H:i:s');  //現在の時間を取得
    //$time = '11:15:00';  //テスト用

    //sql
    $link = mysqli_connect('mysql1.php.xdomain.ne.jp','ryotakaneko_1','ohs80538','ryotakaneko_smartendance');
    mysqli_set_charset($link,'utf8');
    $data = mysqli_query($link,"SELECT no,classes.class_symbol,time_id,class_times.start_time,class_times.end_time,subjects.subject,class_rooms.class_room,class_rooms.UUID 
                                FROM teaches 
                                INNER JOIN class_rooms 
                                ON teaches.class_room_id = class_rooms.id 
                                INNER JOIN subjects 
                                ON teaches.subject_id = subjects.id 
                                INNER JOIN class_times 
                                ON teaches.time_id = class_times.times 
                                INNER JOIN classes
                                ON teaches.classes_id = classes.id
                                WHERE day_of_the_week = ".$day_of_the_week." 
                                AND class_rooms.class_room = '".$class_room_number."' 
                                AND classes_id = ".$classes_id." 
                                AND '".$time."' <= class_times.end_time 
                                LIMIT 1");

    $record = mysqli_fetch_assoc($data);    //sqlから取り出した値を$recordに格納

    //現在時間で開講している授業があるか
    if($record != null){    //ある場合
        $no = $record['no'];
        $data_1 = mysqli_query($link,"SELECT no,student_number,attend_day
                                        FROM attend
                                        WHERE no = ".$no."
                                        AND student_number = ".$userId."
                                        AND attend_day = '".$date."'");

        $record_1 = mysqli_fetch_assoc($data_1);    //sqlから取り出した値を$record_1に格納
        
        if($record_1 == null){
            //出席確認
            if($time <= $record['start_time']){  //時間内に出席できた場合
                //現在の日時を取得
                $nowDate = date("Y/m/d H:i:s");
                $data = mysqli_query($link,"INSERT INTO attend (no,student_number,attend_day,attend_time) VALUES (".$no.", ".$userId.",'".$date."','".$time."',1);");
                $ary_data = array(
                    'classRoomNuber'=>$class_room_number,
                    'classSymbol'=>$record['class_symbol'],
                    'subject'=>$record['subject'],
                    'attendTime'=>$nowDate,
                    'resultMsg'=>"",
                    'status'=>"入室完了"
                );
                // 配列をjson_encode関数でJSON形式に変換します。
                echo json_encode($ary_data, JSON_UNESCAPED_UNICODE);
            }else{
                if($time <= date('H:i:s',strtotime($record['start_time'].'+15 minute'))){    //15分以内の遅刻で出席した場合
                    //現在の日時を取得
                    $nowDate = date("Y/m/d H:i:s");
                    $data = mysqli_query($link,"INSERT INTO attend (no,student_number,attend_day,attend_time) VALUES (".$no.", ".$userId.",'".$date."','".$time."',2);");
                    $attend_data = array(
                        'classRoomNuber'=>$class_room_number,
                        'classSymbol'=>$record['class_symbol'],
                        'subject'=>$record['subject'],
                        'attendTime'=>$nowDate,
                        'resultMsg'=>"（遅刻）",
                        'status'=>"入室完了"
                    );
                }else{  //15分よりも後に出席した場合
                    $nowDate = date("Y/m/d H:i:s");
                    $data = mysqli_query($link,"INSERT INTO attend (no,student_number,attend_day,attend_time,status) VALUES (".$no.", ".$userId.",'".$date."','".$time."',3);");
                    $attend_data = array(
                        'classRoomNuber'=>$class_room_number,
                        'classSymbol'=>$record['class_symbol'],
                        'subject'=>$record['subject'],
                        'attendTime'=>$nowDate,
                        'resultMsg'=>'（授業開始後15分が経過した為、欠席です。）',
                        'status'=>"入室完了"
                    );
                }
                // 配列をjson_encode関数でJSON形式に変換します。
                echo json_encode($attend_data, JSON_UNESCAPED_UNICODE);
            }
        }
    }
    mysqli_close($link);
?>