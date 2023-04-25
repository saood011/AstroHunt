//
//  UserLoginManager.swift
//  AstroHunt
//
//  Created by saood.akhtar on 19.04.23.
//

import Foundation
import SwiftUI
import FacebookLogin
import FBSDKShareKit
import LocalAuthentication


class AppLoginManager: ObservableObject, SharingDelegate{

    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
    }
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
    }
    func sharerDidCancel(_ sharer: Sharing) {
    }
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("dpUrl") var dpUrl = ""
    
    var manager = LoginManager()
    
    func loginUser(){
        //user login with reading permissons of email and public profile

        manager.logIn(permissions: ["email", "public_profile", ], from: nil) { [self]
            (result, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            //checking if user cancelled the flow
            if !result!.isCancelled{
                
                // logged in successfully
                self.isLoggedIn = true
                
                let request = GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture.type(large)"])
                
                request.start{[self](_, res, _) in
                    
                   guard let profileData = res as? [String: Any] else {return}
                   
                    self.email = profileData["email"] as! String
                    if let pictureData: [String : Any] = profileData["picture"] as? [String : Any]{
                        if let data : [String: Any] = pictureData["data"] as? [String: Any]{
                            
                            print(data["url"] as! String)
                            self.dpUrl = data["url"] as! String
                        }

                    }
                }
            }

            
        }
    }
    
    func logoutUser(){
        print("loggint out...")
        print(email, isLoggedIn)
        self.manager.logOut()
        self.email = ""
        self.isLoggedIn = false
        
        }
    func shareImageViaFacebook(url:URL) {
        let data = try? Data(contentsOf: url)
        let image = UIImage(data: data!)

        let photo = SharePhoto(image: image!, isUserGenerated: true)
        let content = SharePhotoContent()
        content.photos = [photo]
        content.hashtag = Hashtag("#AstroHunt")
        let dialog = ShareDialog(
            viewController: nil,
            content: content,
            delegate: self
        )
        // Recommended to validate before trying to display the dialog
        do {
            try dialog.validate()
        } catch {
            print(error)
        }
        
        dialog.show()
    }
    
    func FaceIdLogin() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    DispatchQueue.main.async {
                        self.isLoggedIn = true
                        print("login successful")
                    }
                } else {
                    // there was a problem
                    print(authenticationError!)
                }
            }
        } else {
            // no biometrics
            print("no biometrics available")
        }
    }
}
