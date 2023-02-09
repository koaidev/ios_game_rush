/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2022 TapTapStudio. All rights reserved.

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

class ProgressBarNode: SimpleSprite {
    
    //Value store button state
    var value: CGFloat = 1.0
    var defaultSize: CGSize = CGSize(width: 0, height: 0)
    var defaultPosition: CGPoint = .zero
    
    var back = SimpleSprite(texture: GraphicPreloadsGame.preload.transparent, zPosition: 0)
    var progress = SimpleSprite(texture: GraphicPreloadsGame.preload.transparent, zPosition: 1)
    var progressCrop = SKCropNode()
    var progressMask = SKSpriteNode()
    var top = SimpleSprite(texture: GraphicPreloadsGame.preload.transparent, zPosition: 2)
    
    var label = SimpleLabel(text: "", fontSize: 14, fontColorHex: "#ffffff", position: CGPoint.zero, zPosition: 3)
    
    //MARK: - Initialistions
    /**
     Initialisation of button node for changing scene
     - parameter textureBack: SKTexture texture for back progress bar.
     - parameter textureProgress: SKTexture texture for main progress bar.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(textureBack: SKTexture, textureProgress: SKTexture, size: CGSize, sizeProgress: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsGame.preload.transparent, size: .zero, position: position, zPosition: zPosition)
        
        prepareComponents(textureBack: textureBack, textureProgress: textureProgress, textureTop: GraphicPreloadsInterface.preload.transparent, size: size, sizeProgress: sizeProgress, position: position)
    }
    
    /**
     Initialisation of button node for changing scene
     - parameter textureBack: SKTexture texture for back progress bar.
     - parameter textureProgress: SKTexture texture for main progress bar.
     - parameter textureTop: SKTexture texture for top progress bar.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(textureBack: SKTexture, textureProgress: SKTexture, textureTop: SKTexture, size: CGSize, sizeProgress: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsGame.preload.transparent, size: .zero, position: position, zPosition: zPosition)
        
        prepareComponents(textureBack: textureBack, textureProgress: textureProgress, textureTop: textureTop, size: size, sizeProgress: sizeProgress, position: position)
    }
    
    private func prepareComponents(textureBack: SKTexture, textureProgress: SKTexture, textureTop: SKTexture, size: CGSize, sizeProgress: CGSize, position: CGPoint) {
        defaultSize = size
        defaultPosition = position
        
        //Prepare crop node
        progress = SimpleSprite(texture: textureProgress, size: sizeProgress, position: .zero, zPosition: 1)
        progressMask =  SKSpriteNode(color: .black, size: progress.frame.size)
        
        progressCrop.addChild(progress)
        progressCrop.maskNode = progressMask
        progressCrop.zPosition = 1
        addChild(progressCrop)
        
        //Prepare other objects
        back = SimpleSprite(texture: textureBack, size: size, position: .zero, zPosition: 0)
        top = SimpleSprite(texture: textureTop, size: size, position: .zero, zPosition: 2)
        addChild([back, top])
    }
    
    func setLabel(text: String, position: CGPoint, fontSize: CGFloat, fontColorHex: String) {
        label = SimpleLabel(text: text, fontSize: fontSize, fontColorHex: fontColorHex, position: position, zPosition: 3)
        addChild(label)
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    //MARK: - Label
    
    //MARK: - Button Logic
    
    func set(value newValue: CGFloat) {
        value = newValue
        
        progressMask.position = CGPoint(x: -(progress.frame.size.width * (1 - value)), y: 0)
    }
}

