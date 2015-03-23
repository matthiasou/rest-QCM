-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 12 Mars 2015 à 11:37
-- Version du serveur :  5.6.21
-- Version de PHP :  5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `rest-qcm`
--

-- --------------------------------------------------------

--
-- Structure de la table `domaine`
--

CREATE TABLE IF NOT EXISTS `domaine` (
`id` int(11) NOT NULL,
  `libelle` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `domaine`
--

INSERT INTO `domaine` (`id`, `libelle`) VALUES
(4, 'Programmation'),
(5, 'Reseau');

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE IF NOT EXISTS `groupe` (
`id` int(11) NOT NULL,
  `libelle` varchar(250) NOT NULL,
  `code` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `groupe`
--

INSERT INTO `groupe` (`id`, `libelle`, `code`) VALUES
(3, 'sio.slam', 'slam'),
(4, 'sio.sisr', 'sisr');

-- --------------------------------------------------------

--
-- Structure de la table `groupe_utilisateur`
--

CREATE TABLE IF NOT EXISTS `groupe_utilisateur` (
  `utilisateur_id` int(11) NOT NULL,
  `groupe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `groupe_utilisateur`
--

INSERT INTO `groupe_utilisateur` (`utilisateur_id`, `groupe_id`) VALUES
(3, 3),
(4, 3),
(5, 4),
(6, 4);

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
`id` int(11) NOT NULL,
  `libelle` text NOT NULL,
  `questionnaire_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `question`
--

INSERT INTO `question` (`id`, `libelle`, `questionnaire_id`) VALUES
(1, 'a quoi sert ngDblclick ?', 3),
(2, 'a quoi sert ngCloak ?', 3),
(3, 'Qu’est-ce qu’est Phalcon ?', 4),
(4, 'Quelle est le langage de Phalcon ?', 4);

-- --------------------------------------------------------

--
-- Structure de la table `questionnaire`
--

CREATE TABLE IF NOT EXISTS `questionnaire` (
`id` int(11) NOT NULL,
  `libelle` text NOT NULL,
  `domaine_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `questionnaire`
--

INSERT INTO `questionnaire` (`id`, `libelle`, `domaine_id`, `date`) VALUES
(3, 'angularJS', 4, '2015-03-12'),
(4, 'Phalcon', 4, '2015-03-12');

-- --------------------------------------------------------

--
-- Structure de la table `rang`
--

CREATE TABLE IF NOT EXISTS `rang` (
`id` int(11) NOT NULL,
  `libelle` varchar(250) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `rang`
--

INSERT INTO `rang` (`id`, `libelle`) VALUES
(1, 'admin'),
(2, 'utilisateur');

-- --------------------------------------------------------

--
-- Structure de la table `realisation`
--

CREATE TABLE IF NOT EXISTS `realisation` (
`id` int(11) NOT NULL,
  `utilisateur_id` int(11) NOT NULL,
  `questionnaire_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `realisation`
--

INSERT INTO `realisation` (`id`, `utilisateur_id`, `questionnaire_id`, `score`, `date`) VALUES
(1, 3, 3, 1, '2015-03-12'),
(2, 4, 4, 1, '2015-03-12'),
(3, 5, 3, 2, '2015-03-12'),
(4, 6, 4, 0, '2015-03-12');

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE IF NOT EXISTS `reponse` (
`id` int(11) NOT NULL,
  `libelle` text NOT NULL,
  `question_id` int(11) NOT NULL,
  `good` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `reponse`
--

INSERT INTO `reponse` (`id`, `libelle`, `question_id`, `good`) VALUES
(1, 'double click', 1, 1),
(2, 'click gauche', 1, 0),
(3, 'click droit', 1, 0),
(4, 'click milieu', 1, 0),
(5, 'Masquer les  {{ }} lors du chargement', 2, 1),
(6, 'Masquer les  {{ }} partout', 2, 0),
(7, 'Masquer les  [[ ]] lors du chargement', 2, 0),
(8, 'Masquer les  [[ ]] partout', 2, 0),
(9, 'Phalcon est un framework', 3, 1),
(10, 'Phalcon est un module', 3, 0),
(11, 'Phalcon est une librairie', 3, 0),
(12, 'Phalcon est une ressource java', 3, 0),
(13, 'PHP', 4, 1),
(14, 'JAVA', 4, 0),
(15, 'C++', 4, 0),
(16, 'python', 4, 0);

-- --------------------------------------------------------

--
-- Structure de la table `reponse_utilisateur`
--

CREATE TABLE IF NOT EXISTS `reponse_utilisateur` (
  `reponse_id` int(11) NOT NULL,
  `realisation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `reponse_utilisateur`
--

INSERT INTO `reponse_utilisateur` (`reponse_id`, `realisation_id`) VALUES
(1, 1),
(7, 1),
(9, 2),
(14, 2),
(1, 3),
(5, 3),
(12, 4),
(16, 4);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
`id` int(11) NOT NULL,
  `mail` varchar(150) NOT NULL,
  `password` varchar(60) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `rang_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `mail`, `password`, `nom`, `prenom`, `rang_id`) VALUES
(3, 'jcouture', '123456', 'couture', 'julien', 1),
(4, 'gtostain', '123456', 'tostain', 'guillaume', 1),
(5, 'tportois', '123456', 'portois', 'théo', 1),
(6, 'utilisateur', '123456', 'nom1', 'prenom1', 2);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `domaine`
--
ALTER TABLE `domaine`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
 ADD PRIMARY KEY (`id`,`libelle`);

--
-- Index pour la table `groupe_utilisateur`
--
ALTER TABLE `groupe_utilisateur`
 ADD PRIMARY KEY (`utilisateur_id`,`groupe_id`), ADD KEY `fk_utilisateur_has_groupe_groupe1_idx` (`groupe_id`), ADD KEY `fk_utilisateur_has_groupe_utilisateur1_idx` (`utilisateur_id`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_question_questionnaire1_idx` (`questionnaire_id`);

--
-- Index pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_questionnaire_domaine1_idx` (`domaine_id`);

--
-- Index pour la table `rang`
--
ALTER TABLE `rang`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `realisation`
--
ALTER TABLE `realisation`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_score_utilisateur1_idx` (`utilisateur_id`), ADD KEY `fk_score_questionnaire1_idx` (`questionnaire_id`);

--
-- Index pour la table `reponse`
--
ALTER TABLE `reponse`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_reponse_question_idx` (`question_id`);

--
-- Index pour la table `reponse_utilisateur`
--
ALTER TABLE `reponse_utilisateur`
 ADD PRIMARY KEY (`reponse_id`,`realisation_id`), ADD KEY `fk_reponse_has_realisation_realisation1_idx` (`realisation_id`), ADD KEY `fk_reponse_has_realisation_reponse1_idx` (`reponse_id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_utilisateur_rang1_idx` (`rang_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `domaine`
--
ALTER TABLE `domaine`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `rang`
--
ALTER TABLE `rang`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `realisation`
--
ALTER TABLE `realisation`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `reponse`
--
ALTER TABLE `reponse`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `groupe_utilisateur`
--
ALTER TABLE `groupe_utilisateur`
ADD CONSTRAINT `fk_utilisateur_has_groupe_groupe1` FOREIGN KEY (`groupe_id`) REFERENCES `groupe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_utilisateur_has_groupe_utilisateur1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
ADD CONSTRAINT `fk_question_questionnaire1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
ADD CONSTRAINT `fk_questionnaire_domaine1` FOREIGN KEY (`domaine_id`) REFERENCES `domaine` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `realisation`
--
ALTER TABLE `realisation`
ADD CONSTRAINT `fk_score_questionnaire1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_score_utilisateur1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `reponse`
--
ALTER TABLE `reponse`
ADD CONSTRAINT `fk_reponse_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `reponse_utilisateur`
--
ALTER TABLE `reponse_utilisateur`
ADD CONSTRAINT `fk_reponse_has_realisation_realisation1` FOREIGN KEY (`realisation_id`) REFERENCES `realisation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_reponse_has_realisation_reponse1` FOREIGN KEY (`reponse_id`) REFERENCES `reponse` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
ADD CONSTRAINT `fk_utilisateur_rang1` FOREIGN KEY (`rang_id`) REFERENCES `rang` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
