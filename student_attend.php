<?php
    //swiftの出席ボタンが押された時
    if(isset($_POST['attend'])){
        $class_room_number = $_POST['class_room']; //swiftから送られてきた値
        $userId = 90000;
        $classes_id = 1;

        $day_of_the_week = date('w');  //本日の曜日の番号（0〜6）のいずれかを格納
        $date = date('Y/m/d');
        $time = date('H:i:s');  //現在の時間を取得
        
        //sql
        $link = mysqli_connect('localhost','root','','smartendance');
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
                    $data = mysqli_query($link,"INSERT INTO attend (no,student_number,attend_day,attend_time) VALUES (".$no.", ".$userId.",'".$date."','".$time."');");
                    $nowDate = date("Y/m/d H:i");
                    $ary_data = array(
                        'classRoomNuber'=>$class_room_number,
                        'classSymbol'=>$record['class_symbol'],
                        'subject'=>$record['subject'],
                        'attendTime'=>$nowDate,
                        'UUID'=>$record['UUID']
                    );
                    // 配列をjson_encode関数でJSON形式に変換します。
                    echo json_encode($ary_data, JSON_UNESCAPED_UNICODE);
                }else{
                    if($time <= date('H:i:s',strtotime($record['start_time'].'+15 minute'))){    //15分以内の遅刻で出席した場合
                        //現在の日時を取得
                        $nowDate = date("Y/m/d H:i:s");
                        $data = mysqli_query($link,"INSERT INTO attend (no,student_number,attend_day,attend_time) VALUES (".$no.", ".$userId.",'".$date."','".$time."');");
                        $nowDate = date("Y/m/d H:i");
                        $attend_data = array(
                            'classRoomNuber'=>$class_room_number,
                            'classSymbol'=>$record['class_symbol'],
                            'subject'=>$record['subject'],
                            'attendTime'=>$nowDate,
                            'UUID'=>$record['UUID']
                        );
                    }else{  //15分よりも後に出席した場合
                        $nowDate = date("Y/m/d H:i");
                        $attend_data = array(
                            'classRoomNuber'=>$class_room_number,
                            'classSymbol'=>$record['class_symbol'],
                            'subject'=>$record['subject'],
                            'attendTime'=>$nowDate,
                            'UUID'=>$record['UUID']
                        );
                    }
                    // 配列をjson_encode関数でJSON形式に変換します。
                    echo json_encode($attend_data, JSON_UNESCAPED_UNICODE);
                }
            }else{
                echo 'この授業の出席はすでにされています。';
                $resultMsg = array(
                    'resultMsg'=>'この授業の出席はすでにされています。'
                );
                echo json_encode($resultMsg, JSON_UNESCAPED_UNICODE);
            }
        }else{  //ない場合
            echo '現在、この教室で開講している授業はありません。';
            $resultMsg = array(
                'resultMsg'=>'現在、この教室で開講している授業はありません。'
            );
            echo json_encode($resultMsg, JSON_UNESCAPED_UNICODE);
        }
        mysqli_close($link);
    }
    
    require_once './tpl/student_attend.php';