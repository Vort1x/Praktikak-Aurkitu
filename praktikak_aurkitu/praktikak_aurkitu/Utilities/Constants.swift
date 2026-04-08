import Foundation

struct Constants {
    // MARK: - API Keys et URLs
    static let apprentissageAPIKey = "VOTRE_CLE_API_APPRENTISSAGE" // À remplacer par votre clé API
    static let apprentissageBaseURL = "https://api.apprentissage.beta.gouv.fr/v1"
    
    static let franceTravailClientID = "VOTRE_CLIENT_ID_FRANCE_TRAVAIL" // À remplacer par votre Client ID
    static let franceTravailClientSecret = "VOTRE_CLIENT_SECRET_FRANCE_TRAVAIL" // À remplacer par votre Client Secret
    static let franceTravailTokenURL = "https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?realm=/partenaire"
    static let franceTravailOffersBaseURL = "https://api.francetravail.io/partenaire/offresdemploi/v2"
    static let franceTravailEventsBaseURL = "https://api.francetravail.io/partenaire/mes-evenements-emploi/v1"
    
    // MARK: - Identifiants de Cellules
    static let jobOfferCellIdentifier = "JobOfferCell"
    
    // MARK: - Segues
    static let showSearchResultsSegue = "ShowSearchResults"
    static let showOfferDetailSegue = "ShowOfferDetail"
    static let showFavoritesSegue = "ShowFavorites"
    
    // MARK: - UserDefaults Keys
    static let favoriteOffersKey = "favoriteOffers"
    
    // MARK: - UI Text
    static let appName = "praktikak aurkitu"
    static let searchButtonTitle = "Rechercher un stage"
    static let searchPlaceholder = "Mot-clé (ex: développeur iOS)"
    static let locationPlaceholder = "Localisation (ex: Paris)"
    static let contractTypePlaceholder = "Type de contrat"
    static let searchTitle = "Recherche d'offres"
    static let resultsTitle = "Résultats de recherche"
    static let detailTitle = "Détail de l'offre"
    static let favoritesTitle = "Mes favoris"
    static let applyButtonTitle = "Postuler"
    
    // MARK: - Erreurs
    static let genericErrorMessage = "Une erreur est survenue. Veuillez réessayer."
    static let networkErrorMessage = "Problème de connexion réseau. Veuillez vérifier votre connexion."
    static let parsingErrorMessage = "Erreur lors du traitement des données."
    static let apiLimitReachedMessage = "Limite d'appels API atteinte. Veuillez patienter."
}
