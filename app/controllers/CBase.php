<?php
use Ovide\Libs\Mvc\Rest\Controller;
use Ovide\Libs\Mvc\Rest\Exception\NotFound;
use Ovide\Libs\Mvc\Rest\Exception\Unauthorized;
use Ovide\Libs\Mvc\Rest\Exception\Conflict;
abstract class CBase extends MainRestController{
	protected $modelclass;
	
	
	protected function _getModelName(){
		return $this->modelclass;
	}
	
	//getAll
	public function get(){
		$modelclass = $this->modelclass;
		$models= $modelclass::find();
		$models=$models->toArray();
		if(sizeof($models)==0)
			throw new NotFound("Aucun {$this->_getModelName()} trouv�");
		return $models;
	}
	
	//getOne
	public function getOne($id){
		$modelclass = $this->modelclass;
		if (!$monde = $modelclass::findFirst($id))
			throw new NotFound("Ooops! Le {$this->_getModelName()} {$id} est introuvable");
		return $monde->toArray();
	}
	
	//add
	public function post($obj){
		$modelclass = $this->modelclass;
		if($this->_isValidToken($this->request->get("token"),$this->request->get("force"))){
			$monde = new $modelclass();
			$obj["created_at"]=(new DateTime())->format('Y-m-d H:i:s');
			$obj["updated_at"]=(new DateTime())->format('Y-m-d H:i:s');
			if($monde->create($obj)==false){
				throw new Conflict("Impossible d'ajouter '".$obj["name"]."' dans la base de données.");
			}else{
				return array("data"=>$monde->toArray(),"message"=>$this->successMessage("'".$monde."' a été correctement ajoutée dans les {$this->_getModelName()}."));
			}
		}else{
			throw new Unauthorized("Vous n'avez pas les droits pour ajouter un {$this->_getModelName()}");
		}
	}
	
	protected abstract function setObject($model, $obj);
	
	
	//update
	public function put($id, $obj){

		$modelclass = $this->modelclass;
	
		if($this->_isValidToken($this->request->get("token"),$this->request->get("force"))){
	
			$model = $modelclass::findFirst($id);
				
			if(!$model){
				throw new NotFound("Mise à jour : '".$obj["name"]."' n'existe plus dans la base de données.");
				return array();
			}else{
			
				$this->setObject($model, $obj);
				try{
					$model->save();
					return array("data"=>$obj,"message"=>$this->successMessage("L'objet a été correctement modifiée."));
				}
				catch(Exception $e){
					throw new Conflict("Impossible de modifier '".$obj["name"]."' dans la base de données.<br>".$e->getMessage());
				}
			}
		}else{
			throw new Unauthorized("Vous n'avez pas les droits pour modifier un objet");
		}
	}
	
	//delete
	public function delete($id){
		$modelclass = $this->modelclass;
		if($this->_isValidToken($this->request->get("token"),$this->request->get("force"))){
			$model = $modelclass::findFirst($id);
			if(!$model){
				return array("message"=>$this->warningMessage("Mise à jour : La brasserie n'existe plus dans la base de données."),"code"=>Response::UNAVAILABLE);
			}else{
				try{
					$model->delete();
					return array("data"=>$model,"message"=>$this->successMessage("L'objet a été correctement supprimée de l'ensemble des brasseries."));
				}
				catch(Exception $e){
					throw new Conflict("Impossible de supprimer l'objet dans la base de données.<br>".$e->getMessage());
				}
			}
		}else{
			throw new Unauthorized("Vous n'avez pas les droits pour supprimer une brasserie");
		}
	}
	
	
	
}