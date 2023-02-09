/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import SpriteKit

class PlayerNode: SimpleSprite {
    
    var isLive = true
    
    //MARK: - Initialisations
    /** Initialisation of player node.*/
    init() {
        super.init(texture: GraphicPreloadsGame.preload.player1, size: SettingsScenes.Game.Size.player, position: SettingsScenes.Game.Position.player, zPosition: SettingsScenes.Game.ZPosition.player)
        loadSkin()
        
        physicsBody = SKPhysicsBody(texture: GraphicPreloadsGame.preload.player1, size: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 999
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = SettingsPhysicsBody.Id.player
        physicsBody?.contactTestBitMask = SettingsPhysicsBody.Id.enemy
    }
    
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    
    //MARK: - Player state
    /** This function load current selected skin to player node.*/
    private func loadSkin() {
        if SettingsGlobal.Skins.on {
            switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
            case 2: texture = GraphicPreloadsGame.preload.player2
            case 3: texture = GraphicPreloadsGame.preload.player3
            case 4: texture = GraphicPreloadsGame.preload.player4
            default: texture = GraphicPreloadsGame.preload.player1
            }
        }
    }
    
    //MARK: - Your features
    
    public func moveDown(withSpeed speed: Double) {
        if isLive {
            physicsBody!.velocity = CGVector(dx: physicsBody!.velocity.dx, dy: -speed)
        }
    }
    
    public func moveSide(toPositionX positionX: Double, withSpeed speed: Double) {
        //Check limits
        if position.x + size.width / 2 > SettingsGlobal.width {
            set(positionX: SettingsGlobal.width - size.width / 2)
            return
        }
        if position.x - size.width / 2 < 0.0 {
            set(positionX: size.width / 2)
            return
        }
        
        //Move
        if isLive {
            let moveLeft = position.x > positionX
            
            physicsBody!.velocity = CGVector(dx: moveLeft ? -speed : speed, dy: physicsBody!.velocity.dy)
        }
        
        calcRotation(toPositionX: positionX)
    }
    
    public func stopSideMoving() {
        physicsBody!.velocity = CGVector(dx: 0.0, dy: physicsBody!.velocity.dy)
        
        calcRotation(toPositionX: position.x)
    }
    
    public func calcRotation(toPositionX positionX: Double) {
        let rotation = SettingsGameProcess.Player.rotation
        let diff = positionX - position.x
        let percentage = 100.0 / SettingsGlobal.width * diff
        
        let rotateToAngle = rotation / 100.0 * percentage
        
        self.zRotation = CGFloat(degreeToRadian: rotateToAngle)
    }
    
    public func kill() {
        isLive = false;
        
        run(SKAction.scale(to: 0.0, duration: 0.1))
    }
}
