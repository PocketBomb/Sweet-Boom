
import SwiftUI
import SpriteKit

//MARK: - For register contact
struct Catefory {
    let knifeCategory: UInt32 = 0x1 << 0
    let candyCategory: UInt32 = 0x1 << 1
    let stuckKnifeCategory: UInt32 = 0x1 << 2
}

//MARK: - Game Scene
class GameScene: SKScene, SKPhysicsContactDelegate {
    //main nodes
    var rotatingCandy: SKSpriteNode!
    var knifeTemplate: SKSpriteNode!
    
    var levelData: Level!
    
    //settings of level
    var currentLevel = 1
    var gameIsOver = false
    
    //sizes
    let knifeSize = CGSize(width: 50, height: 130)
    
    //categories of object
    let category = Catefory()
    
   
    weak var viewModel: GameViewModel?
    
    override func didMove(to view: SKView) {
        currentLevel = levelData.levelNum // level
        setupLevel(num: levelData.levelNum) // settings
    }
    
    //physics
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

