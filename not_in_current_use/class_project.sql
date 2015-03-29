-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2015 at 04:51 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `class_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
`pr_id` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `file_01` varchar(100) DEFAULT NULL,
  `file_02` varchar(100) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`pr_id`, `title`, `description`, `file_01`, `file_02`, `date_created`) VALUES
(1, 'Competitive Strategy', 'Complete assignment 1 as a group (10 questions)', NULL, NULL, '2015-02-02 17:53:45'),
(2, 'Text and Meaning', ' present chapter 1 to the class on Tuesday', NULL, NULL, '2015-02-02 17:53:45'),
(3, 'Design', 'create a library experience for students of Adesua Ye', NULL, NULL, '2015-02-17 15:50:43'),
(4, 'Social Theory', 'Analyse the differences between the three waves of feminism (5 pages)', NULL, NULL, '2015-02-17 15:52:18'),
(23, 'lk', 'get it real', NULL, NULL, '2015-03-11 12:29:39'),
(24, 'lk', 'you better run', NULL, NULL, '2015-03-11 12:32:45'),
(25, 'lk', 'you better run', NULL, NULL, '2015-03-11 12:34:03'),
(26, 'lk', 'llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll', NULL, NULL, '2015-03-11 12:44:58'),
(27, 'lk', 'llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllmmmmm', NULL, NULL, '2015-03-11 12:45:53'),
(28, 'lk', 'llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllmmmmm', NULL, NULL, '2015-03-14 01:06:20');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
`t_id` int(11) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `deadline_day` date DEFAULT NULL,
  `deadline_time` time DEFAULT NULL,
  `assignee` int(11) DEFAULT NULL,
  `project` int(11) DEFAULT NULL,
  `time_assigned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `team_project`
--

CREATE TABLE IF NOT EXISTS `team_project` (
`tp_id` int(11) NOT NULL,
  `member` int(11) DEFAULT NULL,
  `project` int(11) DEFAULT NULL,
  `clearance` enum('owner','regular','Instructor') DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team_project`
--

INSERT INTO `team_project` (`tp_id`, `member`, `project`, `clearance`) VALUES
(1, 1, 1, 'owner'),
(2, 1, 2, 'owner'),
(3, 1, 3, 'owner'),
(4, 1, 4, 'owner'),
(5, 3, 1, 'Instructor'),
(6, 2, 2, 'regular'),
(7, 2, 4, 'regular'),
(13, 4, 1, 'regular'),
(14, 5, 1, 'regular'),
(15, 3, 2, 'regular'),
(16, 2, 1, 'regular'),
(37, 6, 4, 'regular'),
(38, 7, 4, 'regular'),
(39, 4, 4, 'regular');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`user_id` int(11) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `pass_key` varchar(40) DEFAULT NULL,
  `authority` enum('Admin User','Standard User','Instructor') DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `user_name`, `pass_key`, `authority`) VALUES
(1, 'Carl', 'Yao', 'carl.yao', 'de187642e6c75f60d10f29e52cab54cdf676870d', 'Admin User'),
(2, 'David', 'Kafui', 'david.kafui', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Standard User'),
(3, 'Teacher', 'One', 'teacher.one', '5db3005d1c92d3def956044087157bb23f29c6b0', 'Instructor'),
(4, 'Student', 'One', 'student.one', '204036a1ef6e7360e536300ea78c6aeb4a9333dd', 'Standard User'),
(5, 'Student', 'Two', 'student.two', '204036a1ef6e7360e536300ea78c6aeb4a9333dd', 'Standard User'),
(6, 'Student', 'Three', 'student.three', '204036a1ef6e7360e536300ea78c6aeb4a9333dd', 'Standard User'),
(7, 'Student', 'Four', 'student.four', '204036a1ef6e7360e536300ea78c6aeb4a9333dd', 'Standard User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
 ADD PRIMARY KEY (`pr_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
 ADD PRIMARY KEY (`t_id`), ADD KEY `assignee` (`assignee`), ADD KEY `project` (`project`);

--
-- Indexes for table `team_project`
--
ALTER TABLE `team_project`
 ADD PRIMARY KEY (`tp_id`), ADD KEY `member` (`member`), ADD KEY `project` (`project`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team_project`
--
ALTER TABLE `team_project`
MODIFY `tp_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`assignee`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`project`) REFERENCES `team_project` (`tp_id`);

--
-- Constraints for table `team_project`
--
ALTER TABLE `team_project`
ADD CONSTRAINT `team_project_ibfk_1` FOREIGN KEY (`member`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `team_project_ibfk_2` FOREIGN KEY (`project`) REFERENCES `team_project` (`tp_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
