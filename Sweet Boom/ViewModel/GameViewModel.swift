
import SwiftUI

// MARK: - ViewModel for Knife State
class GameViewModel: ObservableObject {
    @Published var knifeStates: [Bool] = Array(repeating: false, count: 6) // False: not thrown, True: thrown
    @Published var messageImages = ["niceImage", "sensationalImage", "superImage"]
    @Published var remainingKnives: Int = 0
    @Published var userLosed: Bool = false
    @Published var userWined: Bool = false
    @Published var showMessageSequence: Bool = false
    @Published var currentLevel = 5
    @Published var scores = 0
    
    init() {
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        self.remainingKnives = levelData.countKnifes
    }
    
    func knifeThrown() {
        print(remainingKnives)
        guard remainingKnives > 0 else { return }
        let index = knifeStates.firstIndex(of: false)
        if let index = index {
            knifeStates[index] = true
            remainingKnives -= 1
        }
    }
    
    func updateLevel() {
        userWined = true
        currentLevel += 1
        if currentLevel > 44 {
            currentLevel = 1 // Перезапуск с первого уровня, например
        }
    }
    
    func getLevelData() -> LevelData {
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        remainingKnives = levelData.countKnifes
        knifeStates = Array(repeating: false, count: levelData.countKnifes)
        print("countKnifes: \(remainingKnives)")
        return levelData
    }
    
    func restartLevel() {
        currentLevel = 1
        scores = 0
        userLosed = false
    }
    
    func addScore() {
        scores += 1
    }
}
