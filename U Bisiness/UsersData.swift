//
//  UsersData.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.08.2021.
//
import UIKit
import Foundation

class UsersData {
    // Login
    static var emailLogin = UserDefaults.standard.string(forKey: "emailUsersDataLogin")
    static var passwordLogin = UserDefaults.standard.string(forKey: "passwordUsersDataLogin")
    
    // Register
    static var nameRegister = UserDefaults.standard.string(forKey: "nameUsersDataRegister")
    static var emailRegister = UserDefaults.standard.string(forKey: "emailUsersDataRegister")
    static var passwordRegister = UserDefaults.standard.string(forKey: "passwordUsersDataRegister")
}
