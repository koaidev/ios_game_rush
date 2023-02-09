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

class BlockNode: SimpleSprite {
    
    enum BlockType {
        case ground
        case coin
        case enemy
    }
    public var blockType = BlockType.ground
    
    //MARK: - Inititalisations
    /**
     Initialisation enemy
     - parameter texture: SKTexture object with texture for enemy.
     - parameter size: CGSize object for set size of enemy.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(withSize sizeSide: CGFloat, positionX: CGFloat, withType newType: BlockType) {
        super.init(texture: GraphicPreloadsGame.preload.ground1, size: CGSize(width: sizeSide, height: sizeSide), position: CGPoint(x: positionX, y: 0.0), zPosition: SettingsScenes.Game.ZPosition.block)
        
        blockType = newType
        loadTexture()
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width / 100 * 80, height: size.height / 100 * 80))
        physicsBody?.affectedByGravity = false
        physicsBody?.mass = 1
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = SettingsPhysicsBody.Id.enemy
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    
    func loadTexture() {
        switch blockType {
        case .enemy:
            texture = GraphicPreloadsGame.preload.enemy
        case .ground:
            switch Int(from: 1, to: 4) {
            case 1:
                texture = GraphicPreloadsGame.preload.ground1
            case 2:
                texture = GraphicPreloadsGame.preload.ground2
            case 3:
                texture = GraphicPreloadsGame.preload.ground3
            case 4:
                texture = GraphicPreloadsGame.preload.ground4
            default:
                break;
            }
        case .coin:
            texture = GraphicPreloadsGame.preload.coinBlock
        }
    }
    
    //MARK: - Your features
    
}
