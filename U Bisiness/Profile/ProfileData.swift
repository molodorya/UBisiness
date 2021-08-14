//
//  ProfileData.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 13.08.2021.
//
import UIKit
import Foundation

class ProfileData {
    // Profle
    static var nameUser = UserDefaults.standard.string(forKey: "profileName")
    static var emailUser = UserDefaults.standard.string(forKey: "profileEmail")
    static var phoneUser = UserDefaults.standard.string(forKey: "profilePhone")
    static var languageUser = UserDefaults.standard.string(forKey: "profileLanguage")
    
    // Card
    static var cardUser = nameUser
    static var cardStatus = UserDefaults.standard.bool(forKey: "cardStatus")
    static var cardIndustry = UserDefaults.standard.string(forKey: "cardIndustry")
    static var cardNameCompany = UserDefaults.standard.string(forKey: "cardNameCompany")
//    static var logoCompany = UserDefaults.standard.
    static var cardPhone = phoneUser
    static var cardCountry = UserDefaults.standard.string(forKey: "cardCountry")
    static var cardCompanyAddress = UserDefaults.standard.string(forKey: "cardCompanyAddress")
    static var cardTags = UserDefaults.standard.string(forKey: "cardTags")
     
    
    
}

