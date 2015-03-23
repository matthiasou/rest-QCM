<?php

use Ovide\Libs\Mvc\Rest\App;

require __DIR__.'/../vendor/autoload.php';


$loader = new \Phalcon\Loader();
//Register dirs
$loader->registerDirs(
		array(
			"./../app/controllers",
			"./../app/models"
		)
)->register();
//Create app
$app = App::instance();
//Set up the database service
$app->di->set('db', function(){
	return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
			"host" => "localhost",
			"username" => "root",
			"password" => "",
			"dbname" => "rest-qcm",
			"options" => array(
					PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
			)
	));
});

$app->di->setShared('session', function() {
	$session = new Phalcon\Session\Adapter\Files();
	$session->start();
	return $session;
});
$app->addResources([Domaines::class]);
$app->addResources([Groupes::class]);
$app->addResources([GroupeUtilisateurs::class]);
$app->addResources([Questionnaires::class]);
$app->addResources([Questions::class]);
$app->addResources([Rangs::class]);
$app->addResources([Realisations::class]);
$app->addResources([ReponseUtilisateurs::class]);
$app->addResources([Reponses::class]);
$app->addResources([Utilisateurs::class]);

$app->get("/user/check/{login}/{password}", array(new UsersController(),"checkConnectionAction"));
$app->get("/user/check", array(new UsersController(),"checkConnectedAction"));
$app->post("/user/add", array(new UsersController(),"userAddAction"));
$app->post("/user/connect", array(new UsersController(),"connectAction"));
$app->get("/user/disconnect", array(new UsersController(),"disconnectAction"));
$app->get("/user/exists", array(new UsersController(),"checkUserExistsAction"));

$app->handle();