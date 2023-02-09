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

class GameScene: GlobalScene, SKPhysicsContactDelegate {
    
    //MARK: Values
    var isPlay = true
    var score = 0
    
    var playerSpeed = SettingsGameProcess.Player.Speed.start
    
    var arrayWithBlocks = [BlockLineNode]()
    
    var changeSceneToMenuInPauseMenu = true
    
    var blockSize: CGFloat = 0
    var blockPositionY: CGFloat = 0
    
    var linesToSetEnemy = SettingsGameProcess.Block.Enemy.startAfter
    var linesToSetCoin = SettingsGameProcess.Block.Coin.AfterLines.to
    
    var playerShiftY: CGFloat = 0
    
    //MARK: Recognisers
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    
    //MARK: Interface Nodes
    var currentCamera: SKCameraNode = SKCameraNode()
    
    var pauseBackground = SimpleSprite(texture: GraphicPreloadsGame.preload.pauseBackground, size: SettingsScenes.Game.Size.pauseBackground, position: SettingsScenes.Game.Position.pauseBackground, zPosition: SettingsScenes.Game.ZPosition.pauseBackground)
    var interfaceHolder = TransparentSprite(size: SettingsScenes.Game.Size.interfaceHolder, position: SettingsScenes.Game.Position.interfaceHolder, zPosition: SettingsScenes.Game.ZPosition.interfaceHolder)

    var coinsIndicator = SimpleSprite(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Game.Size.coinsIndicator, position: SettingsScenes.Game.Position.coinsIndicator, zPosition: SettingsScenes.Game.ZPosition.coinsIndicator)
    
    var buttonPause = ButtonNode(defaultWithType: .pause)
    var buttonRestart = ButtonNode(defaultWithType: .restart)
    var buttonMenu = ButtonNode(defaultWithType: .menu)
    var buttonContinue = ButtonNode(defaultWithType: .pcontinue)
    
    var labelScore = SimpleLabel(text: "0", fontSize: SettingsScenes.Game.FontSize.labelScore, fontColorHex: SettingsScenes.Game.FontColor.labelScore, position: SettingsScenes.Game.Position.labelScoreNoCoins, zPosition: SettingsScenes.Game.ZPosition.labelScore)
    var labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Game.FontSize.labelCoins, fontColorHex: SettingsScenes.Game.FontColor.labelCoins, position: SettingsScenes.Game.Position.labelCoins, zPosition: SettingsScenes.Game.ZPosition.labelCoins)
    
    var textPause = LogoSmallNode(withType: .pause)
    
    //MARK: Game Nodes
    var cloud = SimpleSprite(texture: GraphicPreloadsGame.preload.cloud, size: SettingsScenes.Game.Size.cloud, position: SettingsScenes.Game.Position.cloud, zPosition: SettingsScenes.Game.ZPosition.cloud)
    
    var player = PlayerNode()
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Init game components
        initCamera()
        tryToInitSwipeInput()
        Sound.preload.musicSwitch(toMusicType: .game)
        setInterface()
        
        ///Start game
        gameStart()
    }
    
    //MARK: - Inputs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPlay {
            for touch in touches {
                let location = touch.location(in: self)
                let locationInterfaceHolder = touch.location(in: interfaceHolder)
                
                ///Game inputs
                if !buttonPause.contains(locationInterfaceHolder) && !buttonMenu.contains(locationInterfaceHolder) && !buttonRestart.contains(locationInterfaceHolder) && !buttonContinue.contains(locationInterfaceHolder) {
                    player.moveSide(toPositionX: location.x, withSpeed: playerSpeed)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPlay {
            for touch in touches {
                let location = touch.location(in: self)
                let locationInterfaceHolder = touch.location(in: interfaceHolder)
                
                ///Game inputs
                if !buttonPause.contains(locationInterfaceHolder) && !buttonMenu.contains(locationInterfaceHolder) && !buttonRestart.contains(locationInterfaceHolder) && !buttonContinue.contains(locationInterfaceHolder) {
                    player.moveSide(toPositionX: location.x, withSpeed: playerSpeed)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            ///let location = touch.location(in: self)
            let locationInterfaceHolder = touch.location(in: interfaceHolder)
            
            ///Interface
            ///Change button state to simple
            touchUpAllButtons()
            if buttonPause.contains(locationInterfaceHolder) {
                pauseGame()
            }
            else {
                player.stopSideMoving()
            }
            if scene?.view?.isPaused == true {
                if buttonMenu.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: true)
                }
                if buttonRestart.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: false)
                }
                if buttonContinue.contains(locationInterfaceHolder) {
                    continueGame()
                }
            }
        }
    }
    
    //MARK: Swipe inputs
    @objc func inputSwipeLeft() {
        if isPlay {}
    }
    
    @objc func inputSwipeRight() {
        if isPlay {}
    }
    
    @objc func inputSwipeDown() {
        if isPlay {}
    }
    
    @objc func inputSwipeUp() {
        if isPlay {}
    }
}
