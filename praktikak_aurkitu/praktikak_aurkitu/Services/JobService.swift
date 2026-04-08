import Foundation

class JobService {
    static let shared = JobService() // Singleton
    
    private let apprentissageAPIService = ApprentissageAPIService.shared
    private let franceTravailAPIService = FranceTravailAPIService.shared
    
    private init() {}
    
    func searchJobs(filters: SearchFilters, page: Int = 0, limit: Int = 10) async throws -> [JobOffer] {
        var allOffers: [JobOffer] = []
        
        // Recherche via l'API Apprentissage
        do {
            let apprentissageOffers = try await apprentissageAPIService.searchOffers(filters: filters)
            allOffers.append(contentsOf: apprentissageOffers)
        } catch {
            print("Erreur lors de la recherche via l'API Apprentissage: \(error)")
            // Continuer même si une API échoue
        }
        
        // Recherche via l'API France Travail
        do {
            let franceTravailResponse = try await franceTravailAPIService.searchOffers(filters: filters, page: page, limit: limit)
            allOffers.append(contentsOf: franceTravailResponse.resultats)
        } catch {
            print("Erreur lors de la recherche via l'API France Travail: \(error)")
            // Continuer même si une API échoue
        }
        
        return allOffers.sorted { $0.title < $1.title } // Exemple de tri
    }
}
