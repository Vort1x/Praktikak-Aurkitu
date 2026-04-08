import Foundation

class FranceTravailAPIService {
    static let shared = FranceTravailAPIService() // Singleton
    private let apiManager = APIManager.shared
    private let rateLimiter = RateLimiter(maxCallsPerSecond: 10) // Limite de 10 appels/seconde
    
    private var accessToken: String? // Token d'authentification
    private var tokenExpirationDate: Date? // Date d'expiration du token
    
    private init() {}
    
    // Fonction pour obtenir un token d'authentification
    private func getAccessToken() async throws -> String {
        // Vérifier si le token est toujours valide
        if let token = accessToken, let expirationDate = tokenExpirationDate, expirationDate > Date() {
            return token
        }
        
        // Si le token est expiré ou n'existe pas, en demander un nouveau
        guard let url = URL(string: Constants.franceTravailAuthURL) else {
            throw AppError.invalidURL
        }
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let bodyString = "grant_type=client_credentials&client_id=\(Constants.franceTravailClientID)&client_secret=\(Constants.franceTravailClientSecret)&scope=\(Constants.franceTravailScope)"
        let body = bodyString.data(using: .utf8)
        
        let response: FranceTravailAuthResponse = try await apiManager.performRequest(url: url, method: .post, headers: headers, body: body)
        
        self.accessToken = response.accessToken
        self.tokenExpirationDate = Date().addingTimeInterval(TimeInterval(response.expiresIn))
        
        return response.accessToken
    }
    
    func searchOffers(filters: SearchFilters, page: Int = 0, limit: Int = 10) async throws -> FranceTravailAPIResponse {
        await rateLimiter.waitUntilCanMakeCall()
        
        let token = try await getAccessToken()
        
        guard var urlComponents = URLComponents(string: Constants.franceTravailBaseURL + "/offresdemploi/v2/offres/search") else {
            throw AppError.invalidURL
        }
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "range", value: "\(page * limit)-\((page + 1) * limit - 1)")
        ]
        
        if let keyword = filters.keyword, !keyword.isEmpty {
            queryItems.append(URLQueryItem(name: "motsCles", value: keyword))
        }
        
        if let location = filters.location, !location.isEmpty {
            // L'API France Travail peut prendre une localisation textuelle ou des coordonnées
            // Pour l'instant, on utilise la localisation textuelle. Une amélioration serait la géolocalisation.
            queryItems.append(URLQueryItem(name: "commune", value: location))
        }
        
        if let contractType = filters.contractType, !contractType.isEmpty {
            // Mapper les types de contrat de l'UI vers ceux de l'API France Travail
            // Exemple: "CDI", "CDD", "Alternance", "Stage"
            if contractType.lowercased().contains("stage") {
                queryItems.append(URLQueryItem(name: "typeContrat", value: "STAGE"))
            } else if contractType.lowercased().contains("alternance") {
                queryItems.append(URLQueryItem(name: "typeContrat", value: "ALTERNANCE"))
            } else if contractType.lowercased().contains("emploi") {
                // Pour "emploi", on peut ne pas spécifier de type de contrat ou inclure CDI/CDD
                // queryItems.append(URLQueryItem(name: "typeContrat", value: "CDI,CDD"))
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw AppError.invalidURL
        }
        
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        return try await apiManager.performRequest(url: url, method: .get, headers: headers)
    }
}

// Modèle pour la réponse d'authentification de France Travail
class FranceTravailAuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let scope: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case scope
    }
}
