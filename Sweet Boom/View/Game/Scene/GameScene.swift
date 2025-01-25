import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // main nodes
    var rotatingCandy: SKSpriteNode!
    var knifeTemplate: SKSpriteNode!
    var levelData: LevelData!
    // settings of level
    var currentLevel = 1
//    var remainingKnives: Int = 6
    var gameIsOver = false
    let ballSize = CGSize(width: 200, height: 200)
    let knifeSize = CGSize(width: 50, height: 130)
    
    // categories of object
    let knifeCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let stuckKnifeCategory: UInt32 = 0x1 << 2
    
    var isSmallScreen: Bool {
        get {
            return UIScreen.main.bounds.height < 800
        }
    }
    
    weak var viewModel: GameViewModel?
    
    override func didMove(to view: SKView) {
        currentLevel = levelData.levelNum
        setupLevel(num: levelData.levelNum)
    }
    
    func setupScene() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsOver {
            fireKnife()
        }
    }
}

