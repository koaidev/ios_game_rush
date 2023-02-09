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

class EndScene: GlobalScene {
    
    private var indicatorButtonStoreOnScene = false
    
    //MARK: Nodes
    private let logo = LogoNode(withType: .menu)
    
    private let coinsIndicator = SimpleSprite(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.End.Size.coinsIndicator, position: SettingsScenes.End.Position.coinsIndicator, zPosition: SettingsScenes.End.ZPosition.coinsIndicator)
    
    private let labelScore = SimpleLabel(text: NSLocalizedString("endScene_CurrentScore", comment: "") + String(UserDefaults.standard.integer(forKey: "CurrentScore")), fontSize: SettingsScenes.End.FontSize.labelScore, fontColorHex: SettingsScenes.End.FontColor.labelScore, position: SettingsScenes.End.Position.labelScore, zPosition: SettingsScenes.End.ZPosition.labelScore)
    private let labelBestScore = SimpleLabel(text: NSLocalizedString("endScene_BestScore", comment: "") + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.End.FontSize.labelBestScore, fontColorHex: SettingsScenes.End.FontColor.labelBestScore, position: SettingsScenes.End.Position.labelBestScore, zPosition: SettingsScenes.End.ZPosition.labelBestScore)
    private let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.End.FontSize.labelCoins, fontColorHex: SettingsScenes.End.FontColor.labelCoins, position: SettingsScenes.End.Position.labelCoins, zPosition: SettingsScenes.End.ZPosition.labelCoins)
    
    private let buttonMenu = ButtonNode(defaultWithType: .menu)
    private let buttonRestart = ButtonNode(defaultWithType: .restart)
    private let buttonShare = ButtonNode(defaultWithType: .share)
    private let buttonGameCenter = ButtonNode(defaultWithType: .gameCenter)
    private let buttonStore = ButtonNode(defaultWithType: .store)

    private let indicatorButtonStore = SimpleSprite(texture: GraphicPreloadsInterface.preload.indicatorButtonStore, size: SettingsScenes.End.Size.indicatorButtonStore, position: SettingsScenes.End.Position.indicatorButtonStore, zPosition: SettingsScenes.End.ZPosition.indicatorButtonStore)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Work with some external functions.
        ExternalFunctions.getLeaderboard()
        ExternalFunctions.getWorldBestScore()
        ExternalFunctions.rateUsAfterGame()
        
        setInterface()
        runAnimations()
    }
    
    //MARK: - Work with interface
    
    private func setInterface() {
        InterfaceExtention.put(nodesWithArray: [buttonMenu, buttonRestart], atPosition: SettingsScenes.End.Position.button_Menu_Restart, withSpaceBetween: SettingsScenes.End.Position.space_button_Menu_Restart, andSortHorizontal: false)
        InterfaceExtention.put(nodesWithArray: [buttonShare, buttonGameCenter], atPosition: SettingsScenes.End.Position.button_Share_GameCenter, withSpaceBetween: SettingsScenes.End.Position.space_button_Share_GameCenter, andSortHorizontal: false)
        
        ///Settings node
        labelCoins.horizontalAlignmentMode = .left
        if UserDefaults.standard.bool(forKey: "_newBestScore") {
            labelScore.text = "You set new best score!"
        }
        
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        labelScore.setShadowDefault()
        labelBestScore.setShadowDefault()
        
        ///Add node to scene
        addChild([background, logo, labelScore, labelBestScore, buttonMenu, buttonRestart, buttonShare, buttonGameCenter])
        if SettingsGlobal.InApp.on || SettingsGlobal.Skins.on {
            addChild(buttonStore)
            if SettingsGlobal.Skins.on {
                addChild([coinsIndicator, labelCoins])
            }
        }
        
        ///Cet coin indicator and run animations
        if UserDefaults.standard.integer(forKey: "Coins") >= SkinValues.getMinimalPrice() {
            if SettingsGameProcess.Interface.Menu.IndicatorStore.on {
                if SettingsGlobal.Skins.on {
                    indicatorButtonStoreOnScene = true
                    buttonStore.addChild(indicatorButtonStore)
                }
            }
        }
    }
    
    //MARK: - Animations
    /** Run start scene animations*/
    private func runAnimations() {
        if SettingsGameProcess.Interface.End.sceneInterfaceAnimationOn {
            buttonRestart.repeatActionPulse(toSize: SettingsGameProcess.Interface.End.buttonRestartPulseTo, time: SettingsGameProcess.Interface.End.buttonRestartPulseSpeed)
            
            if indicatorButtonStoreOnScene {
                indicatorButtonStore.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.scale(to: SettingsGameProcess.Interface.Menu.IndicatorStore.scaleTo, duration: SettingsGameProcess.Interface.Menu.IndicatorStore.speed / 2),
                        SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.IndicatorStore.speed / 2)])))
            }
        }
    }
    
    //MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            ///Change button state to simple
            touchUpAllButtons()
            
            if buttonMenu.contains(location) || buttonRestart.contains(location) || buttonStore.contains(location) {
                ExternalFunctions.hideLeaderboard()
                buttonStore.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
                buttonMenu.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                buttonRestart.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
            }
            buttonShare.actionShare(ifInLocation: location)
            buttonGameCenter.actionShowGameCenter(ifInLocation: location)
        }
    }
}
