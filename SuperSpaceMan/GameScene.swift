//
//  GameScene.swift
//  SuperSpaceMan
//
//  Created by Bharat Verma on 2023-05-17.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    /*
     create the game scene
     */
    
    //MARK: - Sprites
    let playerNode = SKSpriteNode(imageNamed: "Player")
    let backgroundNode = SKSpriteNode(imageNamed: "Background")
    let enemyNode1 = SKSpriteNode(imageNamed: "BlackHole0")
    let enemyNode2 = SKSpriteNode(imageNamed: "BlackHole1")
    let enemyNode3 = SKSpriteNode(imageNamed: "BlackHole2")
    let enemyNode4 = SKSpriteNode(imageNamed: "BlackHole3")
    let enemyNode5 = SKSpriteNode(imageNamed: "BlackHole4")
    let powerNode1 = SKSpriteNode(imageNamed: "PowerUp")
    let powerNode2 = SKSpriteNode(imageNamed: "PowerUp")
    
    var score: SKLabelNode!
    var gameOver: SKLabelNode!
    var youWon: SKLabelNode!
    var playerScore: Int = 10
    var scaleAction: SKAction!
    var scaleActionE5: SKAction!
    var moveAction: SKAction!
    var colorAction: SKAction!
    var rotateAction: SKAction!

    
    override init(size: CGSize) {
        super.init(size: size)
        //initializing the game scene
        
        physicsWorld.contactDelegate = self
        
        ///gravity
        physicsWorld.gravity = CGVector(dx: 0.00, dy: -1.8)
        
        //MARK: - Add Sprites into the game scene
        
        //Adding the background node to the Game Scene
        backgroundNode.position = CGPoint(x: size.width / 2.0, y: 0.0) //initial position of the node
        backgroundNode.size.width = frame.size.width //size of the node
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        addChild(backgroundNode)
        
        //Adding the player node to the scene
        playerNode.position = CGPoint(x: size.width / 2.0, y: size.height - 200)
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width / 2)
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.node?.name = "player"
        addChild(playerNode)
        
        //Adding the enemy node to the scene
        enemyNode1.position = CGPoint(x: size.width - 320.0, y: size.height - 200)
        enemyNode1.physicsBody = SKPhysicsBody(circleOfRadius: enemyNode1.size.width / 2)
        enemyNode1.physicsBody?.isDynamic = false
        enemyNode1.physicsBody?.node?.name = "enemy"
        addChild(enemyNode1)
        
        //Adding the enemy node to the scene
        enemyNode2.position = CGPoint(x: size.width - 320.0, y: size.height - 650)
        enemyNode2.physicsBody = SKPhysicsBody(circleOfRadius: enemyNode2.size.width / 2)
        enemyNode2.physicsBody?.isDynamic = false
        enemyNode2.physicsBody?.node?.name = "enemy"
        addChild(enemyNode2)
        
        //Adding the enemy node to the scene
        enemyNode3.position = CGPoint(x: size.width - 60, y: size.height - 650)
        enemyNode3.physicsBody = SKPhysicsBody(circleOfRadius: enemyNode3.size.width / 2)
        enemyNode3.physicsBody?.isDynamic = false
        enemyNode3.physicsBody?.node?.name = "enemy"
        addChild(enemyNode3)
        
        //Adding the enemy node to the scene
        enemyNode4.position = CGPoint(x: size.width - 60, y: size.height - 200)
        enemyNode4.physicsBody = SKPhysicsBody(circleOfRadius: enemyNode4.size.width / 2)
        enemyNode4.physicsBody?.isDynamic = false
        enemyNode4.physicsBody?.node?.name = "enemy"
        addChild(enemyNode4)
        
        //Adding the enemy node to the scene
        enemyNode5.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        enemyNode5.physicsBody = SKPhysicsBody(circleOfRadius: enemyNode5.size.width / 2)
        enemyNode5.physicsBody?.isDynamic = false
        enemyNode5.physicsBody?.node?.name = "enemy"
        addChild(enemyNode5)
        
        // adding the power node to the game scene
        powerNode1.position = CGPoint(x: size.width / 8.0, y: size.height - 350)
        powerNode1.physicsBody = SKPhysicsBody(circleOfRadius: powerNode1.size.width / 2)
        powerNode1.physicsBody?.isDynamic = false
        powerNode1.physicsBody?.node?.name = "power"
        addChild(powerNode1)
        
        powerNode2.position = CGPoint(x: size.width - 30.0, y: size.height - 500)
        powerNode2.physicsBody = SKPhysicsBody(circleOfRadius: powerNode2.size.width / 2)
        powerNode2.physicsBody?.isDynamic = false
        powerNode2.physicsBody?.node?.name = "power"
        addChild(powerNode2)
        
        //SKLabel: adding the label to the top of the screen which will display the player score
        score = SKLabelNode(fontNamed: "Chalkduster")
        score.text = "Score: \(playerScore)"
        score.fontSize = 40
        score.fontColor = SKColor.white
        score.position = CGPoint(x: size.width / 2.0, y: size.height - 100)
        addChild(score)
        
        gameOver = SKLabelNode(fontNamed: "Chalkduster")
        gameOver.text = "Game Over :("
        gameOver.fontSize = 45
        gameOver.fontColor = SKColor.white
        gameOver.position = CGPoint(x: size.width / 2.0, y: size.height - 300.0)
        addChild(gameOver)
        gameOver.isHidden = true
        
        youWon = SKLabelNode(fontNamed: "Chalkduster")
        youWon.text = "You Won!!! :)"
        youWon.fontSize = 45
        youWon.fontColor = SKColor.white
        youWon.position = CGPoint(x: size.width / 2.0, y: size.height - 300.0)
        addChild(youWon)
        youWon.isHidden = true
        
        //MARK: - Actions
        scaleAction = SKAction.scale(to: 4.0, duration: 4.0)
        scaleActionE5 = SKAction.scale(to: 2.0, duration: 4.0)
        colorAction = SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 3.0)
        rotateAction = SKAction.rotate(byAngle: 45.0, duration: 3.0)
        
        //MARK: - Particle Effects
        let particle = SKEmitterNode(fileNamed: "Bokeh.sks")
        let particleHeight = particle?.particlePositionRange.dy ?? 0
        let particleYPosition = -size.height / 2.0 + particleHeight / 3.5
        particle?.position = CGPoint(x: size.width / 2.0, y: particleYPosition)
        particle?.zPosition = 1
        particle?.physicsBody?.node?.name = "particle"
        particle?.physicsBody?.contactTestBitMask = particle?.physicsBody?.collisionBitMask ?? 0
        addChild(particle!)
        
        let rain = SKEmitterNode(fileNamed: "Rain.sks")
        let rainWidth = size.width
        rain?.position = CGPoint(x: size.width / 2.0, y: 800.0)
        rain?.particlePositionRange = CGVector(dx: rainWidth, dy: 0)
        rain?.zPosition = 1
        addChild(rain!)
        
        let smoke = SKEmitterNode(fileNamed: "Fire.sks")
        smoke?.position = CGPoint(x: 50, y: 50)
        smoke?.zPosition = 1
        addChild(smoke!)
        
        let smoke2 = SKEmitterNode(fileNamed: "Fire.sks")
        smoke2?.position = CGPoint(x: size.width - 50, y: 50)
        smoke2?.zPosition = 1
        addChild(smoke2!)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        //creating this below logic to move the playerNode horizontly
            
            let touchLocation = touch.location(in: self) //this will detect the touch location

        //if the touch location is less than the location of the player node that means the touch is on the left side
        //it will move to the left of screen by -5.0 point
        //similar logic to move the player node on the right side in the else part
            if touchLocation.x < playerNode.position.x {
                // Touch on the left side of the player node
                playerNode.physicsBody?.applyImpulse(CGVector(dx: -5.0, dy: 0.0))
                
            } else {
                // Touch on the right side of the player node
                playerNode.physicsBody?.applyImpulse(CGVector(dx: 5.0, dy: 0.0))
            }
       
        //MARK: - when tap the screen, the player's physics gets affaected
        playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.00, dy: 20.0))
        playerNode.physicsBody?.contactTestBitMask = playerNode.physicsBody?.collisionBitMask ?? 0
        enemyNode1.physicsBody?.contactTestBitMask = enemyNode1.physicsBody?.collisionBitMask ?? 0
        enemyNode2.physicsBody?.contactTestBitMask = enemyNode2.physicsBody?.collisionBitMask ?? 0
        
        //MARK: - Actions - use them to move, scae, rotate, abd color the sprites
        enemyNode1.run(SKAction.sequence([scaleAction, colorAction]))
        enemyNode1.run(SKAction.repeatForever(rotateAction))
        enemyNode2.run(SKAction.sequence([scaleAction, colorAction]))
        enemyNode2.run(SKAction.repeatForever(rotateAction))
        enemyNode3.run(SKAction.sequence([scaleAction, colorAction]))
        enemyNode3.run(SKAction.repeatForever(rotateAction))
        enemyNode4.run(SKAction.sequence([scaleAction, colorAction]))
        enemyNode4.run(SKAction.repeatForever(rotateAction))
        enemyNode5.run(SKAction.sequence([scaleActionE5, colorAction]))
        enemyNode5.run(SKAction.repeatForever(rotateAction))
       
    }
    
    //MARK: - function to detect the collision and player node behaviour on collission
    func collision(between playerNode: SKNode, object: SKNode){
        if object.name == "enemy"{
            if playerScore <= 0 {
                playerScore = 0
            }
            playerScore = playerScore - 10
            score.text = "Score: \(playerScore)"
        } else if object.name == "power"{
            if playerScore >= 100 {
                playerScore = 100
            }
            playerScore = playerScore + 5
            score.text = "Score: \(playerScore)"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player"{
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }else if(contact.bodyB.node?.name == "enemy") {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    //MARK: - overrriding the update function which will update the scene on each frame
    override func update(_ currentTime: TimeInterval) {
        let screenRect = CGRect(x: 0, y: 0, width: size.width, height: size.height) //intiallizing the screen size
        let isPlayerOutOfScreen = !screenRect.contains(playerNode.position) //checking the player is out of screen or not
        
        if isPlayerOutOfScreen {
            // Player node is out of the screen
            if playerNode.position.x > size.width {
                // Player went out of bounds to the right and it will set its new position to the left
                playerNode.position.x = 0
            } else if playerNode.position.x < 0{
                //if player is out from left side than its original position will be rigth
                playerNode.position.x = size.width
            }
            else {
                // Player went out of bounds to the top, or bottom
                score.text = "Score: \(playerScore)"
                playerNode.removeFromParent()
                gameOver.isHidden = false
            }
        }
        
        if playerScore >= 100 {
            playerNode.removeFromParent()
            playerScore = 100
            youWon.isHidden = false
        } else if playerScore <= 0 {
            score.text = "Score: 0"
            playerNode.removeFromParent()
            gameOver.isHidden = false
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
