<?php

namespace src\Controllers;

use src\Models\Utilisateurs;
use src\Repositories\UtilisateursRepository;
use src\Services\Response;
use src\Services\Securite;

class ConnexionController
{
    use Response;
    use Securite;




public static function doConnexion()
{
    $data = !empty($_POST) ? self::sanitize($_POST) : self::sanitize(json_decode(file_get_contents("php://input")));

    $user = new User($data);

    if(
        $user->getMail()&&
       
        isset($data['password']) && isset($data['password2']) &&
        $data['password'] ===$data['password2'] &&

        filter_var($user->getMail(), FILTER_VALIDATE_EMAIL)
    ){
        $userRepo = new UtilisateursRepository;
        $userExistant = $UserRepo->findbyEmail($user->getMail());
        if (!$userExistant){
            $user->setPassword(password_hash($data['password'], PASSWORD_DEFAULT));

            $userRepo = new UtilisateursRepository;
            $userRepo->create($user);
            return true;
        } else{
            return ['echec' => "Email déjà utilisé, veuillez vous connecter."]; 
        }
        }
    }

    public static function auth() {
        if (isset($_POST['mail']) && isset ($_POST['password'])){
            $UserRepo = new UserRepository;

            $user = $UserRepo->findbyEmail($_POST['mail']);

        if ($user && password_verify($_POST['password'], $user->getPassword())){
            $_SESSION['connecté'] = true;
            $_SESSION['user'] = serialize($user);

            header('location: '.HOME_URL.'dashboard');
            exit;
        }else{
            header('location: '.HOME_URL.'connexion?erreur=denied');
        }
        }
    }
 public static function logout() {
    session_destroy();
    header('location: '.HOME_URL.'connexion');
  }

  public static function dashboard() {
    self::render('dashboard', [], 302);
  }
}