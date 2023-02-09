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

class BlockLineNode: SimpleSprite {
    
    var blocks = [BlockNode]()
    
    var sizeWidth: CGFloat = 0
    var isSetEnemy = false
    var isSetCoin = false
    
    //MARK: - Inititalisations
    /**
     Initialisation enemy
     - parameter texture: SKTexture object with texture for enemy.
     - parameter size: CGSize object for set size of enemy.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(withSize sizeSide: CGFloat, positionY: CGFloat, setEnemy: Bool, setCoin: Bool) {
        super.init(texture: GraphicPreloadsGame.preload.transparent, size: CGSize.zero, position: CGPoint(x: SettingsGlobal.width / 2, y: positionY), zPosition: SettingsScenes.Game.ZPosition.block)
        isSetEnemy = setEnemy
        isSetCoin = setCoin
        sizeWidth = sizeSide
        
        generateBlocks()
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    
    //MARK: - Your features
    
    func generateBlocks() {
        var positionX = -(SettingsGlobal.width / 2) + (sizeWidth / 2)
        
        var indexEnemy = 0
        var indexCoin = 0
        var isSameIndex = true
        while isSameIndex == true {
            indexEnemy = Int(from: 0, to: SettingsGameProcess.Block.count)
            indexCoin = Int(from: 0, to: SettingsGameProcess.Block.count)
            
            if indexEnemy != indexCoin {
                isSameIndex = false
            }
        }
        
        for i in 0..<SettingsGameProcess.Block.count {
            var blockType = BlockNode.BlockType.ground
            if isSetEnemy {
                if i == indexEnemy {
                    blockType = .enemy
                }
            }
            if isSetCoin {
                if i == indexCoin {
                    blockType = .coin
                }
            }
            
            let block = BlockNode(withSize: sizeWidth, positionX: positionX, withType: blockType)
            addChild(block)
            blocks.append(block)
            
            positionX += sizeWidth
        }
    }
}
