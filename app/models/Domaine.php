<?php
use Phalcon\Mvc\Model;
class Domaine extends Model {
	protected $id;
	protected $libelle;
	
	
	public function getId() {
		return $this->id;
	}
	public function setId($id) {
		$this->id = $id;
		return $this;
	}
	
	public function getLibelle() {
		return $this->libelle;
	}
	public function setLibelle($libelle) {
		$this->libelle = $libelle;
		return $this;
	}
	
		public function __toString() {
		return $this->getLibelle ();
	}
}