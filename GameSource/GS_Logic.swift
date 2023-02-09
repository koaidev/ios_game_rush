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
    
    //MARK: - Game progress
    /** Start game object. Prepare your game object here*/
    func gameStart() {
        createPhysicsWorld()
        
        setCloud()
        calculateBlockSizes()
        
        setPlayer()
        
        preloads()
        tryToGenerateBlockWithTimer();
    }
    
    /** End game method. Save all game results here. */
    func gameOver() {
        if isPlay {
            isPlay = false
            
            saveScore()
            makeScreenshot()
            if SettingsGameProcess.swipeInput {
                view?.gestureRecognizers?.forEach((view?.removeGestureRecognizer)!)
            }
            
            loadSceneEndWithDelay()
        }
    }
    
    //MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        player.moveDown(withSpeed: playerSpeed)
    }
    
    override func didFinishUpdate() {
        tryToMoveCamera()
    }
    
    //MARK: Generators
    
    func preloads() {
        for _ in 0...40 {
            tryToGenerateBlocks()
        }
    }
    
    func tryToGenerateBlocks() {
        if player.position.y > blockPositionY - SettingsGlobal.height {
            var isEnemyLine = false
            var isCoinLine = false
            linesToSetEnemy -= 1
            linesToSetCoin -= 1
            if linesToSetEnemy <= 0 {
                linesToSetEnemy = Int(from: SettingsGameProcess.Block.Enemy.AfterLines.from, to: SettingsGameProcess.Block.Enemy.AfterLines.to)
                
                isEnemyLine = true
            }
            if linesToSetCoin <= 0 {
                linesToSetCoin = Int(from: SettingsGameProcess.Block.Coin.AfterLines.from, to: SettingsGameProcess.Block.Coin.AfterLines.to)
                
                isCoinLine = true
            }
            
            setBlock(withEnemy: isEnemyLine, andCoin: isCoinLine)
            
            blockPositionY -= blockSize
        }
    }
    
    @objc func tryToGenerateBlockWithTimer() {
        if isPlay {
            tryToGenerateBlocks()
            tryToRemoveOldBlocks()
            
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tryToGenerateBlockWithTimer), userInfo: nil, repeats: false)
        }
    }
    
    //MARK: - Cleaners
    
    func tryToRemoveOldBlocks() {
        let blockLine = arrayWithBlocks.first
        if blockLine!.position.y > camera!.position.y + (SettingsGlobal.height / 2) + (blockSize / 2) {
            blockLine!.removeFromParent()
            arrayWithBlocks.removeFirst()
        }
    }
    
    //MARK: - Game actions
    
    
}
