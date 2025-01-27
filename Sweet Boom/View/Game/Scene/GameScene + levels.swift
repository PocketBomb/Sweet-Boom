
import SpriteKit

//MARK: - extension for level settings
extension GameScene {
    
    //MARK: - main function for level settings
    public func setupLevel(num: Int) {
        reloadLevel()//reload old scene
        setupScene()//scene settigns
        setupRotatingCandy(size: levelData.candieSize, imageName: levelData.candieImage)//candy

        setupKnifeTemplate()//maket
        setupBackground(imageName: levelData.backgroundImage)//back
        let numMod = (num % 5)
        //is it boss?
        if numMod != 0 {
            if num <= 5 {
                //first
                if num == 1 {
                    start1LevelRotation()
                //second
                } else if num == 2{
                    start2LevelRotation()
                } else {
                    //3..4
                    startCandyRotation(durationRight: Double.random(in: Double(2)...Double(5)), durationLeft: Double.random(in: Double(2)...Double(5)), speedRight: CGFloat.random(in: 1...3), speedLeft: CGFloat.random(in: 1...3))
                }
            //other(not boss), 6...
            } else {
                startCandyRotation(durationRight: Double.random(in: Double(2.3)...Double(4)), durationLeft: Double.random(in: Double(3)...Double(5)), speedRight: CGFloat.random(in: 1...7), speedLeft: CGFloat.random(in: 2...4))
            }
        //boss level settigns
        } else {
            startCandyRotation(durationRight: Double.random(in: Double(2)...Double(5)), durationLeft: Double.random(in: Double(2)...Double(5)), speedRight: CGFloat.random(in: 1...3), speedLeft: CGFloat.random(in: 1...3))
        }
    }
    
    
    //reload
    private func reloadLevel() {
        self.removeAllChildren()
        self.removeAllActions()
        self.gameIsOver = false
    }
    
    
    //template
    private func setupKnifeTemplate() {
        let knifeTexture = SKTexture(imageNamed: "knifeImage")
        knifeTemplate = SKSpriteNode(texture: knifeTexture)
        knifeTemplate.size = knifeSize
        knifeTemplate.position = CGPoint(x: frame.midX, y: ScreenData.shared.isSmallScreen ? frame.minY + 70 : frame.minY + 150)
        addChild(knifeTemplate)
    }
    
    
    //MARK: - Candy settings
    //size - size of ball
    //imageName - image of candy
    private func setupRotatingCandy(size: CGSize, imageName: String) {
        let ballTexture = SKTexture(imageNamed: imageName) // image
        let radius = size.width / 2
        rotatingCandy = SKSpriteNode(texture: ballTexture, size: size)
        rotatingCandy.position = CGPoint(x: frame.midX, y: frame.midY) //position
        rotatingCandy.scene?.backgroundColor = .clear
        rotatingCandy.physicsBody = SKPhysicsBody(circleOfRadius: radius) // radius
        rotatingCandy.physicsBody?.isDynamic = false
        rotatingCandy.physicsBody?.categoryBitMask = category.candyCategory //it is ball
        rotatingCandy.physicsBody?.contactTestBitMask = category.knifeCategory //contact with knife
        rotatingCandy.physicsBody?.collisionBitMask = 0
        rotatingCandy.zPosition = 0
        addChild(rotatingCandy)
    }
    
    //MARK: - First level
    func start1LevelRotation() {
        let rotateClockwise = SKAction.rotate(byAngle: -.pi * 3, duration: 4)
        let rotationSequence = SKAction.sequence([rotateClockwise])
        let repeatRotation = SKAction.repeatForever(rotationSequence)
        rotatingCandy.run(repeatRotation)
    }
    
    //MARK: - Second level
    func start2LevelRotation() {
        let rotateCounterClockwise = SKAction.rotate(byAngle: .pi * 3, duration: 4)
        let rotationSequence = SKAction.sequence([rotateCounterClockwise])
        let repeatRotation = SKAction.repeatForever(rotationSequence)
        rotatingCandy.run(repeatRotation)
    }
    
    //MARK: - Other level
    func startCandyRotation(durationRight: Double, durationLeft: Double, speedRight: CGFloat, speedLeft: CGFloat) {
        let rotateClockwise = SKAction.rotate(byAngle: .pi * speedRight, duration: durationRight)
        let rotateCounterClockwise = SKAction.rotate(byAngle: -.pi * speedLeft, duration: durationLeft)
        let rotationSequence = SKAction.sequence([rotateClockwise, rotateCounterClockwise])
        let repeatRotation = SKAction.repeatForever(rotationSequence)
        rotatingCandy.run(repeatRotation)
    }

    
    //MARK: - Knife moving
    func fireKnife() {
        //check current count knifes
        guard viewModel?.remainingKnifes ?? 0 > 0 || !gameIsOver else { return }
        viewModel!.knifeThrown()
        
        let knifeTexture = SKTexture(imageNamed: "knifeImage")
        let knife = KnifeNode(texture: knifeTexture)
        knife.size = knifeSize
        knife.position = knifeTemplate.position
        knife.name = "knife"
        knife.isStuck = false  // new knife not fixed in candy yet

        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: knifeSize.width - 14, height: knifeSize.height - 10))
        knife.physicsBody = physicsBody
        knife.physicsBody?.categoryBitMask = category.knifeCategory //it is knife
        knife.physicsBody?.contactTestBitMask = category.candyCategory | category.stuckKnifeCategory //contact with other knifes and candy
        knife.physicsBody?.collisionBitMask = 0
        knife.physicsBody?.isDynamic = true
        knife.zPosition = -1
        knife.physicsBody?.affectedByGravity = false
        knife.physicsBody?.allowsRotation = false
        knife.physicsBody?.usesPreciseCollisionDetection = true
        addChild(knife)

        //moving
        let moveUpAction = SKAction.moveTo(y: rotatingCandy.position.y - (200 / 2), duration: 0.2)
        knife.run(moveUpAction)

        if viewModel?.remainingKnifes == 0 && !gameIsOver {
            knifeTemplate.removeFromParent()
        }
    }
    
    //background
    func setupBackground(imageName: String) {
        let background = SKSpriteNode(imageNamed: imageName)
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -10 // do it behind other z Podition
        addChild(background)
    }
}
