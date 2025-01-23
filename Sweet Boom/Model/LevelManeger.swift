
import Foundation

struct LevelData {
    let backgroundImage: String
    let candieImage: String
    let levelNum: Int
    let candieSize: CGSize
    let countKnifes: Int
}

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
        LevelData(backgroundImage: "gameBackground2", candieImage: "baseCandie2", levelNum: 1, candieSize: CGSize(width: 220, height: 220), countKnifes: 10),
        LevelData(backgroundImage: "gameBackground3", candieImage: "baseCandie3", levelNum: 1, candieSize: CGSize(width: 160, height: 160), countKnifes: 8),
        LevelData(backgroundImage: "gameBackground4", candieImage: "baseCandie4", levelNum: 1, candieSize: CGSize(width: 100, height: 100), countKnifes: 5),
    ]
    
    
    
    private init() {}
    

    public func getLevelData(by level: Int) -> LevelData {
        if level <= 4 {
            return baseLevelsArray[level-1]
        } else {
            return LevelData(backgroundImage: "gameBackground5", candieImage: "baseCandie5", levelNum: level, candieSize: CGSize(width: 100, height: 100), countKnifes: 2)
        }
    }
}
