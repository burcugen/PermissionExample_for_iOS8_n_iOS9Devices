//
//  ViewControllerCameraPermission.swift
//  PermissionExample_for_iOS8_n_iOS9Devices
//
//  Created by Burcu Geneci on 25/09/16.
//  Copyright © 2016 Burcu Geneci. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerCameraPermission: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkDeviceCameraAuthorizationStatus()
    }

    func checkDeviceCameraAuthorizationStatus(){
        
        weak var weakSelf = self
        
        let authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        let userAgreedToUseIt = authorizationStatus == .Authorized
        
        if userAgreedToUseIt {
           
            //Do whatever you want to do with camera.
            
        }else if authorizationStatus == .Denied
            || authorizationStatus == .Restricted
            || authorizationStatus == .NotDetermined {
            
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (alowedAccess) -> Void in
                if alowedAccess {
                    
                    //Do whatever you want to do with camera.
                    
                }else{
                    weakSelf?.showCameraPermisionPopUp()
                }
            })
        }
    }

    
    func showCameraPermisionPopUp(){
        
        weak var weakSelf = self
        let alert = UIAlertController.init(title: "We need your permission",
                                           message: "Your Camera Permission Message",
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
