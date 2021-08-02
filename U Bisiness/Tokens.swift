//
//  Tokens.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 22.07.2021.
//

import UIKit
import Foundation


class Token {
    static var accessToken = UserDefaults.standard.string(forKey: "accessToken")
    static var refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
    
    
    static var auth = UserDefaults.standard.bool(forKey: "auth")
    
}

