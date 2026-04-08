import Foundation

class ApprentissageAPIService {
    static let shared = ApprentissageAPIService() // Singleton
    private let apiManager = APIManager.shared
    private let rateLimiter = RateLimiter(maxCallsPerSecond: 10) // Exemple de limite de débit
    
    private init() {}
    
    func searchOffers(filters: SearchFilters) async throws -> [ApprentissageOffer] {
        // Attendre si nécessaire pour respecter le rate limiting
        await rateLimiter.waitUntilCanMakeCall()
        
        guard var urlComponents = URLComponents(string: Constants.apprentissageBaseURL + "/job/v1/search") else {
            throw AppError.invalidURL
        }
        
        var queryItems: [URLQueryItem] = []
        
        // Paramètre caller est requis
        queryItems.append(URLQueryItem(name: "caller", value: Constants.apprentissageAPIKey))
        
        if let keyword = filters.keyword, !keyword.isEmpty {
            queryItems.append(URLQueryItem(name: "q", value: keyword))
        }
        
        if let latitude = filters.latitude, let longitude = filters.longitude {
            queryItems.append(URLQueryItem(name: "latitude", value: String(latitude)))
            queryItems.append(URLQueryItem(name: "longitude", value: String(longitude)))
            if let radius = filters.radius { // Rayon par défaut est 30km
                queryItems.append(URLQueryItem(name: "radius", value: String(radius)))
            }
        } else if let location = filters.location, !location.isEmpty {
            // Si pas de lat/long, on peut essayer de géocoder la localisation ici ou s'appuyer sur l'API pour le faire si elle le supporte.
            // Pour l'instant, on ne gère pas la géolocalisation par texte directement via cette API sans lat/long.
            // Une amélioration serait d'utiliser un service de géocodage externe.
        }
        
        if let contractType = filters.contractType, !contractType.isEmpty {
            // L'API Apprentissage utilise "Apprentissage" ou "Professionnalisation"
            // Il faudra mapper les types de contrat de l'UI vers ceux de l'API
            if contractType.lowercased().contains("stage") || contractType.lowercased().contains("alternance") {
                queryItems.append(URLQueryItem(name: "contract_type", value: "Apprentissage"))
            } else if contractType.lowercased().contains("emploi") {
                // L'API Apprentissage est principalement pour l'alternance, donc ce filtre pourrait ne pas être pertinent ou nécessiter une adaptation.
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw AppError.invalidURL
        }
        
        let response: ApprentissageAPIResponse = try await apiManager.performRequest(url: url, method: .get)
        return response.jobs
    }
}
