```
praktikak_aurkitu/
├── praktikak_aurkitu.xcodeproj/  # Fichier de projet Xcode
├── praktikak_aurkitu/            # Dossier principal de l'application
│   ├── AppDelegate.swift         # Gère le cycle de vie de l'application.
│   ├── SceneDelegate.swift       # Gère les scènes de l'application et configure la fenêtre principale avec UINavigationController.
│   ├── Assets.xcassets/          # Contient les ressources graphiques (icônes, images, etc.), y compris le logo de l'application.
│   ├── Base.lproj/               # Fichiers de localisation de base
│   │   └── Main.storyboard       # Fichier Storyboard principal pour la conception de l'interface utilisateur.
│   ├── Models/
│   │   ├── JobOffer.swift        # Classe de base pour une offre d'emploi générique.
│   │   ├── ApprentissageOffer.swift # Modèle spécifique pour les offres de l'API Apprentissage.
│   │   ├── FranceTravailOffer.swift # Modèle spécifique pour les offres de l'API France Travail.
│   │   └── SearchFilters.swift   # Classe pour stocker les critères de recherche.
│   ├── Services/
│   │   ├── APIManager.swift      # Gère les requêtes HTTP génériques et le parsing JSON.
│   │   ├── ApprentissageAPIService.swift # Service dédié à l'interaction avec l'API Apprentissage.
│   │   ├── FranceTravailAPIService.swift # Service dédié à l'interaction avec l'API France Travail.
│   │   └── JobService.swift      # Agrège les résultats des différentes APIs et gère la logique métier.
│   ├── Utilities/
│   │   ├── Constants.swift       # Contient les constantes de l'application (URLs d'API, clés d'API, etc.).
│   │   ├── ErrorHandling.swift   # Définit les erreurs personnalisées de l'application.
│   │   ├── RateLimiter.swift     # Gère la limitation de débit pour les appels API.
│   │   └── FavoritesManager.swift # Gère la sauvegarde et la récupération des offres favorites.
│   ├── ViewControllers/
│   │   ├── HomeViewController.swift # Écran d'accueil de l'application.
│   │   ├── SearchViewController.swift # Écran de recherche avec barre de recherche et filtres.
│   │   ├── SearchResultsViewController.swift # Affiche la liste des offres d'emploi trouvées.
│   │   └── JobDetailViewController.swift # Affiche les détails d'une offre d'emploi spécifique.
│   └── Views/
│       └── JobOfferCell.swift    # Cellule personnalisée pour afficher une offre d'emploi dans la liste.
└── README.md                     # Fichier README du projet.
```

**Rôle de chaque fichier :**

*   **AppDelegate.swift** : Point d'entrée principal de l'application, gère les événements au niveau de l'application.
*   **SceneDelegate.swift** : Configure la fenêtre principale de l'application et initialise la navigation avec un `UINavigationController` et le `HomeViewController` comme vue racine.
*   **Assets.xcassets/** : Contient toutes les images, icônes et autres ressources visuelles de l'application.
*   **Base.lproj/Main.storyboard** : Définit l'interface utilisateur de l'application, y compris les transitions entre les différents `ViewControllers`.

**Modèles (Models/) :**

*   **JobOffer.swift** : Classe de base `Codable` et `Equatable` pour représenter une offre d'emploi générique, avec des propriétés communes comme le titre, l'entreprise, le lieu, le type de contrat, la description et l'URL de candidature.
*   **ApprentissageOffer.swift** : Classe `Codable` héritant de `JobOffer`, spécifique aux offres de l'API Apprentissage, avec un décodage JSON adapté à la structure de cette API.
*   **FranceTravailOffer.swift** : Classe `Codable` héritant de `JobOffer`, spécifique aux offres de l'API France Travail, avec un décodage JSON adapté à la structure de cette API.
*   **SearchFilters.swift** : Classe simple pour encapsuler les critères de recherche (mot-clé, localisation, type de contrat, etc.) passés entre les `ViewControllers` et les services API.

**Services (Services/) :**

*   **APIManager.swift** : Classe singleton générique pour effectuer des requêtes HTTP (`GET`, `POST`) et décoder les réponses JSON. Gère également les erreurs réseau et API de manière centralisée.
*   **ApprentissageAPIService.swift** : Service dédié à l'interaction avec l'API Apprentissage. Il construit les URLs de requête, gère les paramètres spécifiques à cette API et utilise `APIManager` pour l'exécution des requêtes et le décodage.
*   **FranceTravailAPIService.swift** : Service dédié à l'interaction avec l'API France Travail. Il gère l'authentification (obtention et rafraîchissement du token), construit les URLs de requête, gère les paramètres spécifiques et utilise `APIManager`.
*   **JobService.swift** : Service de coordination qui utilise `ApprentissageAPIService` et `FranceTravailAPIService` pour effectuer des recherches d'offres d'emploi sur les deux APIs et agréger les résultats.

**Utilitaires (Utilities/) :**

*   **Constants.swift** : Fichier pour définir toutes les constantes de l'application, telles que les URLs de base des APIs, les clés d'API, les identifiants client, etc.
*   **ErrorHandling.swift** : Définit une énumération `AppError` pour gérer les différents types d'erreurs qui peuvent survenir dans l'application (réseau, API, décodage, URL invalide).
*   **RateLimiter.swift** : Classe utilitaire pour implémenter une logique de limitation de débit (`rate limiting`) pour les appels API, afin de respecter les quotas des APIs.
*   **FavoritesManager.swift** : Classe singleton pour gérer la persistance locale des offres d'emploi favorites en utilisant `UserDefaults`.

**ViewControllers (ViewControllers/) :**

*   **HomeViewController.swift** : Affiche l'écran d'accueil avec le logo, le nom de l'application et un bouton pour lancer la recherche. Il utilise `UINavigationController` pour la navigation vers l'écran de recherche.
*   **SearchViewController.swift** : Permet à l'utilisateur de saisir des mots-clés, une localisation et de sélectionner un type de contrat via des filtres. Il déclenche la navigation vers l'écran des résultats de recherche.
*   **SearchResultsViewController.swift** : Affiche les offres d'emploi sous forme de liste (`UITableView`). Gère le chargement des données, l'affichage d'un indicateur de chargement, la pagination et la navigation vers l'écran de détail.
*   **JobDetailViewController.swift** : Affiche les informations détaillées d'une offre d'emploi sélectionnée, y compris un bouton pour postuler (ouvrant un lien externe) et un bouton pour ajouter/retirer l'offre des favoris.

**Vues (Views/) :**

*   **JobOfferCell.swift** : `UITableViewCell` personnalisée pour afficher de manière concise les informations clés d'une offre d'emploi (titre, entreprise, lieu, type de contrat) dans la liste des résultats.))
