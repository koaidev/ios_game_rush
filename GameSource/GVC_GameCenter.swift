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

extension GameViewController {
    
    //MARK: - Work with gamecenter
    /** Load gamecenter*/
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) { self.present(viewController!, animated: true, completion: nil)}
            else { Debugger.printNow(textToPrint: "Authenticate compleate")}
        }
    }
    
    /** Save best score to gamecenter.*/
    @objc func submitScore() {
        if #available(iOS 14.0, *) {
            GKLeaderboard.submitScore(UserDefaults.standard.integer(forKey: "BestScore"), context: 0, player: GKLocalPlayer.local, leaderboardIDs: [SettingsGlobal.GameCenter.leaderboard], completionHandler: {
                (error: Error?) in
                if error != nil { Debugger.printNow(textToPrint: error!.localizedDescription)}
                else { Debugger.printNow(textToPrint: "GameCenter: Score submited")}
            })
        }
        else {
            let score = GKScore(leaderboardIdentifier: SettingsGlobal.GameCenter.leaderboard)
            score.value = Int64(UserDefaults.standard.integer(forKey: "BestScore"))
            
            GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
                if error != nil { Debugger.printNow(textToPrint: error!.localizedDescription)}
                else { Debugger.printNow(textToPrint: "GameCenter: Score submited")}
            })
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func showLeaderboard() {
        if #available(iOS 14.0, *) {
            let gcVC: GKGameCenterViewController = GKGameCenterViewController(state: .leaderboards)
            gcVC.gameCenterDelegate = self
            present(gcVC, animated: true, completion: nil)
        }
        else {
            let gcVC: GKGameCenterViewController = GKGameCenterViewController()
            gcVC.gameCenterDelegate = self
            gcVC.viewState = GKGameCenterViewControllerState.leaderboards
            gcVC.leaderboardIdentifier = SettingsGlobal.GameCenter.leaderboard
            present(gcVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - Show table
    /** Load gamecenter values and show tableview with leaders.*/
    @objc func getLeaderboard() {
        //If it's on test mode load fake stats.
        if SettingsGlobal.GameCenter.testMode {
            UserDefaults.standard.set(6, forKey: "GC_playersCount")
            UserDefaults.standard.set(1, forKey: "GC_localPlayerRank")
            UserDefaults.standard.set(["TapTap","Gamer","Link","Mobile","Player","Extra"], forKey: "GC_names_leaderboard")
            UserDefaults.standard.set(["326", "302", "287", "235", "196", "120"], forKey: "GC_values_leaderboard")
                
            self.showGameScoreTableView()
        }
        else {
            //Create leaderboard request
            if #available(iOS 14.0, *) {
                //Load leaderboard
                let leaderboardRequest = GKLeaderboard()
                leaderboardRequest.loadEntries(for: .global, timeScope: .allTime, range: NSMakeRange(1, 100), completionHandler: {
                    [weak self] (local, entries, count, error) in
                    if error != nil {
                        _ = local?.score
                        let localPlayerRank = local?.rank
                            
                        UserDefaults.standard.set(count, forKey: "GC_playersCount")
                        UserDefaults.standard.set(localPlayerRank, forKey: "GC_localPlayerRank")
                            
                        var namesArray = Array<String>()
                        var valuesArray = Array<String>()
                            
                        if count > 1 {
                            for i in 0...count {
                                let playerInfo = entries?[i]
                                let player = playerInfo?.player
                                let playerName = player?.displayName
                                let playerValue = playerInfo?.score
                                
                                namesArray.append(playerName!)
                                valuesArray.append(String(Int(playerValue!)))
                            }
                        }
                            
                        UserDefaults.standard.set(namesArray, forKey: "GC_names_leaderboard")
                        UserDefaults.standard.set(valuesArray, forKey: "GC_values_leaderboard")
                        
                        self?.showGameScoreTableView()
                    }
                })
            }
            else {
                let leaderboardRequest = GKLeaderboard()
                leaderboardRequest.identifier = SettingsGlobal.GameCenter.leaderboard
                leaderboardRequest.range = NSMakeRange(1, 100)
                    
                //Load leaderboard
                leaderboardRequest.loadScores(completionHandler: { (score: [GKScore]?, error: Error?) -> Void in
                    if error != nil { Debugger.printNow(textToPrint: "GVC_GameCenter getLeaderboard error: don't can load leaderboard stats")}
                    else {
                        if let playersCount = score?.count {
                            let localPlayer = leaderboardRequest.localPlayerScore
                            let localPlayerRank = localPlayer?.rank
                                
                            UserDefaults.standard.set(playersCount, forKey: "GC_playersCount")
                            UserDefaults.standard.set(localPlayerRank, forKey: "GC_localPlayerRank")
                                
                            var namesArray = Array<String>()
                            var valuesArray = Array<String>()
                                
                            if (score?.count)! > 1 {
                                for i in 0...((score?.count)! - 1) {
                                    let playerInfo = score?[i]
                                    let player = playerInfo?.player
                                    let playerName = player?.displayName
                                    let playerValue = playerInfo?.value
                                        
                                    namesArray.append(playerName!)
                                    valuesArray.append(String(Int(playerValue!)))
                                }
                            }
                                
                            UserDefaults.standard.set(namesArray, forKey: "GC_names_leaderboard")
                            UserDefaults.standard.set(valuesArray, forKey: "GC_values_leaderboard")
                                
                            self.showGameScoreTableView()
                        }
                    }
                })
            }
        }
    }
    
    /**
     Load world best score for Menu Scene.
     */
    @objc func getWorldBestScore() {
        if #available(iOS 14.0, *) {
            let leaderboardRequest = GKLeaderboard()
            
            leaderboardRequest.loadEntries(for: .global, timeScope: .allTime, range: NSMakeRange(1, 100), completionHandler: {
                (local, entries, count, error) in
                if error != nil {
                    if count > 0 {
                        let playerInfo = entries?[0]
                        let player = playerInfo?.player
                        let playerName = player?.displayName
                        let playerValue = playerInfo?.score
                        
                        UserDefaults.standard.set(playerName, forKey: "GC_worldBestScore_Name_leaderboard")
                        UserDefaults.standard.set(playerValue, forKey: "GC_worldBestScore_Value_leaderboard")
                        UserDefaults.standard.set(true, forKey: "GC_worldBestScore_PossibleToShow")
                    }
                }
            })
        }
        else {
            let leaderboardRequest = GKLeaderboard()
            leaderboardRequest.identifier = SettingsGlobal.GameCenter.leaderboard
            leaderboardRequest.range = NSMakeRange(1, 2)
            
            leaderboardRequest.loadScores(completionHandler: { (score: [GKScore]?, error: Error?) -> Void in
                if error != nil { Debugger.printNow(textToPrint: "GVC_GameCenter getLeaderboard error: don't can load leaderboard stats")}
                else {
                    if SettingsGlobal.GameCenter.testMode {
                        UserDefaults.standard.set("TapTap", forKey: "GC_worldBestScore_Name_leaderboard")
                        UserDefaults.standard.set("326", forKey: "GC_worldBestScore_Value_leaderboard")
                        UserDefaults.standard.set(true, forKey: "GC_worldBestScore_PossibleToShow")
                    }
                    else {
                        if let _ = score?.count {
                            let playerInfo = score?[0]
                            let player = playerInfo?.player
                            let playerName = player?.displayName
                            let playerValue = playerInfo?.value
                            
                            UserDefaults.standard.set(playerName, forKey: "GC_worldBestScore_Name_leaderboard")
                            UserDefaults.standard.set(playerValue, forKey: "GC_worldBestScore_Value_leaderboard")
                            UserDefaults.standard.set(true, forKey: "GC_worldBestScore_PossibleToShow")
                        }
                    }
                }
            })
        }
    }
    
    //MARK: - Table View
    /** Create table view with leaderboard.*/
    @objc func showGameScoreTableView() {
        ///Get table view size
        let frameSize = SettingsGlobal.isIPad ?
            CGRect(x: self.view.frame.size.width / 100 * 37.5, y: self.view.frame.size.height / 100 * 50, width: self.view.frame.size.width / 100 * 25, height: self.view.frame.size.height / 100 * 30) :
            CGRect(x: self.view.frame.size.width / 100 * 32.5, y: self.view.frame.size.height / 100 * 45, width: self.view.frame.size.width / 100 * 35, height: self.view.frame.size.height / 100 * 35)
        
        let bgColor = UIColor(hexString: SettingsScenes.Global.FontColor.leaberboardBackground).withAlphaComponent(SettingsScenes.Global.FontColor.leaberboardBackgroundAlpha)
        
        ///Create table view
        tableViewGameScore = UITableView(frame: frameSize)
        tableViewGameScore.delegate = self
        tableViewGameScore.dataSource = self
        tableViewGameScore.allowsSelection = false
        tableViewGameScore.backgroundColor = bgColor
        tableViewGameScore.separatorColor = UIColor.clear
        tableViewGameScore.layer.cornerRadius = 15
        
        ///Check it's end game scene open now
        if GlobalScene.nowLoaded(sceneName: GlobalScene.SceneName.end) {
            ///Hide table view and add to scene
            tableViewGameScore.alpha = 0.0
            view.addSubview(tableViewGameScore)
            UIView.animate(withDuration: SettingsGameProcess.Interface.End.Leaderboard.showTime, animations: {
                ///Show table view with animation fade in
                self.tableViewGameScore.alpha = 1.0
            })
        }
    }
    
    /** Hide table view.*/
    @objc func hideGameScoreTableView() {
        UIView.animate(withDuration: SettingsGameProcess.Interface.End.Leaderboard.hideTime, animations: {
            ////Hide with animation fade out
            self.tableViewGameScore.alpha = 0.0
        }, completion: { (finished: Bool) in
            ////Remove when it's will be faded
            self.tableViewGameScore.removeFromSuperview()
        })
    }
    
    /** Get cell for table view.*/
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///Create cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        
        ///Fill cells
        if UserDefaults.standard.integer(forKey: "GC_playersCount") > 1 {
            let leaderBoardNames = UserDefaults.standard.array(forKey: "GC_names_leaderboard") as! [String]
            let leaderBoardValues = UserDefaults.standard.array(forKey: "GC_values_leaderboard") as! [String]
            let playerName = leaderBoardNames[indexPath.row]
            let playerValue = leaderBoardValues[indexPath.row]
            
            cell.textLabel?.text = " " + String(indexPath.row + 1) + "      " + playerName
            cell.detailTextLabel?.text = "            " + playerValue
            cell.textLabel?.font = UIFont(name: SettingsGlobal.WorkWithScenes.fontName, size: 18)
            cell.detailTextLabel?.font = UIFont(name: SettingsGlobal.WorkWithScenes.fontName, size: 14)
            cell.textLabel?.textColor = UIColor(hexString: SettingsScenes.Global.FontColor.leaberboardCellText)
            cell.detailTextLabel?.textColor = UIColor(hexString: SettingsScenes.Global.FontColor.leaberboardCellText)
        }
        
        cell.textLabel?.textColor = UIColor(hexString: SettingsScenes.Global.FontColor.leaberboardCellText)
        cell.detailTextLabel?.textColor = UIColor(hexString: SettingsScenes.Global.FontColor.leaberboardCellText)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.integer(forKey: "GC_playersCount")
    }
}
