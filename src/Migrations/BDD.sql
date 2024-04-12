#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: aga_promotion
#------------------------------------------------------------

CREATE TABLE aga_promotion(
        id_promotion Int  Auto_increment  NOT NULL ,
        Nom          Varchar (50) NOT NULL ,
        Debut        Datetime NOT NULL ,
        Fin          Datetime NOT NULL ,
        Places       Int NOT NULL
	,CONSTRAINT aga_promotion_PK PRIMARY KEY (id_promotion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aga_cours
#------------------------------------------------------------

CREATE TABLE aga_cours(
        id_cours   Int  Auto_increment  NOT NULL ,
        Debut      Datetime NOT NULL ,
        Fin        Datetime NOT NULL ,
        Code_cours Varchar (255) NOT NULL
	,CONSTRAINT aga_cours_PK PRIMARY KEY (id_cours)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aga_role
#------------------------------------------------------------

CREATE TABLE aga_role(
        id_role Int  Auto_increment  NOT NULL ,
        Nom     Varchar (50) NOT NULL
	,CONSTRAINT aga_role_PK PRIMARY KEY (id_role)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aga_utilisateurs
#------------------------------------------------------------

CREATE TABLE aga_utilisateurs(
        id_utilisateur Int  Auto_increment  NOT NULL ,
        Nomfamille     Varchar (50) NOT NULL ,
        Prenom         Varchar (50) NOT NULL ,
        Mail           Varchar (255) NOT NULL ,
        Mdp            Varchar (255) NOT NULL ,
        Compte_active  Bool NOT NULL ,
        id_role        Int NOT NULL
	,CONSTRAINT aga_utilisateurs_PK PRIMARY KEY (id_utilisateur)

	,CONSTRAINT aga_utilisateurs_aga_role_FK FOREIGN KEY (id_role) REFERENCES aga_role(id_role)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aga_est
#------------------------------------------------------------

CREATE TABLE aga_est(
        id_cours       Int NOT NULL ,
        id_utilisateur Int NOT NULL ,
        en_retard      Bool NOT NULL ,
        absent         Bool NOT NULL
	,CONSTRAINT aga_est_PK PRIMARY KEY (id_cours,id_utilisateur)

	,CONSTRAINT aga_est_aga_cours_FK FOREIGN KEY (id_cours) REFERENCES aga_cours(id_cours)
	,CONSTRAINT aga_est_aga_utilisateurs0_FK FOREIGN KEY (id_utilisateur) REFERENCES aga_utilisateurs(id_utilisateur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aga_appartient
#------------------------------------------------------------

CREATE TABLE aga_appartient(
        id_utilisateur Int NOT NULL ,
        id_promotion   Int NOT NULL
	,CONSTRAINT aga_appartient_PK PRIMARY KEY (id_utilisateur,id_promotion)

	,CONSTRAINT aga_appartient_aga_utilisateurs_FK FOREIGN KEY (id_utilisateur) REFERENCES aga_utilisateurs(id_utilisateur)
	,CONSTRAINT aga_appartient_aga_promotion0_FK FOREIGN KEY (id_promotion) REFERENCES aga_promotion(id_promotion)
)ENGINE=InnoDB;

