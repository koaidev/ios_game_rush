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

class TransparentSprite: SKSpriteNode {
    
    //MARK: - Initialisation
    /**
     Initialise node
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsInterface.preload.transparent, color: UIColor.clear, size: CGSize(width: 0, height: 0))
        self.position = position
        self.zPosition = zPosition
    }
    
    /**
     Initialise node
     - parameter position: CGPoint object for set position node on scene.
     - parameter size: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: GraphicPreloadsInterface.preload.transparent, color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    
    //MARK: - Custom Add Child
    /** Current function helped with adding new nodes to scene.*/
    func addChild(_ nodes: [SKNode]) { for value in nodes { addChild(value)}}
    
    //MARK: - Setters
    //Some position setters
    func set(positionX value: CGFloat) { position = CGPoint(x: value, y: position.y)}
    func set(positionY value: CGFloat) { position = CGPoint(x: position.x, y: value)}
    
    //Changer position from currentPoint
    func change(positionX value: CGFloat) { position = CGPoint(x: position.x + value, y: position.y)}
    func change(positionY value: CGFloat) { position = CGPoint(x: position.x, y: position.y + value)}
    
    //MARK: - Your features
}
