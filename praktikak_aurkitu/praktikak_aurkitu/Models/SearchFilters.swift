import Foundation

class SearchFilters {
    var keyword: String?
    var location: String?
    var contractType: String? // "stage", "alternance", "emploi"
    var radius: Int? // Pour les recherches géolocalisées
    var latitude: Double?
    var longitude: Double?
    
    init(keyword: String? = nil, location: String? = nil, contractType: String? = nil, radius: Int? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        self.keyword = keyword
        self.location = location
        self.contractType = contractType
        self.radius = radius
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func reset() {
        keyword = nil
        location = nil
        contractType = nil
        radius = nil
        latitude = nil
        longitude = nil
    }
}
