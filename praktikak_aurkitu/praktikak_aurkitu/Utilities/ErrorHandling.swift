import Foundation

enum AppError: Error, LocalizedError {
    case networkError(Error)
    case decodingError(Error)
    case apiError(statusCode: Int, message: String?)
    case invalidURL
    case customError(String)
    case rateLimitExceeded

    var errorDescription: String? {
        switch self {
        case .networkError(let error): return "Erreur réseau: \(error.localizedDescription)"
        case .decodingError(let error): return "Erreur de décodage des données: \(error.localizedDescription)"
        case .apiError(let statusCode, let message): return "Erreur API (Code: \(statusCode)): \(message ?? "")"
        case .invalidURL: return "URL invalide."
        case .customError(let message): return message
        case .rateLimitExceeded: return Constants.apiLimitReachedMessage
        }
    }
}
