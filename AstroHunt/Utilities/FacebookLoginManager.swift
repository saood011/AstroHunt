//
//  UserLoginManager.swift
//  AstroHunt
//
//  Created by saood.akhtar on 19.04.23.
//

import Foundation
import SwiftUI
import FacebookLogin


class FacebookLoginManager: ObservableObject {

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

}
