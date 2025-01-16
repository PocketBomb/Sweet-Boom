import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Основные узлы
    var rotatingBall: SKSpriteNode!
    var knifeTemplate: SKSpriteNode!
    
    var remainingKnives: Int = 6
    var gameIsOver = false
    
    let ballSize = CGSize(width: 200, height: 200)
    let knifeSize = CGSize(width: 56, height: 200)
    let knifeCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    let stuckKnifeCategory: UInt32 = 0x1 << 2
    
    weak var viewModel: GameViewModel?
    
    override func didMove(to view: SKView) {
        setupScene()
        setupRotatingBall()
        setupKnifeTemplate()
    }
    
    func setupScene() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // Добавляем изображение в качестве фона
        let background = SKSpriteNode(imageNamed: "backgroundImage1")
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -10 // Располагаем позади остальных узлов
        addChild(background)
    }
    
    func setupLevel() {
        
    }
    
    func setupRotatingBall() {
        let ballTexture = SKTexture(imageNamed: "ballImage")
        rotatingBall = SKSpriteNode(texture: ballTexture, size: ballSize)
        rotatingBall.position = CGPoint(x: frame.midX, y: frame.midY)
        
        // Настройка физического тела точно по размеру спрайта
        let radius = ballSize.width / 2
        rotatingBall.scene?.backgroundColor = .clear
        rotatingBall.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        rotatingBall.physicsBody?.isDynamic = false
        rotatingBall.physicsBody?.categoryBitMask = ballCategory
        rotatingBall.physicsBody?.contactTestBitMask = knifeCategory
        rotatingBall.physicsBody?.collisionBitMask = 0
        rotatingBall.zPosition = 0
        addChild(rotatingBall)
        
        startBallRotation()
    }
    
    func setupKnifeTemplate() {
        let knifeTexture = SKTexture(imageNamed: "knifeImage")
        knifeTemplate = SKSpriteNode(texture: knifeTexture)
        knifeTemplate.size = knifeSize
        knifeTemplate.position = CGPoint(x: frame.midX, y: frame.minY + 150)
        addChild(knifeTemplate)
    }
    
    func startBallRotation() {
        let rotateClockwise = SKAction.rotate(byAngle: .pi * 2, duration: 5.0)
        let rotateCounterClockwise = SKAction.rotate(byAngle: -.pi * 2, duration: 5.0)
        let rotationSequence = SKAction.sequence([rotateClockwise, rotateCounterClockwise])
        let repeatRotation = SKAction.repeatForever(rotationSequence)
        rotatingBall.run(repeatRotation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireKnife()
    }
    
    //knife
    func fireKnife() {
        guard remainingKnives > 0 || !gameIsOver else { return }
        viewModel!.knifeThrown()
        let knifeTexture = SKTexture(imageNamed: "knifeImage")
        let knife = KnifeNode(texture: knifeTexture)
        knife.size = knifeSize
        knife.position = knifeTemplate.position
        knife.name = "knife"
        knife.isStuck = false  // Новый нож еще не зафиксирован

        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: knifeSize.width - 14, height: knifeSize.height - 10))
        knife.physicsBody = physicsBody
        knife.physicsBody?.categoryBitMask = knifeCategory
        knife.physicsBody?.contactTestBitMask = ballCategory | stuckKnifeCategory
        knife.physicsBody?.collisionBitMask = 0
        knife.physicsBody?.isDynamic = true
        knife.zPosition = -1
        knife.physicsBody?.affectedByGravity = false
        knife.physicsBody?.allowsRotation = false
        knife.physicsBody?.usesPreciseCollisionDetection = true
        addChild(knife)

        let moveUpAction = SKAction.moveTo(y: rotatingBall.position.y - (ballSize.height / 2), duration: 0.2)
        knife.run(moveUpAction)

        remainingKnives -= 1
        if remainingKnives == 0 {
            knifeTemplate.removeFromParent()
        }
    }

}

