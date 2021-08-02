//
//  Ellipse.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.05.2021.
//
import UIKit

// class OnBoardOne


// class OnBoardTwo
class TwoBoardEllipse: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 303.19, height: 495.93))
        UIColor.init(red: 255/255, green: 197/255, blue: 158/255, alpha: 0.20).setFill()
        path.fill()
    }
}

// class OnBoardThree
class ThreeBoardEllipse: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 303.19, height: 495.93))
        UIColor.init(red: 255/255, green: 152/255, blue: 155/255, alpha: 0.15).setFill()
        path.fill()
    }
}
