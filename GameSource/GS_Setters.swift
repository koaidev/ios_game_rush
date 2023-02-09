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

extension GameScene {
    
    //MARK: - Setters
    func setCloud() {
        cloud.position = CGPoint(x: SettingsGlobal.width / 2, y: SettingsGlobal.height - (cloud.size.height / 2))
        if SettingsGlobal.isIPad {
            cloud.set(positionY: cloud.position.y + (cloud.size.height / 100 * 35))
        }
        addChild(cloud)
    }
    
    func setPlayer() {
        player.position = CGPoint(x: SettingsGlobal.width / 2, y: cloud.position.y - (cloud.size.height / 2) + (player.size.height / 2) + 1)
        playerShiftY = player.position.y
        addChild(player)
        
        if let particleSystem = SKEmitterNode(fileNamed: "PlayerParticle.sks") {
            particleSystem.targetNode = self
            player.addChild(particleSystem)
        }
    }
    
    func setBlock(withEnemy setEnemy: Bool, andCoin setCoin: Bool) {
        let blockLine = BlockLineNode(withSize: blockSize, positionY: blockPositionY, setEnemy: setEnemy, setCoin: setCoin)
        addChild(blockLine)
        arrayWithBlocks.append(blockLine)
    }
}
