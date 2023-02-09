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

import Foundation

extension ButtonNode {
    
    /**
     This func used for default button initialisator. It's load default settings
     - parameter sceneName: Name of current loaded scene.
     - parameter type: Current button type.
     */
    func loadSettings(bySceneName sceneName: GlobalScene.SceneName, andButtonType type: ButtonType) {
        switch sceneName {
        case .game:
            switch type {
            case .pause:
                texture = GraphicPreloadsInterface.preload.button_Pause
                size = SettingsScenes.Game.Size.buttonPause
                position = SettingsScenes.Game.Position.buttonPause
                zPosition = SettingsScenes.Game.ZPosition.buttonPause
            case .restart:
                texture = GraphicPreloadsInterface.preload.button_RestartPause
                size = SettingsScenes.Game.Size.buttonRestart
                zPosition = SettingsScenes.Game.ZPosition.buttonRestart
            case .menu:
                texture = GraphicPreloadsInterface.preload.button_Menu
                size = SettingsScenes.Game.Size.buttonMenu
                zPosition = SettingsScenes.Game.ZPosition.buttonMenu
            case .pcontinue:
                texture = GraphicPreloadsInterface.preload.button_Continue
                size = SettingsScenes.Game.Size.buttonContinue
                zPosition = SettingsScenes.Game.ZPosition.buttonContinue
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .menu:
            switch type {
            case .start:
                texture = GraphicPreloadsInterface.preload.button_Start
                size = SettingsScenes.Menu.Size.buttonStart
                position = SettingsScenes.Menu.Position.buttonStart
                zPosition = SettingsScenes.Menu.ZPosition.buttonStart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            case .rateUs:
                texture = GraphicPreloadsInterface.preload.button_RateUs
                size = SettingsScenes.Menu.Size.buttonRateUs
                zPosition = SettingsScenes.Menu.ZPosition.buttonRateUs
            case .store:
                texture = GraphicPreloadsInterface.preload.button_Store
                size = SettingsScenes.Menu.Size.buttonStore
                position = SettingsScenes.Menu.Position.buttonStore
                zPosition = SettingsScenes.Menu.ZPosition.buttonStore
                itsForChangingSceneButton = true
                changeToSceneName = .store
            case .tutorial:
                texture = GraphicPreloadsInterface.preload.button_Tutorial
                size = SettingsScenes.Menu.Size.buttonTutorial
                zPosition = SettingsScenes.Menu.ZPosition.buttonTutorial
                itsForChangingSceneButton = true
                changeToSceneName = .tutorial
            case .gameCenter:
                texture = GraphicPreloadsInterface.preload.button_GameCenter
                size = SettingsScenes.Menu.Size.buttonGameCenter
                zPosition = SettingsScenes.Menu.ZPosition.buttonGameCenter
            case .settings:
                texture = GraphicPreloadsInterface.preload.button_Settigns
                size = SettingsScenes.Menu.Size.buttonSettings
                zPosition = SettingsScenes.Menu.ZPosition.buttonSettings
                itsForChangingSceneButton = true
                changeToSceneName = .settings
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .settings:
            switch type {
            case .back:
                texture = GraphicPreloadsInterface.preload.button_Back
                size = SettingsScenes.Settings.Size.buttonBack
                position = SettingsScenes.Settings.Position.buttonBack
                zPosition = SettingsScenes.Settings.ZPosition.buttonBack
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .end:
            switch type {
            case .menu:
                texture = GraphicPreloadsInterface.preload.button_Menu
                size = SettingsScenes.End.Size.buttonMenu
                zPosition = SettingsScenes.End.ZPosition.buttonMenu
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            case .restart:
                texture = GraphicPreloadsInterface.preload.button_Restart
                size = SettingsScenes.End.Size.buttonRestart
                zPosition = SettingsScenes.End.ZPosition.buttonRestart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            case .share:
                texture = GraphicPreloadsInterface.preload.button_Share
                size = SettingsScenes.End.Size.buttonShare
                zPosition = SettingsScenes.End.ZPosition.buttonShare
            case .gameCenter:
                texture = GraphicPreloadsInterface.preload.button_GameCenter
                size = SettingsScenes.End.Size.buttonGameCenter
                zPosition = SettingsScenes.End.ZPosition.buttonGameCenter
            case .store:
                texture = GraphicPreloadsInterface.preload.button_Store
                size = SettingsScenes.End.Size.buttonStore
                position = SettingsScenes.End.Position.buttonStore
                zPosition = SettingsScenes.End.ZPosition.buttonStore
                itsForChangingSceneButton = true
                changeToSceneName = .store
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .store:
            switch type {
            case .back:
                texture = GraphicPreloadsInterface.preload.button_Back
                size = SettingsScenes.Store.Size.buttonBack
                position = SettingsScenes.Store.Position.buttonBack
                zPosition = SettingsScenes.Store.ZPosition.buttonBack
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            case .removeAds:
                texture = GraphicPreloadsInterface.preload.button_RemoveAds
                size = SettingsScenes.Store.Size.buttonRemoveAds
                position = SettingsScenes.Store.Position.buttonRemoveAds
                zPosition = SettingsScenes.Store.ZPosition.buttonRemoveAds
            case .restorePurchases:
                texture = GraphicPreloadsInterface.preload.button_RestorePurchases
                size = SettingsScenes.Store.Size.buttonRestorePurchases
                position = SettingsScenes.Store.Position.buttonRestorePurchases
                zPosition = SettingsScenes.Store.ZPosition.buttonRestorePurchases
            case .skinNext:
                texture = GraphicPreloadsInterface.preload.button_SkinNext
                size = SettingsScenes.Store.Size.buttonSkinNext
                position = SettingsScenes.Store.Position.buttonSkinNext
                zPosition = SettingsScenes.Store.ZPosition.buttonSkinNext
            case .skinPrevious:
                texture = GraphicPreloadsInterface.preload.button_SkinPrevious
                size = SettingsScenes.Store.Size.buttonSkinPrevious
                position = SettingsScenes.Store.Position.buttonSkinPrevious
                zPosition = SettingsScenes.Store.ZPosition.buttonSkinPrevious
            case .panelResultClose:
                texture = GraphicPreloadsInterface.preload.button_BuyResultClose
                size = SettingsScenes.Store.Size.buttonBuyResultClose
                position = SettingsScenes.Store.Position.buttonBuyResultClose
                zPosition = SettingsScenes.Store.ZPosition.buttonBuyResultClose
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        default:
            Debugger.printNow(textToPrint: "Not find default button for this scene and type")
        }
        
        defaultSize = size
        defaultPosition = position
    }
    
    func iPadPreparing() {
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
    }
}

