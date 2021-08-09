//
//  PublucFunction.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 16.06.2021.
//
import UIKit
import Foundation


public let screenRect = UIScreen.main.bounds
public let screenWidth = screenRect.size.width
public let screenHeight = screenRect.size.height
public let storyboard = UIStoryboard(name: "Main", bundle: nil)

public let linesImage = UIImage(named: "strokeNav")?.withTintColor(.black, renderingMode: .alwaysOriginal)
public let userImage = UIImage(named: "userNav")?.withTintColor(.black, renderingMode: .alwaysOriginal)


public func navigationPreset(navigationController: UINavigationController) {
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.isTranslucent = true
    navigationController.view.backgroundColor = UIColor.clear
}

    //MARK: - Вибрация
    public func vibrationFunc(tapping: UIImpactFeedbackGenerator.FeedbackStyle) {
       let generator = UIImpactFeedbackGenerator(style: tapping)
       generator.impactOccurred()
    }

//    public func transitionCustom(screen: UIViewController) {
//        let newViewController = screen
//        navigationController?.pushViewController(newViewController, animated: true)
//    }

public func colorVanilla(view: UIView, scrollView: UIScrollView, contentView: UIView) {
    view.backgroundColor = .vanillaWhite
    scrollView.backgroundColor = .vanillaWhite
    contentView.backgroundColor = .vanillaWhite
}

public func offLinesScroll(scrollView: UIScrollView) {
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
}


public func bounceScroll(scrollView: UIScrollView) {
    scrollView.alwaysBounceVertical = true
    scrollView.showsHorizontalScrollIndicator = true
    scrollView.showsVerticalScrollIndicator = true
}


// Валид e,mail
public func isValidEmail(testStr: String) -> Bool {
     let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
     let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     let result = emailTest.evaluate(with: testStr)
     return result
 }


public func settingEditableAndScroll(textView: UITextView, isWorksEdit: Bool) {
    
    if isWorksEdit == true {
        textView.isEditable = true
        textView.isScrollEnabled = true
    } else {
        textView.isEditable = false
        textView.isScrollEnabled = false
    }
 }

public func navigationCustom(viewController: UIViewController) {
    let detailViewController = viewController
    viewController.navigationController?.pushViewController(detailViewController, animated: true)
}


public func textFieldFeature(textField: UITextField, contentType: UITextContentType, capitalization: UITextAutocapitalizationType, correction: UITextAutocorrectionType, smartDashes: UITextSmartDashesType, smartInsert: UITextSmartInsertDeleteType, smartQuotes: UITextSmartQuotesType, spellCheking: UITextSpellCheckingType, keyboardType: UIKeyboardType, keyboardLook: UIKeyboardAppearance, returnKey: UIReturnKeyType) {
    
    textField.textContentType = contentType
    textField.autocapitalizationType = capitalization
    textField.autocorrectionType = correction
    textField.smartDashesType = smartDashes
    textField.smartInsertDeleteType = smartInsert
    textField.smartQuotesType = smartQuotes
    textField.spellCheckingType = spellCheking
    textField.keyboardType = keyboardType
    textField.keyboardAppearance = keyboardLook
    textField.returnKeyType = returnKey
    
}


