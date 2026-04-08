# praktikak aurkitu

## Application iOS de Recherche d'Offres d'Emploi et de Stages

`praktikak aurkitu` est une application mobile iOS conçue pour aider les étudiants à trouver des stages et des offres d'emploi en alternance. Elle agrège les résultats de plusieurs APIs publiques, notamment l'API Apprentissage et les APIs France Travail, pour offrir une expérience de recherche complète et centralisée.

## Fonctionnalités

*   **Écran d'accueil** : Présentation de l'application avec un logo et un bouton pour démarrer la recherche.
*   **Écran de recherche** : Permet aux utilisateurs de rechercher des offres par mot-clé, localisation et type de contrat (stage, alternance, emploi).
*   **Écran des résultats** : Affiche une liste paginée des offres trouvées, avec les informations clés (titre, entreprise, lieu, type de contrat).
*   **Écran de détail** : Présente la description complète de l'offre, l'entreprise, le lieu, et un bouton pour postuler (ouvrant un lien externe).
*   **Favoris** : Permet de sauvegarder localement les offres intéressantes pour une consultation ultérieure.

## Architecture et Technologies

*   **Langage** : Swift
*   **IDE** : Xcode
*   **Interface** : UIKit avec fichiers `.storyboard` (pas SwiftUI)
*   **Architecture** : Model-View-Controller (MVC)
*   **Gestion des APIs** : `URLSession` pour les requêtes HTTP, `Codable` pour le parsing JSON.
*   **Persistance locale** : `UserDefaults` pour les favoris.
*   **Gestion du Rate Limiting** : Implémentation d'un mécanisme pour respecter les quotas des APIs.

## Structure du Projet

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
└── README.md                     # Ce fichier de documentation.
```

## Instructions pour configurer et exécuter le projet dans Xcode

1.  **Cloner le dépôt** : Si le projet est dans un dépôt Git, clonez-le sur votre machine locale.

    ```bash
    git clone <URL_DU_DEPOT>
    cd praktikak_aurkitu
    ```

2.  **Ouvrir le projet dans Xcode** : Ouvrez le fichier `praktikak_aurkitu.xcodeproj` avec Xcode.

3.  **Définir les informations de l'équipe et le Bundle Identifier** :
    *   Dans le navigateur de projet (à gauche), sélectionnez le projet `praktikak_aurkitu`.
    *   Dans l'onglet `Signing & Capabilities`, sélectionnez votre équipe de développement.
    *   Assurez-vous que le `Bundle Identifier` est unique (par exemple, `com.votreNom.praktikak-aurkitu`).

4.  **Ajouter les clés API dans `Constants.swift`** :
    *   Ouvrez le fichier `praktikak_aurkitu/Utilities/Constants.swift`.
    *   Remplacez les placeholders par vos véritables clés et identifiants d'API. Pour l'API France Travail, vous devrez obtenir un `client_id` et un `client_secret` en créant une application sur leur portail développeur (https://francetravail.io/compte/applications).

    ```swift
    // Dans Constants.swift
    struct Constants {
        static let apprentissageBaseURL = "https://api.apprentissage.beta.gouv.fr"
        static let apprentissageAPIKey = "VOTRE_CLE_API_APPRENTISSAGE" // Remplacez par votre clé
        
        static let franceTravailAuthURL = "https://authentification-partenaire.francetravail.io/partenaire/oauth2/access_token"
        static let franceTravailBaseURL = "https://api.francetravail.io/partenaire"
        static let franceTravailClientID = "VOTRE_CLIENT_ID_FRANCE_TRAVAIL" // Remplacez par votre Client ID
        static let franceTravailClientSecret = "VOTRE_CLIENT_SECRET_FRANCE_TRAVAIL" // Remplacez par votre Client Secret
        static let franceTravailScope = "api_offresdemploiv2 o2d_applicationsapi o2d_mesevenementsapi o2d_accessemploiapi o2d_synthesepagesemployeursapi"
    }
    ```

5.  **Exécuter l'application** :
    *   Sélectionnez un simulateur iOS (par exemple, iPhone 15 Pro) ou un appareil réel comme cible d'exécution.
    *   Cliquez sur le bouton `Run` (le triangle) dans la barre d'outils d'Xcode.

## Exemple de Requête API Fonctionnelle (France Travail)

Pour tester l'intégration de l'API France Travail, vous pouvez simuler une recherche dans le `SearchViewController` ou directement dans `SearchResultsViewController` pour voir les résultats. Assurez-vous d'avoir configuré vos identifiants API dans `Constants.swift`.

Voici un exemple de la logique de recherche dans `JobService.swift` qui appelle les services spécifiques :

```swift
// Extrait de JobService.swift
func searchJobs(filters: SearchFilters, page: Int = 0, limit: Int = 10) async throws -> [JobOffer] {
    var allOffers: [JobOffer] = []
    
    // Recherche via l'API Apprentissage
    do {
        let apprentissageOffers = try await apprentissageAPIService.searchOffers(filters: filters)
        allOffers.append(contentsOf: apprentissageOffers)
    } catch {
        print("Erreur lors de la recherche via l'API Apprentissage: \(error)")
    }
    
    // Recherche via l'API France Travail
    do {
        let franceTravailResponse = try await franceTravailAPIService.searchOffers(filters: filters, page: page, limit: limit)
        allOffers.append(contentsOf: franceTravailResponse.resultats)
    } catch {
        print("Erreur lors de la recherche via l'API France Travail: \(error)")
    }
    
    return allOffers.sorted { $0.title < $1.title }
}
```

Lorsque vous lancez une recherche depuis l'écran `SearchViewController`, la méthode `searchButtonTapped()` crée un objet `SearchFilters` et le passe à `SearchResultsViewController`. Ce dernier utilise `JobService.shared.searchJobs` pour récupérer les offres.

## Conseils pour Tester l'Application

1.  **Testez les différents écrans** : Naviguez entre l'écran d'accueil, de recherche, de résultats et de détail. Vérifiez que les transitions sont fluides et que tous les éléments UI sont affichés correctement.

2.  **Testez la recherche** :
    *   Effectuez des recherches avec différents mots-clés (ex: "développeur", "designer").
    *   Testez la recherche par localisation (ex: "Paris", "Lyon").
    *   Utilisez les filtres de type de contrat ("Stage", "Alternance", "Emploi").
    *   Vérifiez que les résultats s'affichent et que la pagination fonctionne (faites défiler la liste pour charger plus d'offres).
    *   Testez les cas où aucune offre n'est trouvée.

3.  **Testez l'affichage des détails** : Cliquez sur une offre dans la liste des résultats pour voir son détail. Vérifiez que toutes les informations sont présentes et que le bouton "Postuler" ouvre bien un lien externe (si disponible).

4.  **Testez les favoris** :
    *   Ajoutez des offres aux favoris depuis l'écran de détail.
    *   Vérifiez que les offres sont bien sauvegardées et récupérées après avoir quitté et relancé l'application.
    *   Retirez des offres des favoris.

5.  **Testez la gestion des erreurs** :
    *   Désactivez votre connexion internet pour simuler une erreur réseau et vérifiez que l'application affiche un message d'erreur approprié.
    *   (Avancé) Si possible, simulez des réponses d'API invalides ou des codes d'erreur HTTP pour tester la robustesse du `APIManager` et des services API.

6.  **Testez le Rate Limiting** : Bien que difficile à simuler précisément sans un environnement de test dédié, vous pouvez observer les logs pour voir si les appels API sont espacés conformément à la configuration de `RateLimiter`.

## Améliorations Possibles (Bonus)

*   **Géolocalisation** : Intégrer `CoreLocation` pour obtenir la position actuelle de l'utilisateur et l'utiliser comme filtre de recherche.
*   **Suggestions automatiques** : Implémenter des suggestions pour la barre de recherche ou la localisation en utilisant une API de complétion ou des données historiques.
*   **Cache** : Mettre en place un système de cache pour les résultats d'API afin de réduire les appels redondants et améliorer les performances.
*   **UI/UX** : Affiner le design, ajouter des animations, des icônes personnalisées, etc.
*   **Tests unitaires et d'intégration** : Écrire des tests pour les modèles, les services et les `ViewControllers`.
*   **Accessibilité** : Améliorer l'accessibilité de l'application pour les utilisateurs ayant des besoins spécifiques.

---

**Auteur** : Vort1x
**Date** : 08 Avril 2026
