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
    Quand Je saisi "******" dans le champ "password"
    Quand Je clique sur le bouton "Sign in"
    Alors Je devrais voir "Créer un schéma"

Scénario: Création d'un schéma
  Etant donné Que je suis authentifié sur le service cacoo
  Quand Je clique sur le lien dont l'identifiant est "create_new_illust"
  Alors Je devrais voir la fenêtre inspecteur

Scénario: Fermeture du schéma
  Etant donné Que je suis sur le nouveau schéma
  Quand Je clique sur le bouton fermer
  Alors Je ne devrais plus voir la fenêtre schéma

Scénario: Liste des schémas
  Etant donné Que je suis sur la liste des schémas
  Quand Je clique sur le lien "Créés par moi"
  Alors Je devrais voir "Untitled"

Scénario: Ouvrir le schéma untitled
  Etant donné Que je suis authentifié sur le service cacoo
  Quand Je clique sur le lien "Untitled"
  Alors Je devrais voir "Untitled"

Scénario: Mettre le schéma untitled à la corbeille
  Etant donné Que je suis sur la page de gestion du schéma "Untitled"
  Quand Je clique sur le lien "Actions sur le schéma"
  Quand Je clique sur le lien "Déplacer vers la corbeille"  
  Alors Je ne devrais pas voir "Untitled"

Scénario: Aller dans la corbeille
  Etant donné Que je suis sur la page de détail du schéma "Untitled"
  Quand Je clique sur le lien "Corbeille"
  Alors Je devrais voir "Vider la corbeille"

Scénario: Vider la corbeille
  Etant donné Que je suis authentifié sur le service cacoo
  Quand Je clique sur le lien "Vider la corbeille"
  Quand Je clique sur le bouton "Valider" du popup javascript
  Alors Je ne devrais pas voir "Untitled"
