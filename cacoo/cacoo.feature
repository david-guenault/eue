# language: fr
Fonctionnalité: authentification cacoo
    Afin d'être en mesure d'utiliser cacoo
    je dois pouvoir m'authentifier

Scénario: Page d'accueil 
    Etant donné Que mon navigateur est lancé
    Quand Je saisi l'addresse "http://www.cacoo.com"
    Alors Je devrais voir "Sign in"

Scénario: authentification cacoo
    Etant donné Que je suis sur la page d'accueil du site "http://www.cacoo.com"
    Quand Je clique sur le lien "Sign in"
    Quand Je saisi "dguenault@monitoring-fr.org" dans le champ "name"
    Quand Je saisi "*****" dans le champ "password"
    Quand Je clique sur le bouton "Sign in"
    Alors Je devrais voir "Créer un schéma"

Scénario: Création d'un schéma
  Etant donné Que je suis authentifié sur le service cacoo
  Quand Je clique sur le lien dont l'identifiant est "create_new_illust"
  Alors Je devrais voir la fenêtre inspecteur

Scénario: Fermeture du schéma
  Etant donné Que je suis sur le nouveau schéma
  Quand je clique sur le bouton fermer
  Alors je ne devrais plus voir la fenêtre schéma
