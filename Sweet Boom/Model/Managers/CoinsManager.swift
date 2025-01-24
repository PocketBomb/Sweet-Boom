
import Foundation

import Foundation

class CoinsManager: ObservableObject {
    // Singleton
    static let shared = CoinsManager()

    // Ключ для хранения монет в UserDefaults
    private let coinsKey = "coinsKey"
    
    // Инициализатор - доступ только через singleton
    private init() {
        // Инициализация количества монет, если оно еще не установлено
        if UserDefaults.standard.object(forKey: coinsKey) == nil {
//            UserDefaults.standard.set(0, forKey: coinsKey)  // начальное значение
            self.storedCoins = 0
        } else {
            self.storedCoins = UserDefaults.standard.object(forKey: coinsKey) as! Int
        }
        
    }
    
    // @Published свойство для отслеживания изменения монет
    @Published private var storedCoins: Int {
        didSet {
            // Сохраняем в UserDefaults после изменения
            UserDefaults.standard.set(storedCoins, forKey: coinsKey)
        }
    }
    
    // Геттер для внешнего использования
    var currentCoins: Int {
        return storedCoins
    }
    
    // Добавить монеты
    func addCoins(_ amount: Int) {
        storedCoins += amount
    }
    
    // Вычесть монеты
    func subtractCoins(_ amount: Int) -> Bool {
        if storedCoins >= amount {
            storedCoins -= amount
            return true
        } else {
            return false // Недостаточно монет
        }
    }
}


