import Foundation

class APIManager {
    static let shared = APIManager() // Singleton
    
    private init() {}
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    func performRequest<T: Decodable>(url: URL, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.networkError(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AppError.apiError(statusCode: httpResponse.statusCode, message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Pour les dates ISO 8601
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw AppError.decodingError(error)
        }
    }
}
