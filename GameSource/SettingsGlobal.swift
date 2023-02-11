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

/**
 This struch have constant settigns values for global project (It's used in different parts of game)
 */
struct SettingsGlobal {
    
    /** AdMob settings.*/
    struct Ad {
        static let on = false
        
        static let idInterstitial = "ca-app-pub-3940256099942544/4411468910"
        static let idBanner = "ca-app-pub-3940256099942544/2934735716"
        
        struct Testing {
            static let on = true
            
            static let devices = ["94a7ce7268949277573fcd9ac13c2833"]
        }
        
        /** Showing option. It's works when you just open some new scene in your game.*/
        struct Showing {
            struct Interstitial {
                static let game = false
                static let end = false
                static let menu = false
                static let settings = false
                static let store = false
                static let tutorial = false
            }
            
            struct Banner {
                static let game = false
                static let end = false
                static let menu = false
                static let settings = false
                static let store = false
                static let tutorial = false
            }
        }
    }
    
    /** In-Apps function for removing ad's from game.*/
    struct InApp {
        static let on = false
        static let removingAds = "removeAdsIDs"
    }
    
    /** Rate us function for reachings rationg in AppStore*/
    struct RateUs {
        struct AfterGame {
            static let on = false
        }
        
        struct Manual {
            static let on = true
        }
    }
    
    /** Skin system for player also include coin system. Not available in some games.*/
    struct Skins {
        static let on = true
    }
    
    /** Pause function in game scene.*/
    struct Pause {
        static let on = true
    }
    
    /** GameCenter settings. Write here you leaderboard id's and other.*/
    struct GameCenter {
        static let testMode = false //Turn off test mode when you upload game to AppStore
        static let leaderboard = "Leaderboard"
    }
    
    /** Some social info.*/
    struct SomeSocialStats {
        static let linkToRateUs = "http://google.com/"
    }
    
    /** Global information for scenes*/
    struct WorkWithScenes {
        static let fontName = "DINCondensed-Bold"
        static let speedOfChangeScene: Double = 0.8
        
        /** Change it value if you make pixel art game. And textures in app game not been filtered.*/
        static let filteredImagesInGame = true
    }
    
    /** Size of screen width */
    static let width = CGFloat(UserDefaults.standard.float(forKey: "SizeWidth"))
    static let widthHalf = CGFloat(UserDefaults.standard.float(forKey: "SizeWidth")) / 2
    /** Size of screen width, but abstract, reccomend to use in animations and shooting objects */
    static let widthAbstract: CGFloat = 390 //iPhoneX value
    /** Size of screen height */
    static let height = CGFloat(UserDefaults.standard.float(forKey: "SizeHeight"))
    static let heightHalf = CGFloat(UserDefaults.standard.float(forKey: "SizeHeight")) / 2
    /** Size of screen height, but abstract, reccomend to use in animations and shooting objects */
    static let heightAbstract: CGFloat = 844 //iPhoneX value
    
    static let isXPhone = UserDefaults.standard.bool(forKey: "_isXPhone")
    static let isIPad = UserDefaults.standard.bool(forKey: "_isIPad")
    
    static let debugMode = true
}
