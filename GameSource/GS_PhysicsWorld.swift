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
    
    /** Create physic world.*/
    func createPhysicsWorld() {
        ///Create gravity vector and add phisics world delegates to scene object
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        ///Create border
        ///physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
    }
    
    /** Its will be called when physicbody has contact.*/
    func didBegin(_ contact: SKPhysicsContact) {
        ///Get contact bodys
        let bodyFirst = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB
        let bodySecond = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyB : contact.bodyA
        
        ///Recognise first body categorys
        switch bodyFirst.categoryBitMask {
        case SettingsPhysicsBody.Id.player:
            if let bodySecondNode = bodySecond.node as? SKSpriteNode {
                player(contactTo: bodySecondNode, withContactPoint: contact.contactPoint)
            }
        default:
            break
        }
    }
    
    //MARK: Different contact types by first body node
    fileprivate func player(contactTo contactNode: SKSpriteNode, withContactPoint contactPoint: CGPoint) {
        switch contactNode.physicsBody?.categoryBitMask {
        case SettingsPhysicsBody.Id.enemy:
            contactNode.physicsBody = nil
            let block = contactNode as! BlockNode
            
            switch block.blockType {
            case .ground:
                contactNode.removeFromParent()
                increaseScoreBy(1)
                
                increaseGameSpeeds()
                
                setAnimationExplosion(toPosition: contactPoint, isSecondExplosion: false)
            case .enemy:
                player.kill()
                
                setAnimationExplosion(toPosition: contactPoint, isSecondExplosion: true)
                gameOver()
                
                Sound.preload.playSound(.smash2)
            case .coin:
                setAnimationCoin(fromPosition: contactNode.position)
                contactNode.removeFromParent()
                increaseCoinsBy(1)
            }
        default:
            break
        }
    }
}
