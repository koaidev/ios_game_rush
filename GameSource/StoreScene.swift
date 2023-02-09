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

class StoreScene: GlobalScene, SkinsHolderNodeDelegate {
    
    private var panelResultIsOn: Bool = false
    
    //MARK: Nodes
    private let textStore = LogoSmallNode(withType: .store)
    
    private let panelBuyResultBack = SimpleSprite(texture: GraphicPreloadsInterface.preload.panelBuyResultBackground, size: SettingsScenes.Store.Size.panelBuyResultBack, position: SettingsScenes.Store.Position.panelBuyResultBack, zPosition: SettingsScenes.Store.ZPosition.panelBuyResultBack)
    private let panelBuyResult = SimpleSprite(texture: GraphicPreloadsInterface.preload.panelBuyResult, size: SettingsScenes.Store.Size.panelBuyResult, position: SettingsScenes.Store.Position.panelBuyResult, zPosition: SettingsScenes.Store.ZPosition.panelBuyResult)
    private let buttonBuyResultClose = ButtonNode(defaultWithType: .panelResultClose)
    private let panelButResultMessage = SimpleLabel(text: "", fontSize: SettingsScenes.Store.FontSize.labelPanelResultMessage, fontColorHex: SettingsScenes.Store.FontColor.labelPanelResultMessage, position: SettingsScenes.Store.Position.labelPanelResultMessage, zPosition: SettingsScenes.Store.ZPosition.labelPanelResultMessage)
    
    private let buttonBack = ButtonNode(defaultWithType: .back)
    
    private let buttonRemoveAds = ButtonNode(defaultWithType: .removeAds)
    private let buttonRestorePurchases = ButtonNode(defaultWithType: .restorePurchases)
    
    private let buttonNextSkin = ButtonNode(defaultWithType: .skinNext)
    private let buttonPreviousSkin = ButtonNode(defaultWithType: .skinPrevious)
    private let buttonStoreSelector = StoreSelectorNode()
    
    private let skinHolder = SkinsHolderNode()
    
    private let coinsIndicator = SimpleSprite(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Store.Size.coinsIndicator, position: SettingsScenes.Store.Position.coinsIndicator, zPosition: SettingsScenes.Store.ZPosition.coinsIndicator)
    private let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Store.FontSize.labelCoins, fontColorHex: SettingsScenes.Store.FontColor.labelCoins, position: SettingsScenes.Store.Position.labelCoins, zPosition: SettingsScenes.Store.ZPosition.labelCoins)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        setInterface()
        
        if SettingsGlobal.Skins.on {
            animateInterfaceSkinOn()
        }
    }
    
    //MARK: - Work with interface
    
    private func setInterface() {
        ///Load node setting
        labelCoins.horizontalAlignmentMode = .left
        
        ///Add node to scene
        addChild([background, buttonBack, textStore, panelBuyResultBack])
        
        ///Panel result
        panelBuyResultBack.addChild(panelBuyResult)
        panelBuyResult.addChild(panelButResultMessage)
        panelBuyResult.addChild(buttonBuyResultClose)
        buttonBuyResultClose.setLabel(withText: NSLocalizedString("storeScene_PurchasePanelClose", comment: ""), andFontSize: SettingsScenes.Store.FontSize.labelPanelResultButtonClose, andFontColor: SettingsScenes.Store.FontColor.labelPanelResultButtonClose)
        panelBuyResultBack.alpha = 0.0
        
        textStore.setInterfaceSize()
        buttonStoreSelector.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        if SettingsGlobal.InApp.on {
            if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                addChild([buttonRestorePurchases, buttonRemoveAds])
                buttonRestorePurchases.setLabel(withText: NSLocalizedString("storeScene_InAppRestore", comment: ""), andFontSize: SettingsScenes.Store.FontSize.labelButtonRestorePurchases, andFontColor: SettingsScenes.Store.FontColor.labelButtonRestorePurchases)
                buttonRemoveAds.setLabel(withText: NSLocalizedString("storeScene_InAppRemoveAds", comment: ""), andFontSize: SettingsScenes.Store.FontSize.labelButtonRemoveAds, andFontColor: SettingsScenes.Store.FontColor.labelButtonRemoveAds)
            }
            if !SettingsGlobal.Skins.on {
                buttonRemoveAds.position = SettingsScenes.Store.Position.buttonRemoveAdsIfOnOnlyInApps
                buttonRestorePurchases.position = SettingsScenes.Store.Position.buttonRestorePurchasesIfOnOnlyInApps
            }
        }
        if SettingsGlobal.Skins.on {
            addChild([skinHolder, buttonNextSkin, buttonPreviousSkin, buttonStoreSelector, coinsIndicator, labelCoins])
            skinHolder.buttonStoreSelector = buttonStoreSelector
            skinHolder.delegate = self
        }
    }
    
    //MARK: - Interface
    private func updateCoinIndicator() {
        labelCoins.changeTextWithAnimationScaled(withText: UserDefaults.standard.integer(forKey: "Coins"))
    }
    
    private func animateInterfaceSkinOn() {
        buttonNextSkin.position = CGPoint(x: SettingsGlobal.width * 1.5, y: buttonNextSkin.position.y)
        buttonPreviousSkin.position = CGPoint(x: -(SettingsGlobal.width / 2), y: buttonPreviousSkin.position.y)
        buttonStoreSelector.setScale(0.0)
        
        buttonNextSkin.run(SKAction.moveTo(x: SettingsScenes.Store.Position.buttonSkinNext.x, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
        buttonPreviousSkin.run(SKAction.moveTo(x: SettingsScenes.Store.Position.buttonSkinPrevious.x, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
        buttonStoreSelector.run(SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
    }
    
    //MARK: Store skin functions
    /** Delegate from SkinHolderNode. Is return result for current skin purchase*/
    func skinHolderBuyResult(isSuccessfully successfully: Bool) {
        if successfully { updateCoinIndicator()}
        showBuyResult(withResult: successfully)
    }
    
    private func showBuyResult(withResult compleate: Bool) {
        panelResultIsOn = true
        panelButResultMessage.text = compleate ? NSLocalizedString("storeScene_PurchaseCompletitionSuccessfully", comment: "") : NSLocalizedString("storeScene_PurchaseCompletitionFailed", comment: "")
        panelBuyResultBack.run(SKAction.group([
            SKAction.fadeIn(withDuration: 0.1),
            SKAction.scale(to: 1.0, duration: 0)]))
    }
    
    private func hideBuyResult() {
        panelResultIsOn = false
        Sound.preload.playSound(.buttonPress)
        panelBuyResultBack.run(SKAction.group([
            SKAction.fadeOut(withDuration: SettingsGameProcess.Interface.Store.resultBuySkinRemoveSpeed),
            SKAction.scale(to: 1.3, duration: SettingsGameProcess.Interface.Store.resultBuySkinRemoveSpeed)]))
    }
    
    func makeActionForButtonNextOrPrevSkin(_ button: ButtonNode) {
        let defaultPositionX = button == buttonNextSkin ? SettingsScenes.Store.Position.buttonSkinNext.x : SettingsScenes.Store.Position.buttonSkinPrevious.x
        let positionMoveToX = button == buttonNextSkin ? buttonNextSkin.position.x + SettingsGameProcess.Interface.Store.AnimateSelectorButton.NextAndPrevButtonSelector.shiftByX : buttonPreviousSkin.position.x - SettingsGameProcess.Interface.Store.AnimateSelectorButton.NextAndPrevButtonSelector.shiftByX
        let animationSpeed = SettingsGameProcess.Interface.Store.AnimateSelectorButton.NextAndPrevButtonSelector.speed
        
        let action = SKAction.group([
            SKAction.sequence([
                SKAction.moveTo(x: positionMoveToX, duration: animationSpeed / 2),
                SKAction.moveTo(x: defaultPositionX, duration: animationSpeed / 2)]),
            SKAction.sequence([
                SKAction.scale(to: SettingsGameProcess.Interface.Store.AnimateSelectorButton.NextAndPrevButtonSelector.scaleTo, duration: animationSpeed),
                SKAction.scale(to: 1.0, duration: animationSpeed)])])
        
        if button == buttonNextSkin {
            buttonNextSkin.run(action)
        }
        else {
            buttonPreviousSkin.run(action)
        }
    }
    
    //MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            if !panelResultIsOn {
                let location = touch.location(in: self)
                
                touchDownButtons(atLocation: location)
            }
            else {
                let locationPanelResult = touch.location(in: panelBuyResult)
                
                buttonBuyResultClose.touchDown(ifInLocation: locationPanelResult)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            ///Change button state to simple state
            touchUpAllButtons()
            
            if !panelResultIsOn {
                let location = touch.location(in: self)
                
                ///Buttons
                if buttonBack.contains(location) {
                    buttonBack.changeToSceneName = GlobalScene.getPreviousLoadedScene()
                    buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                }
                if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                    buttonRemoveAds.actionRemoveAds(ifInLocation: location)
                    buttonRestorePurchases.actionRestorePurchases(ifInLocation: location)
                }
                if buttonNextSkin.contains(location) {
                    skinHolder.selectNextSkin()
                    makeActionForButtonNextOrPrevSkin(buttonNextSkin)
                }
                if buttonPreviousSkin.contains(location) {
                    skinHolder.selectPreviousSkin()
                    makeActionForButtonNextOrPrevSkin(buttonPreviousSkin)
                }
                if buttonStoreSelector.contains(location) {
                    skinHolder.pressToButtonStoreSelector()
                }
            }
            else {
                let locationPanelResult = touch.location(in: panelBuyResult)
                
                ///Remove result
                if buttonBuyResultClose.contains(locationPanelResult) {
                    hideBuyResult()
                }
            }
        }
    }
}
