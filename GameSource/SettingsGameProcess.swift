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

struct SettingsGameProcess {
    
    //MARK: - Game Stats
    
    struct Block {
        static let count = 10
        
        struct Enemy {
            static let startAfter = 10
            
            struct AfterLines {
                static let from = 1
                static let to = 4
            }
        }
        
        struct Coin {
            struct AfterLines {
                static let from = 1
                static let to = 4
            }
        }
    }
    
    struct Player {
        struct Speed {
            static let start = 60.0
            static let max = 180.0
            static let changeByPercent = 2.0
        }
        
        static let rotation: CGFloat = 20.0
    }
    
    struct Coin {
        static let atFirstLaunch = 0
        
        static let animationCatchSpeed = 0.2
    }
    
    struct Explosion {
        struct Count {
            static let from = 10
            static let to = 15
        }
        struct Lifetime {
            static let from = 0.5
            static let to = 1.25
        }
        struct Scale {
            static let from: CGFloat = 0.4
            static let to: CGFloat = 1.0
        }
        static let moveBy = SettingsGlobal.width * 0.1
    }
    
    static let swipeInput = false
    static let followCameraToPlayer = true
    static let followCameraToPlayerByX = false
    static let followCameraToPlayerByY = true
    static let delayLoadSceneIfLose = 0.75
    
    //MARK: - Interface values
    
    struct Interface {
        /** Ipad scaling.*/
        struct InterfaceScalesAtIPad {
            static let object: CGFloat = 0.8
            static let label: CGFloat = 1.3
        }
        
        /** Store scene interface settings.*/
        struct Store {
            static let resultBuySkinRemoveSpeed = 0.5
            
            static let timeToShowSkinHolderAtStart = 0.25
            static let buttonSelecSkinAnimation = 0.25
            static let buttonInAppAnimation = 0.25
            
            static let moveSkinsSpeed = 0.15
            
            static let changeSkinsScaleSpeed = 0.15
            static let currentSkinScale: CGFloat = 1.2
            static let backgroundSkinScale: CGFloat = 0.65
            
            static let changeYPositionSpeed = 0.15
            
            struct AnimateSelectedSkin {
                static let time = 0.245
                static let rotateToDegree: CGFloat = 8
            }
            
            struct AnimateSelectorButton {
                struct WhenChangeStateCurrent {
                    static let speed = 0.45
                }
                
                struct NextAndPrevButtonSelector {
                    static let shiftByX = SettingsGlobal.width * 0.05
                    static let scaleTo: CGFloat = 1.15
                    static let speed = 0.2
                }
            }
        }
        
        /** Menu scene interface settings.*/
        struct Menu {
            static let labelsWorldBestScoreAnimationShowSpeed = 0.25
            
            static let sceneInterfaceAnimationOn = true
            struct StartButton {
                static let rotationSpeed = 0.45
                static let scaleAtStart: CGFloat = 1.15
                static let backToNormalTime = 0.1
            }
            static let buttonsScaleTo: CGFloat = 1.05
            static let buttonsScaleTime = 0.25
            static let buttonsScaleTimeRandomDelayMax = 0.1
            
            struct IndicatorStore {
                static let on = true
                static let scaleTo: CGFloat = 1.1
                static let speed = 1.0
            }
        }
        
        /** End scene interface settings.*/
        struct End {
            static let sceneInterfaceAnimationOn = true
            static let buttonRestartPulseTo: CGFloat = 0.875
            static let buttonRestartPulseSpeed = 0.35
            
            struct Leaderboard {
                static let showTime = 0.15
                static let hideTime = 0.15
            }
        }
        
        /** Tutorial scene interface settings.*/
        struct Tutorial {
            struct IndicatorCloseTutorial {
                static let showTime = 0.45
            }
            
            struct Labels {
                static let showTime = 0.25
                
                struct CloseMessage {
                    struct AnimationPulse {
                        static let scaleTo: CGFloat = 1.05
                        static let lifetime = 0.7
                    }
                }
            }
        }
        
        //Global settings can be on any scene
        static let speedAnimationChangeLabel = 0.2
        
        struct Switch {
            struct ChangeStateAnimation {
                static let speed = 0.15
                static let scaleTo: CGFloat = 0.55
            }
            struct Alpha {
                static let on: CGFloat = 1.0
                static let off: CGFloat = 0.5
            }
        }
        
        struct LogoPulse {
            static let scaleTo: CGFloat = 1.05
            static let speed = 2.5
        }
        
        struct LogoSmall {
            static let animationShowSpeed = 0.15
        }
        
        struct Button {
            struct Scaling {
                static let on = true
                static let scaleTo: CGFloat = 1.1
                static let speed = 0.075
            }
            struct Fade {
                static let on = true
                static let fadeTo: CGFloat = 0.5
                static let speed = 0.075
            }
            struct Jumping {
                static let on = true
                static let jumpBy = SettingsGlobal.widthAbstract / 100 * 2.0
                static let speed = 0.03
            }
        }
        
        struct Background {
            struct AnimationsAtTap {
                struct Scale {
                    static let on = true
                    static let scaleTo: CGFloat = 1.01
                    static let lifetime = 0.2
                }
            }
        }
    }
}
