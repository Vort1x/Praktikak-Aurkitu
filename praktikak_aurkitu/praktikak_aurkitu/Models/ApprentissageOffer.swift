import Foundation

// MARK: - Modèles pour l'API Apprentissage

// Modèle pour l'identifiant d'une offre
class ApprentissageIdentifier: Codable {
    let id: String?
    let partnerJobId: String

    private enum CodingKeys: String, CodingKey {
        case id
        case partnerJobId = "partner_job_id"
    }
}

// Modèle pour le lieu de travail
class ApprentissageWorkplace: Codable {
    let name: String?
    let description: String?
    let website: URL?
    let siret: String?
    let location: ApprentissageLocation

    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case website
        case siret
        case location
    }
}

// Modèle pour la localisation
class ApprentissageLocation: Codable {
    let address: String?
    let city: String?
    let zipCode: String?

    private enum CodingKeys: String, CodingKey {
        case address
        case city
        case zip_code
    }
}

// Modèle pour les informations de candidature
class ApprentissageApply: Codable {
    let url: URL?
    let email: String?
    let phone: String?

    private enum CodingKeys: String, CodingKey {
        case url
        case email
        case phone
    }
}

// Modèle pour les détails du contrat
class ApprentissageContract: Codable {
    let type: [String]
    let duration: Int?
    let start: Date?
    let remote: String?

    private enum CodingKeys: String, CodingKey {
        case type
        case duration
        case start
        case remote
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode([String].self, forKey: .type)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        
        let dateString = try container.decodeIfPresent(String.self, forKey: .start)
        if let dateString = dateString {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            self.start = formatter.date(from: dateString)
        } else {
            self.start = nil
        }
        self.remote = try container.decodeIfPresent(String.self, forKey: .remote)
    }
}

// Modèle pour les détails de l'offre
class ApprentissageOfferDetails: Codable {
    let title: String
    let description: String
    let romeCodes: [String]?

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case romeCodes = "rome_codes"
    }
}

// Modèle principal pour une offre d'apprentissage, héritant de JobOffer
class ApprentissageOffer: JobOffer {
    
    init(id: String, title: String, company: String, location: String, contractType: String, description: String?, applicationURL: URL?) {
        super.init(id: id, title: title, company: company, location: location, contractType: contractType, description: description, applicationURL: applicationURL)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)
        
        let identifier = try container.decode(ApprentissageIdentifier.self, forKey: "identifier")
        let workplace = try container.decode(ApprentissageWorkplace.self, forKey: "workplace")
        let apply = try container.decode(ApprentissageApply.self, forKey: "apply")
        let contract = try container.decode(ApprentissageContract.self, forKey: "contract")
        let offerDetails = try container.decode(ApprentissageOfferDetails.self, forKey: "offer")
        
        let id = identifier.id ?? identifier.partnerJobId
        let title = offerDetails.title
        let company = workplace.name ?? workplace.location.city ?? "N/A"
        
        var locationString = ""
        if let address = workplace.location.address { locationString += address + ", " }
        if let zipCode = workplace.location.zipCode { locationString += zipCode + " " }
        if let city = workplace.location.city { locationString += city }
        if locationString.isEmpty { locationString = "Lieu inconnu" }
        
        let contractType = contract.type.joined(separator: ", ")
        let description = offerDetails.description
        let applicationURL = apply.url
        
        try super.init(id: id, title: title, company: company, location: locationString, contractType: contractType, description: description, applicationURL: applicationURL)
    }
}

// Modèle pour la réponse globale de l'API Apprentissage
class ApprentissageAPIResponse: Codable {
    let jobs: [ApprentissageOffer]
    let recruiters: [ApprentissageRecruiter]? // Si vous souhaitez gérer les recruteurs séparément

    private enum CodingKeys: String, CodingKey {
        case jobs
        case recruiters
    }
}

// Modèle pour les recruteurs (si nécessaire, basé sur la doc)
class ApprentissageRecruiter: Codable {
    let identifier: ApprentissageIdentifier
    let workplace: ApprentissageWorkplace
    let apply: ApprentissageApply

    private enum CodingKeys: String, CodingKey {
        case identifier
        case workplace
        case apply
    }
}
