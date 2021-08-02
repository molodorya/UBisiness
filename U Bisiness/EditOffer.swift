//
//  testnew.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 01.07.2021.
//

import UIKit

class EditOffer: UIView {
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 150, width: screenWidth, height: screenHeight + 100))
        view.backgroundColor = .black
        
        return view
    }()
    
    //MARK: Content Image
    let contentImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 20, y: 30, width: 375, height: 200))
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.image = UIImage.init(named: "crimea")
        
        return image
    }()
    
    //MARK: NameView
    let nameView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 250, width: 375, height: 62))
        view.backgroundColor = .vanillaWhite
        
        return view
    }()
    
    let nameTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "НАЗВАНИЕ"
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let label = UITextField(frame: CGRect(x: 0, y: 27, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "НАЗВАНИЕ"
        
        return label
    }()
    
    let nameLines: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 60, width: 375, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    
    //MARK: ProtocolView
    let protocolView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 350, width: 375, height: 62))
        view.backgroundColor = .vanillaWhite
        
        return view
    }()
    
    let protocolTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "ПРОТОКОЛ"
        
        return label
    }()
    
    let protocolTextField: UITextField = {
        let label = UITextField(frame: CGRect(x: 0, y: 27, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "ПРОТОКОЛ"
        
        return label
    }()
    
    let protocolLines: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 60, width: 375, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: DateView
    let dateView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 450, width: 375, height: 62))
        view.backgroundColor = .vanillaWhite
        
        return view
    }()
    
    let datelTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "СРОК ДЕЙСТВИЯ"
        
        return label
    }()
    
    let dateTextField: UITextField = {
        let label = UITextField(frame: CGRect(x: 0, y: 27, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "22/06/2022"
        
        return label
    }()
    
    let dateLines: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 60, width: 375, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: DescriptionView
    let descriptionView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 550, width: 375, height: 170))
        view.backgroundColor = .vanillaWhite
        
        return view
    }()
    
    
    let descriptionTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "ОПИСАНИЕ"
        
        return label
    }()
    
    let descriptionTextField: UITextField = {
        let label = UITextField(frame: CGRect(x: 0, y: 20, width: 375, height: 170))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Текст"

        
        
        return label
    }()
    
    let descriptionLines: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 185, width: 375, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: Button
    let buttonTop: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 800, width: 375, height: 60))
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("ВЫВЕСТИ В ТОП", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        
        return button
    }()
    
    @objc func actionButtonTop() {
        print("actionButtonTop")
    }
    
    
    
    //MARK: Button
    let buttonSave: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 900, width: 375, height: 60))
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionButtonSave), for: .touchUpInside)
        
        return button
    }()
    
    @objc func actionButtonSave() {
        print("actionButtonTop")
    }
    
  
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
      
        
        addSubview(contentView)
        
        contentView.addSubview(contentImage)
        contentView.addSubview(nameView)
        contentView.addSubview(protocolView)
        contentView.addSubview(dateView)
        contentView.addSubview(descriptionView)
        
        nameView.addSubview(nameTitle)
        nameView.addSubview(nameTextField)
        nameView.addSubview(nameLines)
        
        protocolView.addSubview(protocolTitle)
        protocolView.addSubview(protocolTextField)
        protocolView.addSubview(protocolLines)
        
        dateView.addSubview(datelTitle)
        dateView.addSubview(dateTextField)
        dateView.addSubview(dateLines)
        
        descriptionView.addSubview(descriptionTitle)
        descriptionView.addSubview(descriptionTextField)
        descriptionView.addSubview(descriptionLines)
        
        
        contentView.addSubview(buttonTop)
        contentView.addSubview(buttonSave)
    }
}

