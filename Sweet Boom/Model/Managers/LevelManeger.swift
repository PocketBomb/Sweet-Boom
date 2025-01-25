
import Foundation

struct LevelData {
    let backgroundImage: String
    let candieImage: String
    let levelNum: Int
    let candieSize: CGSize
    let countKnifes: Int
}
import Foundation
import SwiftUI

final class LevelManeger {
    static let shared = LevelManeger()
    
    private let baseCandiesArray: [String] = [
        "baseCandie1",
        "baseCandie2",
        "baseCandie3",
        "baseCandie4",
        "baseCandie5",
        "baseCandie6",
        "baseCandie7",
        "baseCandie8",
        "baseCandie9",
        "baseCandie10",
    ]
    
    private let baseLevelsArray: [LevelData] = [
        LevelData(backgroundImage: "gameBackground1", candieImage: "baseCandie1", levelNum: 1, candieSize: CGSize(width: 150, height: 150), countKnifes: 6),
        LevelData(backgroundImage: "gameBackground2", candieImage: "baseCandie2", levelNum: 2, candieSize: CGSize(width: 220, height: 220), countKnifes: 10),
        LevelData(backgroundImage: "gameBackground3", candieImage: "baseCandie3", levelNum: 3, candieSize: CGSize(width: 160, height: 160), countKnifes: 8),
        LevelData(backgroundImage: "gameBackground4", candieImage: "baseCandie4", levelNum: 4, candieSize: CGSize(width: 100, height: 100), countKnifes: 5),
        LevelData(backgroundImage: "gameBackground5", candieImage: "baseCandie5", levelNum: 6, candieSize: CGSize(width: 120, height: 120), countKnifes: 4),
        LevelData(backgroundImage: "gameBackground6", candieImage: "baseCandie6", levelNum: 7, candieSize: CGSize(width: 140, height: 140), countKnifes: 5),
        LevelData(backgroundImage: "gameBackground7", candieImage: "baseCandie7", levelNum: 8, candieSize: CGSize(width: 200, height: 200), countKnifes: 8),
        LevelData(backgroundImage: "gameBackground8", candieImage: "baseCandie8", levelNum: 9, candieSize: CGSize(width: 100, height: 100), countKnifes: 2),
        LevelData(backgroundImage: "gameBackground9", candieImage: "baseCandie9", levelNum: 11, candieSize: CGSize(width: 130, height: 130), countKnifes: 4),
        LevelData(backgroundImage: "gameBackground10", candieImage: "baseCandie10", levelNum: 12, candieSize: CGSize(width: 159, height: 159), countKnifes: 7),
    ]
    
    private let bossLevelsArray: [LevelData] = [
        LevelData(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie1", levelNum: 5, candieSize: CGSize(width: 100, height: 100), countKnifes: 4),
        LevelData(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie2", levelNum: 10, candieSize: CGSize(width: 220, height: 220), countKnifes: 11),
        LevelData(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie3", levelNum: 15, candieSize: CGSize(width: 180, height: 180), countKnifes: 9),
        LevelData(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie4", levelNum: 20, candieSize: CGSize(width: 150, height: 150), countKnifes: 7),
        LevelData(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie5", levelNum: 25, candieSize: CGSize(width: 200, height: 200), countKnifes: 10),
    ]
    
    // Текущие значения
    private(set) var currentScore: Int {
        didSet {
            UserDefaults.standard.set(currentScore, forKey: "currentScore")
        }
    }
    
    private(set) var currentLevel: Int {
        didSet {
            print("level called")
            print(currentLevel)
            UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
        }
    }
    
    // Рекорды
    private(set) var maxScore: Int = UserDefaults.standard.integer(forKey: "maxScore")
    private(set) var maxLevel: Int = UserDefaults.standard.integer(forKey: "maxLevel")
    
    private init() {
        // Загружаем сохраненные значения при инициализации
        self.currentScore = UserDefaults.standard.integer(forKey: "currentScore")
        self.currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
        print("UD values")
        print(UserDefaults.standard.integer(forKey: "currentScore"))
        print(UserDefaults.standard.integer(forKey: "currentLevel"))
        // Если значения еще не сохранены (например, при первом запуске), присваиваем начальные значения
        if currentScore == 0 {
            currentScore = 0
        }
        
        if currentLevel == 0 {
            currentLevel = 1
        }
    }
    
    // Получаем данные уровня по номеру
    public func getLevelData(by level: Int) -> LevelData {
        if level % 5 != 0 {
            let levelDiv = level / 5
            if level <= 12 {
                return baseLevelsArray[level-1-levelDiv]
            } else {
                return baseLevelsArray.randomElement()!
            }
        } else {
            switch level {
            case 5:
                return bossLevelsArray[0]
            case 10:
                return bossLevelsArray[1]
            case 15:
                return bossLevelsArray[2]
            case 20:
                return bossLevelsArray[3]
            case 25:
                return bossLevelsArray[4]
            default:
                return bossLevelsArray.randomElement()!
            }
        }

    }
    
    public func updateLevelAndScore(level: Int, score: Int) {
        currentLevel = level
        currentScore = score
        if score > maxScore {
            maxScore = score
            UserDefaults.standard.set(maxScore, forKey: "maxScore")
        }
        
        if level > maxLevel {
            maxLevel = level
            UserDefaults.standard.set(maxLevel, forKey: "maxLevel")
        }
    }
    
    // Сброс текущих очков и уровня
    public func reset() {
        currentScore = 0
        currentLevel = 1
    }
}
