//
//  ViewControllerMicrophonePermission.swift
//  PermissionExample_for_iOS8_n_iOS9Devices
//
//  Created by Burcu Geneci on 25/09/16.
//  Copyright © 2016 Burcu Geneci. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerMicrophonePermission: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.handleMicrophonePermission()
    }

    func handleMicrophonePermission()-> Bool {
        
        weak var weakSelf = self
        var microphoneAccessGranted = false
        let microPhoneStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
        
        switch microPhoneStatus {
        case .Authorized:
            microphoneAccessGranted = true
        case .Denied, .Restricted, .NotDetermined:
            microphoneAccessGranted = false
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeAudio, completionHandler: { (alowedAccess) -> Void in
                if !alowedAccess {
                    weakSelf?.showMicrophonePermisionPopUp()
                }
            })
        }
        return microphoneAccessGranted
    }
    
    
    func showMicrophonePermisionPopUp(){
        
        weak var weakSelf = self
        let alert = UIAlertController.init(title: "We need your permission",
                                           message: "Your Microphone Permission Message",
                                           preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "Go to Settings",
                                          style: UIAlertActionStyle.Default) { (UIAlertAction) in
                                            weakSelf?.goToAppSettings()
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func goToAppSettings(){
        if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(settingsURL)
        }
    }


}
