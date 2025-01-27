import SwiftUI

// MARK: - ViewModel for Knife State
class GameViewModel: ObservableObject {
    
    var coinsManager = CoinsManager.shared
    
    @Published var knifeStates: [Bool] = Array(repeating: false, count: 6) //false: not thrown, True: thrown
    @Published var messageImages = ["niceImage", "sensationalImage", "superImage"]
    @Published var remainingKnifes: Int = 0
    @Published var userLosed: Bool = false
    @Published var userWined: Bool = false
    @Published var showMessageSequence: Bool = false
    @Published var currentLevel: Int = 1
    @Published var scores: Int = 0
    
    init() {
        //download data from LevelManager
        self.currentLevel = LevelManeger.shared.currentLevel
        self.scores = LevelManeger.shared.currentScore
        
        //load current level data
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        self.remainingKnifes = levelData.countKnifes
    }
    
    //knifes
    func knifeThrown() {
        guard remainingKnifes > 0 else { return }
        if let index = knifeStates.firstIndex(of: false) {
            knifeStates[index] = true
            remainingKnifes -= 1
        }
    }
    
    // update level and coins
    func updateLevel() {
        userWined = true
        coinsManager.addCoins(5) //+scores
        
        //reload level and scores
        
        //update lavel
        currentLevel += 1
        if currentLevel > 44 {
            currentLevel = 1 //restart
        }
        LevelManeger.shared.updateLevelAndScore(level: currentLevel, score: scores)
        //update current level data
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        remainingKnifes = levelData.countKnifes
        knifeStates = Array(repeating: false, count: levelData.countKnifes)
    }
    
    //level data
    func getLevelData() -> Level {
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        remainingKnifes = levelData.countKnifes
        knifeStates = Array(repeating: false, count: levelData.countKnifes)
        return levelData
    }
    
    //reload(level = 1, score = 0)
    func restartLevel() {
        currentLevel = 1
        scores = 0
        userLosed = false
        LevelManeger.shared.reset()  // Сбросим данные в LevelManeger
    }
    //reload
    func reloadLevel() {
        let _ = coinsManager.subtractCoins(5)
        let num = currentLevel
        let scores1 = scores
        
        currentLevel = num
        scores = scores1
        userLosed = false
    }
    
    //+score
    func addScore() {
        scores += 1
    }
    
    
}
