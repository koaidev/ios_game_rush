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

import GoogleMobileAds

extension GameViewController {
    
    //MARK: - Work with ads
    
    func prepareInterstitial() {
        DispatchQueue.main.async {
            //Create ddefault request
            let request = GADRequest()
            
            //Load interstitial ad's
            GADInterstitialAd.load(
                withAdUnitID: SettingsGlobal.Ad.idInterstitial,
                request: request,
                completionHandler: { (ad, error) in
                    if let error = error {
                        Debugger.printNow(textToPrint: "Interstitial failed to load: \(error.localizedDescription)")
                        return
                    }
                    self.interstitial = ad
                    self.interstitial!.fullScreenContentDelegate = self
              })
        }
    }
    
    /**
     Call this for show interstitial.
     Recomment to use AdController class for calling ad's in game.
     */
    @objc func showInterstitial() {
        if let ad = interstitial {
            //Stop to playing music
            if UserDefaults.standard.bool(forKey: "PlayMusic") { Sound.preload.pauseMusic()}
            
            //Present interstitial
            ad.present(fromRootViewController: self)
        } else { Debugger.printNow(textToPrint: "Interstitial wasn't ready")}
    }
    
    /**
     Call this for show banner.
     Recomment to use AdController class for calling ad's in game.
     */
    @objc func showBanner() {
        DispatchQueue.main.async {
            //Initialize different sizes of banner for iPhone and iPad
            self.banner = GADBannerView(adSize: kGADAdSizeBanner)
            self.banner.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.banner)
            //Attach to bottomn corner
            self.view.addConstraints(
                [NSLayoutConstraint(item: self.banner, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
                 NSLayoutConstraint(item: self.banner, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
                ])
            self.banner.adUnitID = SettingsGlobal.Ad.idBanner
            self.banner.rootViewController = self
            self.banner.load(GADRequest())
            self.banner.delegate = self
        }
    }
    
    /** Call this for hide bannner.*/
    @objc func hideBanner() {
        banner.removeFromSuperview()
    }
    
    //MARK: - Work with AdMob delegates
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        Debugger.printNow(textToPrint: "Ad failed to present full screen content with error \(error.localizedDescription).")
        
        //Prepare new one interstitial
        prepareInterstitial()
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        //Continue playing music
        if UserDefaults.standard.bool(forKey: "PlayMusic") { Sound.preload.resumeMusic()}
        
        //Prepare new one interstitial
        prepareInterstitial()
    }
}
