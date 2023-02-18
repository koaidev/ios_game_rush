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

import UIKit
import SpriteKit
import GameKit
import iAd
import GoogleMobileAds
import MessageUI
import StoreKit


class GameViewController: UIViewController, GKGameCenterControllerDelegate, GADFullScreenContentDelegate, GADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Values
    var removingAds: SKProduct?
    var interstitial: GADInterstitialAd?
    var banner = GADBannerView(adSize: kGADAdSizeBanner)
    
    var tableViewGameScore = UITableView()
    
    //MARK: - Work with view
    /** Default func when created first game scene.*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Load project settings
        firstLaunchSettings()
        everyLaunchSettings()

        ///Create view
        createSceneView()
    }
    
    func createSceneView() {
        if let view = view as! SKView? {
            ///Create first scene
            let scene = MenuScene(size: view.frame.size)
            view.presentScene(scene)
            
            ///Load sound component
            Sound.preload.initMusic()
            Sound.preload.targetScene = scene
        }
    }
}
