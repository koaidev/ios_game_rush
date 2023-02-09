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

import StoreKit

extension GameViewController {
    
    //Share
    /** Call this for use sharing function.*/
    @objc func share() {
        ///Get stats
        let text: String  = NSLocalizedString("share_Text", comment: "")
        let dataImage: Data = UserDefaults.standard.object(forKey: "ScreenShot") as! Data
        let image: UIImage = UIImage(data: dataImage)!
        let shareItems: Array = [image, text] as [Any]
        
        ///Create alert
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        activityViewController.popoverPresentationController?.sourceView = view
        if SettingsGlobal.isIPad {
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - RateUs
    /** Call this in the end of game for view rate us allert.*/
    @objc func rateUsAfterGame() {
        if SettingsGlobal.RateUs.AfterGame.on {
            if !UserDefaults.standard.bool(forKey: "neverRateAfterGame") {
                callRateUsAlert(withTypeAutomatically: true)
            }
        }
    }
    
    /** Call this for manually rate us alert.*/
    @objc func rateUs() {
        if SettingsGlobal.RateUs.Manual.on { callRateUsAlert(withTypeAutomatically: false)}
    }
    
    fileprivate func callRateUsAlert(withTypeAutomatically type: Bool) {
        ///New style alert
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
        else { SKStoreReviewController.requestReview()}
        if type { UserDefaults.standard.set(true, forKey: "neverRateAfterGame")}
    }
}
