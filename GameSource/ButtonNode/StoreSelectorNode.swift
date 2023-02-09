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

class StoreSelectorNode: ButtonNode {
    
    /** This enum store possible states of store selector*/
    enum State {
        case buy
        case select
        case selected
    }
    
    //MARK: - Initialistions
    /**
     Initialisation of selector node
     - parameter textureBuy: SKTexture object of texture button in buy state.
     - parameter textureSelect: SKTexture object of texture button in select state.
     - parameter textureSelected: SKTexture object of texture button in selected state.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.button_SkinSelector, size: SettingsScenes.Store.Size.buttonSelector, position: SettingsScenes.Store.Position.buttonSelector, zPosition: SettingsScenes.Store.ZPosition.buttonSelector)
        setLabel(withText: "", andFontSize: SettingsScenes.Store.FontSize.labelSkinSelector, andFontColor: SettingsScenes.Store.FontColor.labelSkinSelector)
        
        set(state: .selected)
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    //MARK: - Work with state
    /**
     Set right text for button for selected skin diring by his state.
     - parameter newState: Current state of this skin.
     */
    func set(state newState: State) {
        switch newState {
        case .buy:
            label.changeTextWithAnimationScaled(withText: "Buy %price% coins")
        case .select:
            label.changeTextWithAnimationScaled(withText: NSLocalizedString("storeScene_SkinSelectorSelect", comment: ""))
        case .selected:
            label.changeTextWithAnimationScaled(withText: NSLocalizedString("storeScene_SkinSelectorCurrent", comment: ""))
        }
    }
    
    /**
     Update price text for selected skin
     - parameter newPriveValue: Current skin price.
     */
    func set(priceValue value: String) {
        label.changeTextWithAnimationScaled(withText: NSLocalizedString("storeScene_SkinSelectorBuyFist", comment: "") + String(value) + NSLocalizedString("storeScene_SkinSelectorBuyLast", comment: ""))
    }
    
    func animateSelectedNewSkin() {
        run(SKAction.group([
            SKAction.rotateByDegree(360, duration: SettingsGameProcess.Interface.Store.AnimateSelectorButton.WhenChangeStateCurrent.speed),
            SKAction.sequence([
                SKAction.scale(to: 0.3, duration: SettingsGameProcess.Interface.Store.AnimateSelectorButton.WhenChangeStateCurrent.speed / 2),
                SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Store.AnimateSelectorButton.WhenChangeStateCurrent.speed / 2)])]))
    }
}
