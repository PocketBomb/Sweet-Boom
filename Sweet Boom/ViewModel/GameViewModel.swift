import SwiftUI

// MARK: - ViewModel for Knife State
class GameViewModel: ObservableObject {
    
    var coinsManager = CoinsManager.shared
    
    @Published var knifeStates: [Bool] = Array(repeating: false, count: 6) // False: not thrown, True: thrown
    @Published var messageImages = ["niceImage", "sensationalImage", "superImage"]
    @Published var remainingKnives: Int = 0
    @Published var userLosed: Bool = false
    @Published var userWined: Bool = false
    @Published var showMessageSequence: Bool = false
    @Published var currentLevel: Int = 1
    @Published var scores: Int = 0
    
    init() {
        // Загружаем данные из LevelManeger
        self.currentLevel = LevelManeger.shared.currentLevel
        self.scores = LevelManeger.shared.currentScore
        
        // Загружаем данные текущего уровня
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        self.remainingKnives = levelData.countKnifes
        print(self.currentLevel)
    }
    
    // Метод для выбрасывания ножа
    func knifeThrown() {
        guard remainingKnives > 0 else { return }
        if let index = knifeStates.firstIndex(of: false) {
            knifeStates[index] = true
            remainingKnives -= 1
        }
    }
    
    // Метод для обновления уровня и очков
    func updateLevel() {
        userWined = true
        coinsManager.addCoins(5)  // Пример добавления монет
        
        // Обновляем уровень и очки
        
        // Увеличиваем уровень
        currentLevel += 1
        if currentLevel > 44 {
            currentLevel = 1 // Перезапуск с первого уровня, например
        }
        LevelManeger.shared.updateLevelAndScore(level: currentLevel, score: scores)
        // Обновляем данные текущего уровня
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        remainingKnives = levelData.countKnifes
        knifeStates = Array(repeating: false, count: levelData.countKnifes)
    }
    
    // Получение данных уровня
    func getLevelData() -> LevelData {
        let levelData = LevelManeger.shared.getLevelData(by: currentLevel)
        remainingKnives = levelData.countKnifes
        knifeStates = Array(repeating: false, count: levelData.countKnifes)
        return levelData
    }
    
    // Сброс уровня и очков
    func restartLevel() {
        currentLevel = 1
        scores = 0
        userLosed = false
        LevelManeger.shared.reset()  // Сбросим данные в LevelManeger
    }
    
    func reloadLevel() {
        let _ = coinsManager.subtractCoins(5)
        let num = currentLevel
        let scores1 = scores
        
        currentLevel = num
        scores = scores1
        userLosed = false
    }
    
    // Добавление очков
    func addScore() {
        scores += 1
//        LevelManeger.shared.updateLevelAndScore(level: currentLevel, score: scores)
    }
    
    
}
