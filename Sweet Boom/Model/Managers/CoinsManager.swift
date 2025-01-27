
import Foundation

//MARK: - CoinsManager its like pocket
final class CoinsManager: ObservableObject {
    static let shared = CoinsManager()

    //key for UserDefaults
    private let coinsKey = "coinsKey"
    
    private init() {
        //if it not set before
        if UserDefaults.standard.object(forKey: coinsKey) == nil {
            self.storedCoins = 0
        } else {
            self.storedCoins = UserDefaults.standard.object(forKey: coinsKey) as! Int
        }
        
    }
    
    // @Published property for observable changing coins для
    
    @Published private var storedCoins: Int {
        didSet {
            // Сохраняем в UserDefaults после изменения
            UserDefaults.standard.set(storedCoins, forKey: coinsKey)
        }
    }
    
    // getter for public use
    public var currentCoins: Int {
        return storedCoins
    }
    
    func addCoins(_ amount: Int) {
        storedCoins += amount // add to total
    }
    
    
    func subtractCoins(_ amount: Int) -> Bool {
        if storedCoins >= amount {
            storedCoins -= amount
            return true
        } else {
            return false // not enought money
        }
    }
}


