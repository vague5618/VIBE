//
//  Url.swift
//  VIBE_Client
//
//  Created by ndvor on 5/16/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import Foundation

let baseUrl = "http://172.20.10.10:3000"

class Url {
    
    let userLoginUrl = baseUrl+"/login"
    let userSignupUrl = baseUrl+"/signup"
    let userSearchByIdUrl = baseUrl+"/user/search/"
    let userSearchByNameUrl = baseUrl+"/user/search/username/"
    let userSearchContainByNameUrl = baseUrl+"/user/search/contain/username/"
    let userProfileUrl = baseUrl+"/user/profile"
    let userUpdateUrl = baseUrl+"/user/update"
    let userDeleteUrl = baseUrl+"/user/delete"
    let userLogOutUrl = baseUrl+"/logout"
    
    let feedbackCreateUrl = baseUrl+"/feedback/create"
    let feedbackReadLikeUrl = baseUrl+"/feedback/read/like"
    let feedbackReadDislikeUrl = baseUrl+"/feedback/read/dislike"
    let feedbackUpdateUrl = baseUrl+"/feedback/update"
    let feedbackDeleteUrl = baseUrl+"/feedback/delete"
    
    let listCreateUrl = baseUrl+"/list/create"
    let listReadUrl = baseUrl+"/list/read"
    let listUpdateUrl = baseUrl+"/list/update"
    let listDeleteUrl = baseUrl+"/list/delete"
    
    let musicCreateUrl = baseUrl+"/music/create"
    let musicReadUrl = baseUrl+"/music/read"
    let musicUpdateUrl = baseUrl+"/music/update"
    let musicDeleteUrl = baseUrl+"/music/delete"
    let musicStartUrl = baseUrl+"/music/start/"
    let checkArrayUrl = baseUrl+"/music/check"
}
