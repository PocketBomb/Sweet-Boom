
import SwiftUI

// MARK: - ViewModel for Knife State
class GameViewModel: ObservableObject {
    @Published var knifeStates: [Bool] = Array(repeating: false, count: 6) // False: not thrown, True: thrown
    @Published var remainingKnives: Int = 6
    @Published var isGameOver: Bool = false
    
    func knifeThrown() {
        guard remainingKnives > 0 else { return }
        let index = knifeStates.firstIndex(of: false)
        if let index = index {
            knifeStates[index] = true
            remainingKnives -= 1
        }
    }
}
