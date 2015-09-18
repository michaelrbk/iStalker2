//
//  ContactFacade.swift
//  iStalker
//
//  Created by user113282 on 15/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContactFacade {
    
    var rvc : ResultsViewController?
    let FULL_CONTACT_API_KEY: String = "252a1ebb9708464c"
    
    func findContact(email: String) {
        //email teste: "bart@fullcontact.com"
        Alamofire.request(.GET, "https://api.fullcontact.com/v2/person.json", parameters: ["apiKey": FULL_CONTACT_API_KEY, "email" : email])
            .responseJSON { _, _, json, _ in
            self.rvc?.handleContactCallback(JSON(json!))
        }
        
    }
    
    func getPhotoURL(contact: JSON, typeId: String) -> String? {
        var url: String?
        
        if let photos = contact["photos"].array {
            for photo in photos {
                if (photo["typeId"].string == typeId) {
                    url = photo["url"].string!
                    break
                }
            }
        }
        
        return url
    }
    
    func getPrimaryPhotoURL(contact: JSON) -> String? {
        var url: String?
        
        if let photos = contact["photos"].array {
            for photo in photos {
                var isPrimary : Bool? = photo["isPrimary"].bool
                if (isPrimary != nil && isPrimary!) {
                    url = photo["url"].string!
                    break
                }
            }
        }
        
        return url
    }
}