import Foundation

// MARK: - Modèles pour l'API France Travail

// Modèle pour le lieu de travail de France Travail
class FTWorkplace: Codable {
    let libelle: String?
    let codePostal: String?
    let ville: String?

    private enum CodingKeys: String, CodingKey {
        case libelle
        case codePostal
        case ville
    }
}

// Modèle principal pour une offre France Travail, héritant de JobOffer
class FranceTravailOffer: JobOffer {
    let originalId: String
    let url: URL
    let typeContratLibelle: String
    let descriptionEntreprise: String?
    let competences: [FTCompetence]?
    
    init(id: String, title: String, company: String, location: String, contractType: String, description: String?, applicationURL: URL?, originalId: String, url: URL, typeContratLibelle: String, descriptionEntreprise: String?, competences: [FTCompetence]?) {
        self.originalId = originalId
        self.url = url
        self.typeContratLibelle = typeContratLibelle
        self.descriptionEntreprise = descriptionEntreprise
        self.competences = competences
        super.init(id: id, title: title, company: company, location: location, contractType: contractType, description: description, applicationURL: applicationURL)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Propriétés spécifiques à France Travail
        self.originalId = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(URL.self, forKey: .url)
        self.typeContratLibelle = try container.decode(String.self, forKey: .typeContratLibelle)
        self.descriptionEntreprise = try container.decodeIfPresent(String.self, forKey: .descriptionEntreprise)
        self.competences = try container.decodeIfPresent([FTCompetence].self, forKey: .competences)
        
        // Propriétés de la classe parente JobOffer
        let id = try container.decode(String.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .intitule)
        let company = try container.decode(String.self, forKey: .nomEntreprise)
        
        let lieuTravail = try container.decode(FTWorkplace.self, forKey: .lieuTravail)
        var locationString = ""
        if let libelle = lieuTravail.libelle { locationString += libelle + ", " }
        if let codePostal = lieuTravail.codePostal { locationString += codePostal + " " }
        if let ville = lieuTravail.ville { locationString += ville }
        if locationString.isEmpty { locationString = "Lieu inconnu" }
        
        let contractType = try container.decode(String.self, forKey: .typeContratLibelle)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        let applicationURL = try container.decodeIfPresent(URL.self, forKey: .urlPostulation)
        
        try super.init(id: id, title: title, company: company, location: locationString, contractType: contractType, description: description, applicationURL: applicationURL)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(originalId, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(typeContratLibelle, forKey: .typeContratLibelle)
        try container.encodeIfPresent(descriptionEntreprise, forKey: .descriptionEntreprise)
        try container.encodeIfPresent(competences, forKey: .competences)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url
        case typeContratLibelle
        case descriptionEntreprise
        case competences
        
        // Propriétés mappées de JobOffer
        case intitule
        case nomEntreprise
        case lieuTravail
        case description
        case urlPostulation
    }
}

// Modèle pour les compétences de France Travail
class FTCompetence: Codable {
    let libelle: String
    
    private enum CodingKeys: String, CodingKey {
        case libelle
    }
}

// Modèle pour la réponse globale de l'API France Travail
class FranceTravailAPIResponse: Codable {
    let resultats: [FranceTravailOffer]
    let totalElements: Int
    
    private enum CodingKeys: String, CodingKey {
        case resultats
        case totalElements
    }
}
