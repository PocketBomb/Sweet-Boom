
import Foundation

final class LevelData {
    static let shared = LevelData()
    
    public let baseLevelsArray: [Level] = [
        Level(backgroundImage: "gameBackground1", candieImage: "baseCandie1", levelNum: 1, candieSize: CGSize(width: 150, height: 150), countKnifes: 6),
        Level(backgroundImage: "gameBackground2", candieImage: "baseCandie2", levelNum: 2, candieSize: CGSize(width: 220, height: 220), countKnifes: 10),
        Level(backgroundImage: "gameBackground3", candieImage: "baseCandie3", levelNum: 3, candieSize: CGSize(width: 160, height: 160), countKnifes: 8),
        Level(backgroundImage: "gameBackground4", candieImage: "baseCandie4", levelNum: 4, candieSize: CGSize(width: 100, height: 100), countKnifes: 5),
        Level(backgroundImage: "gameBackground5", candieImage: "baseCandie5", levelNum: 6, candieSize: CGSize(width: 120, height: 120), countKnifes: 4),
        Level(backgroundImage: "gameBackground6", candieImage: "baseCandie6", levelNum: 7, candieSize: CGSize(width: 140, height: 140), countKnifes: 5),
        Level(backgroundImage: "gameBackground7", candieImage: "baseCandie7", levelNum: 8, candieSize: CGSize(width: 200, height: 200), countKnifes: 8),
        Level(backgroundImage: "gameBackground8", candieImage: "baseCandie8", levelNum: 9, candieSize: CGSize(width: 100, height: 100), countKnifes: 2),
        Level(backgroundImage: "gameBackground9", candieImage: "baseCandie9", levelNum: 11, candieSize: CGSize(width: 130, height: 130), countKnifes: 4),
        Level(backgroundImage: "gameBackground10", candieImage: "baseCandie10", levelNum: 12, candieSize: CGSize(width: 159, height: 159), countKnifes: 7),
    ]
    
    public let bossLevelsArray: [Level] = [
        Level(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie1", levelNum: 5, candieSize: CGSize(width: 100, height: 100), countKnifes: 4),
        Level(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie2", levelNum: 10, candieSize: CGSize(width: 220, height: 220), countKnifes: 11),
        Level(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie3", levelNum: 15, candieSize: CGSize(width: 180, height: 180), countKnifes: 9),
        Level(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie4", levelNum: 20, candieSize: CGSize(width: 150, height: 150), countKnifes: 7),
        Level(backgroundImage: "gameBackground\(Int.random(in: 1...10))", candieImage: "bossCandie5", levelNum: 25, candieSize: CGSize(width: 200, height: 200), countKnifes: 10),
    ]
}
