import Foundation

class FavoritesManager {
    static let shared = FavoritesManager() // Singleton
    private let favoritesKey = "favoriteJobOffers"
    
    private init() {}
    
    func addFavorite(_ offer: JobOffer) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == offer.id }) {
            favorites.append(offer)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(_ offer: JobOffer) {
        var favorites = getFavorites()
        favorites.removeAll(where: { $0.id == offer.id })
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [JobOffer] {
        if let savedOffersData = UserDefaults.standard.data(forKey: favoritesKey) {
            let decoder = JSONDecoder()
            if let savedOffers = try? decoder.decode([JobOffer].self, from: savedOffersData) {
                return savedOffers
            }
        }
        return []
    }
    
    func isFavorite(_ offer: JobOffer) -> Bool {
        return getFavorites().contains(where: { $0.id == offer.id })
    }
    
    private func saveFavorites(_ favorites: [JobOffer]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
