
import SwiftUI

final class CoinsViewModel: ObservableObject {
    
    @StateObject private var coinsManager = CoinsManager.shared
    
    public var currentCoins: Int {
        return coinsManager.currentCoins
    }
}

