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

class TutorialScene: GlobalScene {
    
    //MARK: Nodes
    private let indicatorCloseTutorial = SimpleSprite(texture: GraphicPreloadsInterface.preload.indicatorCloseTutorial, size: SettingsScenes.Tutorial.Size.indicatorCloseTutorial, zPosition: SettingsScenes.Tutorial.ZPosition.indicatorCloseTutorial)
    private let labelCloseMessage = SimpleLabel(text: NSLocalizedString("tutorialScene_CloseMessage", comment: ""), fontSize: SettingsScenes.Tutorial.FontSize.labelCloseMessage, fontColorHex: SettingsScenes.Tutorial.FontColor.labelCloseMessage, position: SettingsScenes.Tutorial.Position.labelCloseMessage, zPosition: SettingsScenes.Tutorial.ZPosition.labelCloseMessage)
    
    private let textFieldContent1 = TextField(withText: NSLocalizedString("tutorialScene_Content1", comment: ""), widthSize: SettingsScenes.Tutorial.Size.textFieldContent1Widht, spaceBetweenLabels: SettingsScenes.Tutorial.Position.textFieldContent1SpaceBetweenLabels, fontSize: SettingsScenes.Tutorial.FontSize.textFieldContent1, fontColor: SettingsScenes.Tutorial.FontColor.textFieldContent1, position: SettingsScenes.Tutorial.Position.textFieldContent1, zPosition: SettingsScenes.Tutorial.ZPosition.textFieldContent1)
    private let textFieldContent2 = TextField(withText: NSLocalizedString("tutorialScene_Content2", comment: ""), widthSize: SettingsScenes.Tutorial.Size.textFieldContent2Widht, spaceBetweenLabels: SettingsScenes.Tutorial.Position.textFieldContent2SpaceBetweenLabels, fontSize: SettingsScenes.Tutorial.FontSize.textFieldContent2, fontColor: SettingsScenes.Tutorial.FontColor.textFieldContent2, position: SettingsScenes.Tutorial.Position.textFieldContent2, zPosition: SettingsScenes.Tutorial.ZPosition.textFieldContent2)
    private let textFieldContent3 = TextField(withText: NSLocalizedString("tutorialScene_Content3", comment: ""), widthSize: SettingsScenes.Tutorial.Size.textFieldContent3Widht, spaceBetweenLabels: SettingsScenes.Tutorial.Position.textFieldContent3SpaceBetweenLabels, fontSize: SettingsScenes.Tutorial.FontSize.textFieldContent3, fontColor: SettingsScenes.Tutorial.FontColor.textFieldContent3, position: SettingsScenes.Tutorial.Position.textFieldContent3, zPosition: SettingsScenes.Tutorial.ZPosition.textFieldContent3)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        UserDefaults.standard.set(true, forKey: "TutorialWasShown")
        
        setInterface()
        runAnimations()
    }
    
    //MARK: - Work with interface
    
    private func setInterface() {
        indicatorCloseTutorial.setToCenterByX()
        indicatorCloseTutorial.setToBorderOfScreenDownIncludeObjectSize()
        
        ///Add nodes to scene
        addChild([background, indicatorCloseTutorial, labelCloseMessage])
        addChild([textFieldContent1, textFieldContent2, textFieldContent3])
        
        //Setting nodes
        labelCloseMessage.setShadowDefault()
        textFieldContent1.setShadowDefault()
        textFieldContent2.setShadowDefault()
        textFieldContent3.setShadowDefault()
    }
    
    private func runAnimations() {
        let oldPositionIndicatorCloseTutorial = indicatorCloseTutorial.position.y
        indicatorCloseTutorial.set(positionY: indicatorCloseTutorial.position.y - indicatorCloseTutorial.size.height)
        indicatorCloseTutorial.run(SKAction.moveTo(y: oldPositionIndicatorCloseTutorial, duration: SettingsGameProcess.Interface.Tutorial.IndicatorCloseTutorial.showTime))
        
        let labelCloseMessageOldPosition = labelCloseMessage.position.y
        let textFieldContent1OldPosition = textFieldContent1.position.y
        let textFieldContent2OldPosition = textFieldContent2.position.y
        let textFieldContent3OldPosition = textFieldContent3.position.y
        labelCloseMessage.change(positionY: -SettingsGlobal.height)
        textFieldContent1.change(positionY: SettingsGlobal.height)
        textFieldContent2.change(positionY: SettingsGlobal.height)
        textFieldContent3.change(positionY: SettingsGlobal.height)
        labelCloseMessage.run(SKAction.moveTo(y: labelCloseMessageOldPosition, duration: SettingsGameProcess.Interface.Tutorial.Labels.showTime))
        textFieldContent1.run(SKAction.moveTo(y: textFieldContent1OldPosition, duration: SettingsGameProcess.Interface.Tutorial.Labels.showTime))
        textFieldContent2.run(SKAction.moveTo(y: textFieldContent2OldPosition, duration: SettingsGameProcess.Interface.Tutorial.Labels.showTime))
        textFieldContent3.run(SKAction.moveTo(y: textFieldContent3OldPosition, duration: SettingsGameProcess.Interface.Tutorial.Labels.showTime))
        
        labelCloseMessage.run(SKAction.repeatForever(
                                SKAction.sequence([
                                    SKAction.scale(to: SettingsGameProcess.Interface.Tutorial.Labels.CloseMessage.AnimationPulse.scaleTo, duration: SettingsGameProcess.Interface.Tutorial.Labels.CloseMessage.AnimationPulse.lifetime / 2),
                                    SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Tutorial.Labels.CloseMessage.AnimationPulse.lifetime / 2)])))
    }
    
    private func closeTutorial() {
        ///If it's scene been show after pressed to start game at first change scene to game scene.
        if UserDefaults.standard.bool(forKey: "TutorialOpenedWhenPressToStart") {
            UserDefaults.standard.set(false, forKey: "TutorialOpenedWhenPressToStart")
            loadScene(.game, withTransitionName: .pushLeft)
        }
        else {
            loadScene(.menu, withTransitionName: .pushRight)
        }
    }
    
    //MARK: - Input
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeTutorial()
        Sound.preload.playSound(.buttonPress)
    }
}
