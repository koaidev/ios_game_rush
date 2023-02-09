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

//MARK: - Game Scene
/**
 Singletone class
 This class need to preload texture files for better perfomence in game.
 Becouse creating new SKTexture objects requared many device recources.
 Also if we make many objects with same texture we can use one SKTexture object for use less device memories.
 If preloads we create one texture and can use it at many objects
    - Precondition: For getting preloads textures from this class use command like: GraphicPreloadsGame.preload.player1
 */
class GraphicPreloadsGame {
    private static var _preload: GraphicPreloadsGame?
    static var preload: GraphicPreloadsGame {
        if _preload == nil {
            _preload = GraphicPreloadsGame()
            Debugger.printNow(textToPrint: "Compleate loading graphic files for game scene")
        }
        return _preload!
    }
    
    internal let transparent = SKTexture(сonsideringFiltrationSettingsInProject: "transparent")
    
    //MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "backgroundGame")
    internal let pauseBackground = SKTexture(сonsideringFiltrationSettingsInProject: "pauseBackground")
    
    internal let player1 = SKTexture(сonsideringFiltrationSettingsInProject: "player1")
    internal let player2 = SKTexture(сonsideringFiltrationSettingsInProject: "player2")
    internal let player3 = SKTexture(сonsideringFiltrationSettingsInProject: "player3")
    internal let player4 = SKTexture(сonsideringFiltrationSettingsInProject: "player4")
    internal let explosion = SKTexture(сonsideringFiltrationSettingsInProject: "explosion")
    internal let explosion2 = SKTexture(сonsideringFiltrationSettingsInProject: "explosion2")
    internal let cloud = SKTexture(сonsideringFiltrationSettingsInProject: "cloud")
    internal let enemy = SKTexture(сonsideringFiltrationSettingsInProject: "enemy")
    internal let coinBlock = SKTexture(сonsideringFiltrationSettingsInProject: "coinBlock")
    internal let ground1 = SKTexture(сonsideringFiltrationSettingsInProject: "ground1")
    internal let ground2 = SKTexture(сonsideringFiltrationSettingsInProject: "ground2")
    internal let ground3 = SKTexture(сonsideringFiltrationSettingsInProject: "ground3")
    internal let ground4 = SKTexture(сonsideringFiltrationSettingsInProject: "ground4")
}

//MARK: - Other scenes "Interface"
/**
Singletone class
This class need to preload texture files for better perfomence in game.
Becouse creating new SKTexture objects requared many device recources.
Also if we make many objects with same texture we can use one SKTexture object for use less device memories.
If preloads we create one texture and can use it at many objects
    - Precondition: For getting preloads textures from this class use command like: GraphicPreloadsInterface.preload.buttonStart
*/
class GraphicPreloadsInterface {
    private static var _preload: GraphicPreloadsInterface?
    static var preload: GraphicPreloadsInterface {
        if _preload == nil {
            _preload = GraphicPreloadsInterface()
            Debugger.printNow(textToPrint: "Compleate loading interface graphic files")
        }
        return _preload!
    }
    internal let transparent = SKTexture(сonsideringFiltrationSettingsInProject: "transparent")
    
    //MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "background")
    internal let background_TutorialScene = SKTexture(сonsideringFiltrationSettingsInProject: "background_TutorialScene")
    
    internal let logo = SKTexture(сonsideringFiltrationSettingsInProject: "logo")
    internal let coinsIndicator = SKTexture(сonsideringFiltrationSettingsInProject: "coinsIndicator")
    
    internal let switch_Body = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Body")
    internal let switch_Dot = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Dot")
    
    internal let button_Back = SKTexture(сonsideringFiltrationSettingsInProject: "button_Back")
    internal let button_GameCenter = SKTexture(сonsideringFiltrationSettingsInProject: "button_GameCenter")
    internal let button_Menu = SKTexture(сonsideringFiltrationSettingsInProject: "button_Menu")
    internal let button_Pressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pressed")
    internal let button_RateUs = SKTexture(сonsideringFiltrationSettingsInProject: "button_RateUs")
    internal let button_Restart = SKTexture(сonsideringFiltrationSettingsInProject: "button_Restart")
    internal let button_RestartPause = SKTexture(сonsideringFiltrationSettingsInProject: "button_RestartPause")
    internal let button_Settigns = SKTexture(сonsideringFiltrationSettingsInProject: "button_Settings")
    internal let button_Share = SKTexture(сonsideringFiltrationSettingsInProject: "button_Share")
    internal let button_Start = SKTexture(сonsideringFiltrationSettingsInProject: "button_Start")
    internal let button_StartPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_StartPressed")
    internal let button_Store = SKTexture(сonsideringFiltrationSettingsInProject: "button_Store")
    internal let button_Tutorial = SKTexture(сonsideringFiltrationSettingsInProject: "button_Tutorial")
    internal let button_Continue = SKTexture(сonsideringFiltrationSettingsInProject: "button_Continue")
    internal let button_Pause = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pause")
    internal let button_PausePressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_PausePressed")
    
    internal let indicatorButtonStore = SKTexture(сonsideringFiltrationSettingsInProject: "indicatorButtonStore")
    internal let indicatorCloseTutorial = SKTexture(сonsideringFiltrationSettingsInProject: "indicatorCloseTutorial")
    
    internal let button_InAppPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_InAppPressed")
    internal let button_RemoveAds = SKTexture(сonsideringFiltrationSettingsInProject: "button_RemoveAds")
    internal let button_RestorePurchases = SKTexture(сonsideringFiltrationSettingsInProject: "button_RestorePurchases")
    internal let button_SkinNext = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinNext")
    internal let button_SkinPrevious = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinPrevious")
    internal let button_SkinSelector = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinSelector")
    
    internal let panelBuyResultBackground = SKTexture(сonsideringFiltrationSettingsInProject: "panelBuyResultBackground")
    internal let panelBuyResult = SKTexture(сonsideringFiltrationSettingsInProject: "panelBuyResult")
    internal let button_BuyResultClose = SKTexture(сonsideringFiltrationSettingsInProject: "button_BuyResultClose")
    
    internal let skin1 = SKTexture(сonsideringFiltrationSettingsInProject: "player1")
    internal let skin2 = SKTexture(сonsideringFiltrationSettingsInProject: "player2")
    internal let skin3 = SKTexture(сonsideringFiltrationSettingsInProject: "player3")
    internal let skin4 = SKTexture(сonsideringFiltrationSettingsInProject: "player4")
}
