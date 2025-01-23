
import SpriteKit

extension GameScene {
    
    public func setupLevel(num: Int) {
        reloadLevel()
        setupScene()
        let numMod = (num % 5)
        print(num)
        
        if numMod != 0 {
            if num <= 5 {
                setupRotatingBall(size: levelData.candieSize, imageName: levelData.candieImage)
                startBallRotation(durationRight: Double.random(in: Double(2)...Double(5)), durationLeft: Double.random(in: Double(2)...Double(5)), speedRight: CGFloat.random(in: 1...3), speedLeft: CGFloat.random(in: 1...3))
                setupKnifeTemplate()
                setupBackground(imageName: levelData.backgroundImage)
            } else {
                setupRotatingBall(size: levelData.candieSize, imageName: levelData.candieImage)
                startBallRotation(durationRight: Double.random(in: Double(2.3)...Double(4)), durationLeft: Double.random(in: Double(3)...Double(5)), speedRight: CGFloat.random(in: 1...7), speedLeft: CGFloat.random(in: 2...4))
                setupKnifeTemplate()
                setupBackground(imageName: levelData.backgroundImage)
            }
        } else {
            setupRotatingBall(size: levelData.candieSize, imageName: levelData.candieImage)
            startBossRotation(durationRight: Double.random(in: Double(2)...Double(5)), durationLeft: Double.random(in: Double(2)...Double(5)), speedRight: CGFloat.random(in: 1...3), speedLeft: CGFloat.random(in: 1...3))
            setupKnifeTemplate()
            setupBackground(imageName: levelData.backgroundImage)
        }
    }
    
    
    
    private func reloadLevel() {
        self.removeAllChildren()
        self.removeAllActions()
        self.gameIsOver = false
    }
    
    
    // template
    private func setupKnifeTemplate() {
        let knifeTexture = SKTexture(imageNamed: "knifeImage")
        knifeTemplate = SKSpriteNode(texture: knifeTexture)
        knifeTemplate.size = knifeSize
        knifeTemplate.position = CGPoint(x: frame.midX, y: frame.minY + 150)
        addChild(knifeTemplate)
    }
    
    
    //MARK: - Candy settings
    //size - size of ball
    //imageName - image of candy
    private func setupRotatingBall(size: CGSize, imageName: String) {
        let ballTexture = SKTexture(imageNamed: imageName) // image
    
        rotatingCandy = SKSpriteNode(texture: ballTexture, size: size) //init
        rotatingCandy.position = CGPoint(x: frame.midX, y: frame.midY) //position
        
        let radius = size.width / 2
        rotatingCandy.scene?.backgroundColor = .clear
        rotatingCandy.physicsBody = SKPhysicsBody(circleOfRadius: radius) // radius
        rotatingCandy.physicsBody?.isDynamic = false
        rotatingCandy.physicsBody?.categoryBitMask = ballCategory
        rotatingCandy.physicsBody?.contactTestBitMask = knifeCategory
        rotatingCandy.physicsBody?.collisionBitMask = 0
        rotatingCandy.zPosition = 0
        addChild(rotatingCandy)
    }
    
    func startBallRotation(durationRight: Double, durationLeft: Double, speedRight: CGFloat, speedLeft: CGFloat) {
        let rotateClockwise = SKAction.rotate(byAngle: .pi * speedRight, duration: durationRight)
        let rotateCounterClockwise = SKAction.rotate(byAngle: -.pi * speedLeft, duration: durationLeft)
        let rotationSequence = SKAction.sequence([rotateClockwise, rotateCounterClockwise])
        let repeatRotation = SKAction.repeatForever(rotationSequence)
        rotatingCandy.run(repeatRotation)
    }
    
    func startBossRotation(durationRight: Double, durationLeft: Double, speedRight: CGFloat, speedLeft: CGFloat) {
        // Вращение по часовой стрелке
        let rotateClockwise = SKAction.rotate(byAngle: .pi * speedRight, duration: durationRight)
        
        // Вращение против часовой стрелки
        let rotateCounterClockwise = SKAction.rotate(byAngle: -.pi * speedLeft, duration: durationLeft)
        
        // Перемещение вправо (на 100 px)
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 0.3)  // Уменьшили время перемещения
        // Перемещение влево (на 100 px)
        let moveLeft = SKAction.moveBy(x: -100, y: 0, duration: 0.3)  // Уменьшили время перемещения
        
        // Создаем последовательность: вращение + перемещение вправо + вращение в обратную сторону + перемещение влево
        let moveAndRotateSequence = SKAction.sequence([rotateClockwise, moveRight, rotateCounterClockwise, moveLeft])
        
        // Запускаем повторяющуюся анимацию
        let repeatMoveAndRotate = SKAction.repeatForever(moveAndRotateSequence)
        
        rotatingCandy.run(repeatMoveAndRotate)
    }


    
    //knife
    func fireKnife() {
        guard viewModel?.remainingKnives ?? 0 > 0 || !gameIsOver else { return }
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

        let moveUpAction = SKAction.moveTo(y: rotatingCandy.position.y - (ballSize.height / 2), duration: 0.2)
        knife.run(moveUpAction)

        if viewModel?.remainingKnives == 0 && !gameIsOver {
            knifeTemplate.removeFromParent()
        }
    }
    
    func setupBackground(imageName: String) {
        let background = SKSpriteNode(imageNamed: imageName)
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -10 // do it behind other z Podition
        addChild(background)
    }
}
