
import Foundation
import SwiftUI

//MARK: LevelManager manages user data(score, current level, records...)
final class LevelManeger {
    static let shared = LevelManeger()
    
    private let levelData = LevelData.shared
    
    
    //user score
    private(set) var currentScore: Int {
        didSet {
            UserDefaults.standard.set(currentScore, forKey: "currentScore")
        }
    }
    
    // user level
    private(set) var currentLevel: Int {
        didSet {
            UserDefaults.standard.set(currentLevel, forKey: "currentLevel")
        }
    }
    
    //MARK: - Records
    private(set) var maxScore: Int = UserDefaults.standard.integer(forKey: "maxScore")
    private(set) var maxLevel: Int = UserDefaults.standard.integer(forKey: "maxLevel")
    
    private init() {
        //loading saved data
        self.currentScore = UserDefaults.standard.integer(forKey: "currentScore")
        self.currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
        
        //if values not saved
        if currentScore == 0 {
            currentScore = 0
        }
        
        if currentLevel == 0 {
            currentLevel = 1
        }
    }
    
    //MARK: - get level data by level number
    public func getLevelData(by level: Int) -> Level {
        //MARK: - check if it boss level
        if level % 5 != 0 {
            let levelDiv = level / 5
            if level <= 12 {
                //use base levels
                return levelData.baseLevelsArray[level-1-levelDiv]
            } else {
                //use random
                return levelData.baseLevelsArray.randomElement()!
            }
        //MARK: - Boss levels
        } else {
            switch level {
            case 5:
                return levelData.bossLevelsArray[0]
            case 10:
                return levelData.bossLevelsArray[1]
            case 15:
                return levelData.bossLevelsArray[2]
            case 20:
                return levelData.bossLevelsArray[3]
            case 25:
                return levelData.bossLevelsArray[4]
            default:
                return levelData.bossLevelsArray.randomElement()!
            }
        }

    }
    
    //update user data
    public func updateLevelAndScore(level: Int, score: Int) {
        currentLevel = level
        currentScore = score
        updateRecord(level: level, score: score)
    }
    
    //update record
    private func updateRecord(level: Int, score: Int) {
        if score > maxScore {
            maxScore = score
            UserDefaults.standard.set(maxScore, forKey: "maxScore")
        }
        
        if level > maxLevel {
            maxLevel = level
            UserDefaults.standard.set(maxLevel, forKey: "maxLevel")
        }
    }
    
    //reset user data
    public func reset() {
        currentScore = 0
        currentLevel = 1
    }
}
