-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- ホスト: mysql1.php.xdomain.ne.jp
-- 生成時間: 2021 年 8 月 31 日 20:33
-- サーバのバージョン: 5.0.95
-- PHP のバージョン: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- データベース: `ryotakaneko_smartendance`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `attend`
--

CREATE TABLE IF NOT EXISTS `attend` (
  `no` int(11) NOT NULL COMMENT '科目No',
  `student_number` int(5) NOT NULL COMMENT '学籍番号',
  `attend_day` date NOT NULL COMMENT '出席日付',
  `attend_time` time NOT NULL COMMENT '出席時間',
  `status` int(1) NOT NULL COMMENT '1→出席,2→出席(遅刻),3→欠席',
  PRIMARY KEY  (`no`,`student_number`,`attend_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `attend`
--

INSERT INTO `attend` (`no`, `student_number`, `attend_day`, `attend_time`, `status`) VALUES
(2, 90000, '2021-08-28', '11:15:00', 1),
(9, 90000, '2021-08-31', '14:25:33', 3),
(10, 90000, '2021-06-26', '14:40:00', 1),
(10, 90000, '2021-08-31', '15:29:35', 3),
(10, 90001, '2021-08-31', '15:02:04', 3),
(10, 90003, '2021-08-31', '15:06:17', 3),
(11, 90000, '2021-06-26', '16:20:01', 1),
(13, 90000, '2021-07-14', '11:15:00', 1),
(28, 90000, '2021-06-25', '14:40:00', 1),
(28, 90000, '2021-07-16', '15:22:42', 3);

-- --------------------------------------------------------

--
-- テーブルの構造 `classes`
--

CREATE TABLE IF NOT EXISTS `classes` (
  `id` int(3) NOT NULL COMMENT 'id',
  `class_symbol` varchar(10) NOT NULL COMMENT 'クラス記号',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='クラス';

--
-- テーブルのデータをダンプしています `classes`
--

INSERT INTO `classes` (`id`, `class_symbol`) VALUES
(1, 'IH-13A-115'),
(2, 'IW-13A-120');

-- --------------------------------------------------------

--
-- テーブルの構造 `class_rooms`
--

CREATE TABLE IF NOT EXISTS `class_rooms` (
  `id` int(3) NOT NULL COMMENT 'id',
  `class_room` varchar(3) NOT NULL,
  `UUID` varchar(36) NOT NULL COMMENT 'UID',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教室';

--
-- テーブルのデータをダンプしています `class_rooms`
--

INSERT INTO `class_rooms` (`id`, `class_room`, `UUID`) VALUES
(1, '031', '11111111-1111-1111-1111-111111111111'),
(2, '032', '00000000-ABCD-1234-ABCD-012345678901'),
(3, '101', '22222222-2222-2222-2222-222222222222'),
(4, '191', '33333333-3333-3333-3333-333333333333');

-- --------------------------------------------------------

--
-- テーブルの構造 `class_times`
--

CREATE TABLE IF NOT EXISTS `class_times` (
  `times` int(1) NOT NULL COMMENT '時限',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY  (`times`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='授業時間帯';

--
-- テーブルのデータをダンプしています `class_times`
--

INSERT INTO `class_times` (`times`, `start_time`, `end_time`) VALUES
(1, '09:30:00', '11:00:00'),
(2, '11:15:00', '12:45:00'),
(3, '13:00:00', '14:30:00'),
(4, '14:40:00', '16:10:00'),
(5, '16:20:00', '17:50:00'),
(6, '18:00:00', '19:30:00');

-- --------------------------------------------------------

--
-- テーブルの構造 `day_of_the_weeks`
--

CREATE TABLE IF NOT EXISTS `day_of_the_weeks` (
  `id` int(1) NOT NULL COMMENT 'id',
  `day_of_the_week` char(1) NOT NULL COMMENT '曜日',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='曜日';

--
-- テーブルのデータをダンプしています `day_of_the_weeks`
--

INSERT INTO `day_of_the_weeks` (`id`, `day_of_the_week`) VALUES
(1, '月'),
(2, '火'),
(3, '水'),
(4, '木'),
(5, '金'),
(6, '土');

-- --------------------------------------------------------

--
-- テーブルの構造 `instructors`
--

CREATE TABLE IF NOT EXISTS `instructors` (
  `id` int(2) unsigned zerofill NOT NULL COMMENT 'id',
  `roma_name` varchar(20) NOT NULL COMMENT '名前（ローマ字）',
  `name` varchar(20) NOT NULL COMMENT '名前（日本語）',
  `password` varchar(10) NOT NULL COMMENT 'パスワード',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教官';

--
-- テーブルのデータをダンプしています `instructors`
--

INSERT INTO `instructors` (`id`, `roma_name`, `name`, `password`) VALUES
(06, 'kawashima.tom', '川島智弘', '1234'),
(15, 'kawata.hide', '河田英毅', '1234'),
(20, 'nagamine.hiro', '永峰弘万', '1234'),
(96, 'saito.shin', '齋藤新三', '1234'),
(97, 'yamamoto.yumi', '山本夕美子', '1234'),
(98, 'tanaka.shin', '田中信也', '1234'),
(99, 'yamada.tada', '山田忠明', '1234');

-- --------------------------------------------------------

--
-- テーブルの構造 `in_charge`
--

CREATE TABLE IF NOT EXISTS `in_charge` (
  `instructor_id` int(2) unsigned zerofill NOT NULL,
  `class_id` int(3) NOT NULL,
  PRIMARY KEY  (`instructor_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='担当';

--
-- テーブルのデータをダンプしています `in_charge`
--

INSERT INTO `in_charge` (`instructor_id`, `class_id`) VALUES
(15, 1),
(20, 2);

-- --------------------------------------------------------

--
-- テーブルの構造 `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `student_number` int(5) NOT NULL COMMENT '学籍番号',
  `classes_id` int(3) NOT NULL COMMENT '所属クラス',
  `attendance_number` int(2) unsigned zerofill NOT NULL COMMENT '出席番号',
  `name` varchar(20) NOT NULL COMMENT '名前',
  `password` varchar(10) NOT NULL COMMENT 'パスワード',
  PRIMARY KEY  (`student_number`),
  KEY `classes_id` (`classes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生';

--
-- テーブルのデータをダンプしています `students`
--

INSERT INTO `students` (`student_number`, `classes_id`, `attendance_number`, `name`, `password`) VALUES
(90000, 1, 10, '金丸航大', '0921'),
(90001, 1, 09, '金子凌大', '9999'),
(90002, 1, 11, 'HAL太郎', '1234'),
(90003, 1, 01, 'MODE花子', '1234');

-- --------------------------------------------------------

--
-- テーブルの構造 `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(3) NOT NULL COMMENT 'id',
  `subject` varchar(4) NOT NULL COMMENT '科目名',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='科目';

--
-- テーブルのデータをダンプしています `subjects`
--

INSERT INTO `subjects` (`id`, `subject`) VALUES
(1, 'JV32'),
(2, 'SK31'),
(3, 'IO31'),
(4, 'FX31'),
(5, 'IH31'),
(6, 'BT31'),
(7, 'NT32'),
(8, 'ST31'),
(9, 'FE3S');

-- --------------------------------------------------------

--
-- テーブルの構造 `teaches`
--

CREATE TABLE IF NOT EXISTS `teaches` (
  `no` int(11) NOT NULL,
  `day_of_the_week` int(1) NOT NULL COMMENT '曜日',
  `time_id` int(1) NOT NULL COMMENT '時限',
  `classes_id` int(3) NOT NULL COMMENT 'クラス記号',
  `subject_id` int(3) NOT NULL COMMENT '科目名',
  `instructor_id` int(2) unsigned zerofill NOT NULL COMMENT '教官名',
  `class_room_id` int(3) NOT NULL COMMENT '教室番号',
  PRIMARY KEY  (`no`),
  KEY `day_of_the_week` (`day_of_the_week`),
  KEY `time_id` (`time_id`),
  KEY `classes_id` (`classes_id`),
  KEY `subject_id` (`subject_id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `class_room_id` (`class_room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='授業';

--
-- テーブルのデータをダンプしています `teaches`
--

INSERT INTO `teaches` (`no`, `day_of_the_week`, `time_id`, `classes_id`, `subject_id`, `instructor_id`, `class_room_id`) VALUES
(1, 1, 1, 1, 2, 15, 1),
(2, 1, 2, 1, 1, 99, 1),
(3, 1, 3, 1, 1, 99, 1),
(4, 1, 4, 1, 3, 98, 1),
(5, 1, 5, 1, 5, 06, 1),
(6, 1, 6, 1, 4, 15, 1),
(7, 2, 1, 1, 2, 15, 1),
(8, 2, 2, 1, 3, 98, 1),
(9, 2, 3, 1, 4, 15, 1),
(10, 2, 4, 1, 5, 06, 1),
(11, 2, 5, 1, 5, 06, 1),
(12, 2, 6, 1, 6, 97, 2),
(13, 3, 1, 1, 5, 06, 3),
(14, 3, 2, 1, 5, 06, 3),
(15, 3, 3, 1, 1, 99, 1),
(16, 3, 4, 1, 1, 99, 1),
(17, 3, 5, 1, 7, 15, 4),
(18, 3, 6, 1, 7, 15, 4),
(19, 4, 1, 1, 5, 06, 1),
(20, 4, 2, 1, 5, 06, 1),
(21, 4, 3, 1, 9, 98, 3),
(22, 4, 4, 1, 6, 97, 2),
(23, 4, 5, 1, 7, 15, 4),
(24, 4, 6, 1, 7, 15, 4),
(25, 5, 1, 1, 6, 97, 2),
(26, 5, 2, 1, 8, 96, 1),
(27, 5, 3, 1, 8, 96, 1),
(28, 5, 4, 1, 9, 98, 3),
(29, 5, 5, 1, 7, 15, 4),
(30, 5, 6, 1, 7, 15, 1),
(31, 6, 1, 1, 2, 15, 1),
(32, 6, 2, 1, 6, 97, 2),
(33, 6, 3, 1, 1, 99, 1),
(34, 6, 4, 1, 1, 99, 1),
(35, 6, 5, 1, 5, 06, 1),
(36, 6, 6, 1, 5, 06, 1);

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `attend`
--
ALTER TABLE `attend`
  ADD CONSTRAINT `attend_ibfk_1` FOREIGN KEY (`no`) REFERENCES `teaches` (`no`) ON UPDATE CASCADE;

--
-- テーブルの制約 `in_charge`
--
ALTER TABLE `in_charge`
  ADD CONSTRAINT `in_charge_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`),
  ADD CONSTRAINT `in_charge_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- テーブルの制約 `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`);

--
-- テーブルの制約 `teaches`
--
ALTER TABLE `teaches`
  ADD CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`day_of_the_week`) REFERENCES `day_of_the_weeks` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`time_id`) REFERENCES `class_times` (`times`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_3` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_5` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `teaches_ibfk_6` FOREIGN KEY (`class_room_id`) REFERENCES `class_rooms` (`id`) ON UPDATE CASCADE;
