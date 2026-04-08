import Foundation

class RateLimiter {
    private var lastCallTime: Date?
    private let rateLimit: TimeInterval // Nombre de secondes entre les appels
    private let maxCallsPerSecond: Int
    
    init(maxCallsPerSecond: Int) {
        self.maxCallsPerSecond = maxCallsPerSecond
        self.rateLimit = 1.0 / TimeInterval(maxCallsPerSecond)
    }
    
    func canMakeCall() -> Bool {
        guard let lastCallTime = lastCallTime else {
            // Premier appel, autorisé
            self.lastCallTime = Date()
            return true
        }
        
        let timeSinceLastCall = Date().timeIntervalSince(lastCallTime)
        if timeSinceLastCall >= rateLimit {
            self.lastCallTime = Date()
            return true
        } else {
            return false
        }
    }
    
    func waitUntilCanMakeCall() async {
        while !canMakeCall() {
            let timeSinceLastCall = Date().timeIntervalSince(lastCallTime ?? Date())
            let timeToWait = rateLimit - timeSinceLastCall
            if timeToWait > 0 {
                try? await Task.sleep(nanoseconds: UInt64(timeToWait * 1_000_000_000))
            }
        }
    }
}
