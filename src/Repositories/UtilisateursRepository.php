<?php

namespace src\Repositories;

use src\Models\Database;
use src\Models\Utilisateurs;

class UtilisateursRepository
{
    private $pdo;
    public function __construct()
    {
        $db = new Database();
        $this->pdo = $db->getPDO();
    }

    public function create(User $user)
    {
        try{
            $sql = "INSERT INTO" . PREFIXE . "utilisateurs (ID, NOMFAMILLE, PRENOM, MAIL, MDP, COMPTE ACTIVE, ID) VALUES (null, :NOMFAMILLE, :PRENOM, :MAIL, :MDP, :COMPTEACTIVE, null)";
        
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([
                ':NOMFAMILLE' => $user->getNOMFAMILLE(),
                ':PRENOM' => $user->getPRENOM(),
                ':MAIL' => $user->getMAIL(),
                ':MDP' => $user->getMDP(),
                ':COMPTEACTIVE' => $user->getCOMPTEACTIVE()
            ]);
        } catch (\PDOException $e) {
            throw new \Exception("Une erreur est survenue lors de l'enregistrement de l'utilisateur : " . $e->getMessage());
        }
    }

    public function findbyEmail($mail): user|bool{
        try{
            $sql = "SELECT * FROM ". PREFIXE . "utilisateurs WHERE MAIL = :MAIL";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([':MAIL'=> $mail]);

            $stmt->setFetchMode(\PDO::FETCH_CLASS, Utilisateurs::class);

            return $stmt->fetch();
        } catch (\PDOException $e) {
            throw new \Exception('Erreur de récupération d\'un utilisateur par son email : '.$e->getMessage());

        }
        }
    }
