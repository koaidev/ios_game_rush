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
    
    /** Set interface nodes.*/
    func setInterface() {
        ///Settings node
        scaleBackgroundAtTapToScreen = false
        coinsIndicator.setInterfaceSize()
        labelCoins.horizontalAlignmentMode = .left
        labelScore.setShadowDefault()
        buttonRestart.removeFromViewedPoint()
        buttonMenu.removeFromViewedPoint()
        buttonContinue.removeFromViewedPoint()
        
        ///Add nodes to scene
        addChild([background, interfaceHolder])
        
        interfaceHolder.addChild(labelScore)
        if SettingsGlobal.Skins.on {
            interfaceHolder.addChild([coinsIndicator, labelCoins])
            labelScore.position = SettingsScenes.Game.Position.labelScoreWithCoins
        }
        
        if SettingsGlobal.Pause.on { interfaceHolder.addChild(buttonPause)}
        else { buttonPause.removeFromViewedPoint()}
    }
    
    func tryToInitSwipeInput() {
        if SettingsGameProcess.swipeInput {
            swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeLeft))
            swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeRight))
            swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeDown))
            swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeUp))
            swipeLeft?.direction = UISwipeGestureRecognizer.Direction.left
            swipeRight?.direction = UISwipeGestureRecognizer.Direction.right
            swipeDown?.direction = UISwipeGestureRecognizer.Direction.down
            swipeUp?.direction = UISwipeGestureRecognizer.Direction.up
            view!.addGestureRecognizer(swipeLeft!)
            view!.addGestureRecognizer(swipeRight!)
            view!.addGestureRecognizer(swipeDown!)
            view!.addGestureRecognizer(swipeUp!)
        }
    }
    
    //MARK: - Change scene
    func loadSceneEndWithDelay() {
        Timer.scheduledTimer(timeInterval: SettingsGameProcess.delayLoadSceneIfLose, target: self, selector: #selector(loadSceneEnd), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func loadSceneEnd() {
        ///Switch music back
        Sound.preload.musicSwitch(toMusicType: .menu)
        
        //Load scene
        loadScene(.end, withTransitionName: .pushLeft)
    }
    
    //MARK: - Camera
    func initCamera() {
        currentCamera = SKCameraNode()
        camera = currentCamera
        currentCamera.position = CGPoint(x: SettingsGlobal.width / 2, y: SettingsGlobal.height / 2)
        addChild(currentCamera)
    }
    
    func tryToMoveCamera() {
        if SettingsGameProcess.followCameraToPlayer {
            let positionCameraX = SettingsGameProcess.followCameraToPlayerByX ? player.position.x - (SettingsGlobal.width / 2) + (SettingsScenes.Game.Position.player.x)  : SettingsGlobal.width / 2
            let positionCameraY = SettingsGameProcess.followCameraToPlayerByY ? player.position.y + ((SettingsGlobal.height / 2) - playerShiftY) : SettingsGlobal.height / 2
            let positionCamera = CGPoint(x: positionCameraX, y: positionCameraY)
            
            camera!.position = positionCamera
            interfaceHolder.position = CGPoint(x: currentCamera.position.x - SettingsGlobal.width / 2, y: currentCamera.position.y - SettingsGlobal.height / 2)
            background.position = camera!.position
        }
    }
}
