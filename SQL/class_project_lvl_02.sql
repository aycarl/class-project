-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2015 at 08:08 PM
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
CREATE DATABASE IF NOT EXISTS `class_project` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `class_project`;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
`notes_id` int(11) NOT NULL,
  `project` int(11) DEFAULT NULL,
  `member` int(11) DEFAULT NULL,
  `message` varchar(140) DEFAULT NULL,
  `tags` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`pr_id`, `title`, `description`, `file_01`, `file_02`, `date_created`) VALUES
(1, 'Competitive Strategy', 'Complete assignment 1 as a group (10 questions)', NULL, NULL, '2015-02-02 17:53:45'),
(2, 'Text and Meaning', ' present chapter 1 to the class on Tuesday', NULL, NULL, '2015-02-02 17:53:45'),
(3, 'Design', 'create a library experience for students of Adesua Ye', NULL, NULL, '2015-02-17 15:50:43'),
(4, 'Social Theory', 'Analyse the differences between the three waves of feminism (5 pages)', NULL, NULL, '2015-02-17 15:52:18'),
(33, 'Leadership IV team drama', 'create and act out a skit on a servant leader from Japan', NULL, NULL, '2015-04-13 09:20:33'),
(34, 'Leadership II team paper', 'Work with Kafui', NULL, NULL, '2015-04-13 10:10:49');

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
  `time_assigned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('incomplete','on-going','done') DEFAULT 'incomplete'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`t_id`, `message`, `deadline_day`, `deadline_time`, `assignee`, `project`, `time_assigned`, `status`) VALUES
(1, 'Create tables for roles', '2015-04-16', '10:54:00', 3, 3, '2015-04-13 04:16:47', 'incomplete'),
(2, 'help us', '2015-04-16', '00:59:00', 3, 4, '2015-04-13 04:20:48', 'incomplete'),
(3, 'Answer the first question', '2015-04-16', '00:59:00', 4, 1, '2015-04-13 05:03:31', 'incomplete'),
(4, 'Write the introduction to the paper', '2015-04-16', '00:20:00', 4, 34, '2015-04-13 10:12:04', 'incomplete');

-- --------------------------------------------------------

--
-- Table structure for table `team_project`
--

CREATE TABLE IF NOT EXISTS `team_project` (
`tp_id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `project` int(11) NOT NULL,
  `clearance` enum('owner','regular','Instructor') NOT NULL DEFAULT 'regular'
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team_project`
--

INSERT INTO `team_project` (`tp_id`, `member`, `project`, `clearance`) VALUES
(54, 1, 1, 'owner'),
(55, 1, 2, 'owner'),
(56, 1, 3, 'owner'),
(57, 1, 4, 'owner'),
(58, 3, 1, 'Instructor'),
(59, 2, 2, 'regular'),
(60, 2, 4, 'regular'),
(61, 4, 1, 'regular'),
(62, 5, 1, 'regular'),
(63, 3, 2, 'regular'),
(64, 2, 1, 'regular'),
(65, 6, 4, 'regular'),
(66, 7, 4, 'regular'),
(67, 4, 4, 'regular'),
(68, 7, 3, 'regular'),
(69, 3, 3, 'regular'),
(70, 3, 4, 'regular'),
(71, 1, 33, 'owner'),
(72, 1, 34, 'owner'),
(73, 4, 34, 'regular'),
(74, 5, 34, 'regular'),
(75, 6, 34, 'regular');

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
(1, 'Carl', 'Yao', 'carl.yao', 'carl', 'Admin User'),
(2, 'David', 'Kafui', 'david.kafui', 'student', 'Standard User'),
(3, 'Teacher', 'One', 'teacher.one', 'teacher', 'Instructor'),
(4, 'Student', 'One', 'student.one', 'student', 'Standard User'),
(5, 'Student', 'Two', 'student.two', 'student', 'Standard User'),
(6, 'Student', 'Three', 'student.three', 'student', 'Standard User'),
(7, 'Student', 'Four', 'student.four', 'student', 'Standard User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
 ADD PRIMARY KEY (`notes_id`), ADD KEY `project` (`project`), ADD KEY `member` (`member`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
 ADD PRIMARY KEY (`pr_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
 ADD PRIMARY KEY (`t_id`), ADD KEY `tasks_ibfk_2` (`project`), ADD KEY `assignee` (`assignee`);

--
-- Indexes for table `team_project`
--
ALTER TABLE `team_project`
 ADD PRIMARY KEY (`tp_id`), ADD KEY `member` (`member`), ADD KEY `team_project_ibfk_2_idx` (`project`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
MODIFY `notes_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `team_project`
--
ALTER TABLE `team_project`
MODIFY `tp_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`),
ADD CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`member`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`assignee`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`);

--
-- Constraints for table `team_project`
--
ALTER TABLE `team_project`
ADD CONSTRAINT `team_project_ibfk_1` FOREIGN KEY (`member`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `team_project_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`pr_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
