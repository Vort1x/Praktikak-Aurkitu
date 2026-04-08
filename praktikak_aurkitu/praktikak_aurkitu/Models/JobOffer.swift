import Foundation

// Classe de base pour une offre d'emploi générique
class JobOffer: Codable, Equatable {
    let id: String
    let title: String
    let company: String
    let location: String
    let contractType: String
    let description: String?
    let applicationURL: URL?
    
    init(id: String, title: String, company: String, location: String, contractType: String, description: String?, applicationURL: URL?) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.contractType = contractType
        self.description = description
        self.applicationURL = applicationURL
    }
    
    // Implémentation de Equatable pour comparer les offres
    static func == (lhs: JobOffer, rhs: JobOffer) -> Bool {
        return lhs.id == rhs.id
    }
}
