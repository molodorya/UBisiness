//
//  UserMenu.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 27.06.2021.
//

import UIKit

class UserMenuView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 67, height: 122))
        UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 1).setFill()
        path.fill()
    }
}



//MARK: распределить потом по разным файлам в зависимости от экрана


class UserMenu: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    let views = UserMenuView(frame: CGRect(x: 30, y: 3, width: 67, height: 122))
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        view.backgroundColor = .vanillaWhite
        contentView.backgroundColor = .vanillaWhite
        headerView.backgroundColor = .vanillaWhite
   
        views.backgroundColor = .clear
        views.rotate(degrees: 38)
        headerView.addSubview(views)
        addHeaderView()
        offLinesScroll(scrollView: scrollView)
        textEmail.delegate = self
        hideKeyboardWhenTappedScreen()
        
        screenProfile()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
    }
    
    func addHeaderView() {
        contentView.addSubview(headerView)
        
        headerView.addSubview(buttonMyCabinet)
        headerView.addSubview(imageUserCabinet)
        headerView.addSubview(titleUserCabinet)
        
        headerView.addSubview(buttonMyCard)
        headerView.addSubview(imageCard)
        headerView.addSubview(titleCard)
        
        headerView.addSubview(buttonMyOffers)
        headerView.addSubview(imageOffers)
        headerView.addSubview(titleOffers)
        
    }
    
    
    
    
    //MARK: -  Мой кабинет
    let buttonMyCabinet: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 32, width: 95, height: 64))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(actionButtonMyCabinet), for: .touchUpInside)
        
        return button
    }()
    
    let imageUserCabinet: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 46, y: 39, width: 23, height: 20))
        image.image = UIImage.init(systemName: "person")
        image.tintColor = .black
        
        
        return image
    }()
    
    let titleUserCabinet: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 62, width: 95, height: 29))
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "мой\n кабинет"
        
        return label
    }()
    
    //MARK: - Моя визитка
    let buttonMyCard: UIButton = {
        let button = UIButton(frame: CGRect(x: 130, y: 32, width: 95, height: 64))
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(actionButtonMyCard), for: .touchUpInside)
        
        return button
    }()
    
    let imageCard: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 166, y: 38, width: 23, height: 20))
        image.image = UIImage.init(systemName: "person")
        image.tintColor = .black
        
        
        return image
    }()
    
    let titleCard: UILabel = {
        let label = UILabel(frame: CGRect(x: 130, y: 62, width: 95, height: 29))
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "моя\n визитка"
        
        return label
    }()
    
    
    //MARK: - Мои спецпредложения
    let buttonMyOffers: UIButton = {
        let button = UIButton(frame: CGRect(x: 250, y: 32, width: 95, height: 64))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(actionButtonMyOffers), for: .touchUpInside)
        
        return button
    }()
    
    let imageOffers: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 286, y: 38, width: 23, height: 20))
        image.image = UIImage.init(systemName: "person")
        image.tintColor = .black
        
        
        return image
    }()
    
    let titleOffers: UILabel = {
        let label = UILabel(frame: CGRect(x: 250, y: 62, width: 95, height: 29))
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "мои спец.\n предложения"
        
        return label
    }()
    
    
    
    //MARK: - Кнопки HeaderView
    @objc func actionButtonMyCabinet() {
        print("actionButtonMyCabinet")
        contentViewSubscribe.removeFromSuperview()
        contentViewMyCard.removeFromSuperview()
        contentViewOffer.removeFromSuperview()
       
        
        
        UIView.animate(withDuration: 0.2) {
            self.views.center.x = 65
        }
       
        screenProfile()
        heightConstraint.constant = 1000
        
    }
    
    @objc func actionButtonMyCard() {
        print("actionButtonMyCard")
        
        contentViewSubscribe.removeFromSuperview()
        contentViewMenu.removeFromSuperview()
        contentViewOffer.removeFromSuperview()
       

        
        
        UIView.animate(withDuration: 0.2) {
            self.views.center.x = 180
        }
        
        heightConstraint.constant = 800
        
        
        
        screenCard()
    }
    
    @objc func actionButtonMyOffers() {
        print("actionButtonMyOffers")
        contentViewSubscribe.removeFromSuperview()
        contentViewMyCard.removeFromSuperview()
        contentViewMenu.removeFromSuperview()
        
        UIView.animate(withDuration: 0.2) {
            self.views.center.x = 295
        }
        
        screenOffer()
    }
    
    
    
    //MARK: - КонтентВью
    let contentViewMenu: UIView = {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let view = UIView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: 1100))
        
        return view
    }()
    
    //MARK: - Тайтл и Аватар
    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 50, width: 315, height: 17))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "ЛИЧНЫЕ ДАННЫЕ"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    let imageAvatar: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 133, y: 100, width: 110, height: 110))
//        image.image = #imageLiteral(resourceName: "Ellipse")
        image.layer.cornerRadius = image.bounds.size.width / 2.0
        
        return image
    }()
    
  
    
  
    
   
    
    
    //MARK: - Вьюхи к элементам
    let nameView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 250, width: 358, height: 90))
        
        return view
    }()
    
    let emailView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 350, width: 358, height: 90))
        
        
        return view
    }()
    
    let phoneView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 450, width: 358, height: 90))
        
        
        return view
    }()
    
    let languageView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 550, width: 538, height: 90))
        
        
        return view
    }()
    
    
    //MARK: - nameView
    let labelName: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 20, width: 342, height: 19))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "имя"
        
        return label
    }()
    
    let textName: UITextView = {
        let textView = UITextView(frame: CGRect(x: 3, y: 44, width: 342, height: 30))
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "Яна Насыбуллина"
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let nameLines: UIView = {
        let view = UIView(frame: CGRect(x: 8, y: 90, width: 342, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    //MARK: - emailView
    let labelEmail: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 20, width: 342, height: 19))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "E-Mail"
        
        return label
    }()
    
    let textEmail: UITextView = {
        let textView = UITextView(frame: CGRect(x: 3, y: 44, width: 342, height: 30))
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "yanis1@gmail.com"
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    /// Фитрация E-mail адресса
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textEmail.text == "Неверный E-mail" {
            self.textEmail.text = nil
            textEmail.textColor = .black
        }
        

    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        func isValidEmail(email: String) -> Bool {
            let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            
            return emailTest.evaluate(with: email)
        }
        if isValidEmail(email: textEmail.text ?? "Error") {
            print("isValidEmail")
        } else {
            print("noValidEmail")
            self.textEmail.text = nil
            
            textEmail.textColor = .lightGray
            self.textEmail.text = "Неверный E-mail"
            shakeView(emailLines)
            vibrationFunc(tapping: .light)
            emailLines.clipsToBounds = true
            UIView.animate(withDuration: 0) {
                self.emailLines.backgroundColor = UIColor.red
            } completion: { _ in
                UIView.animate(withDuration: 2) {
                    self.emailLines.backgroundColor = UIColor.black
                }
            }
        }
        return true
    }

    func shakeView(_ shakeView: UIView) {
        let shake = CABasicAnimation(keyPath: "position")
        let xDelta = CGFloat(10)
        shake.duration = 0.10
        shake.repeatCount = 1
        shake.autoreverses = true

        let from_point = CGPoint(x: shakeView.center.x - xDelta, y: shakeView.center.y)
        let from_value = NSValue(cgPoint: from_point)

        let to_point = CGPoint(x: shakeView.center.x + xDelta, y: shakeView.center.y)
        let to_value = NSValue(cgPoint: to_point)

        shake.fromValue = from_value
        shake.toValue = to_value
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shakeView.layer.add(shake, forKey: "position")
    }
    
   
    
    
    let emailLines: UIView = {
        let view = UIView(frame: CGRect(x: 8, y: 90, width: 342, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: - phoneView
    let labelPhone: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 20, width: 342, height: 19))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "телефон"
        
        return label
    }()
    
    let textPhone: UITextView = {
        let textView = UITextView(frame: CGRect(x: 3, y: 44, width: 342, height: 30))
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "+7 (999) 921-85-97"
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let phoneLines: UIView = {
        let view = UIView(frame: CGRect(x: 8, y: 90, width: 342, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    //MARK: - languageView
    let labelLanguage: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 20, width: 342, height: 19))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "язык"
        
        return label
    }()
    
    let textLanguage: UITextView = {
        let textView = UITextView(frame: CGRect(x: 3, y: 44, width: 342, height: 30))
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "Русский"
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let languageLines: UIView = {
        let view = UIView(frame: CGRect(x: 8, y: 90, width: 342, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    
    
    
    
    //MARK: - Button
    let buttonEdit: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 700, width: 375, height: 58))
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("РЕДАКТИРОВАТЬ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(actionEditButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        
        return button
    }()
    
    let buttonSubscribeControl: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 780, width: 375, height: 58))
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("УПРАВЛЕНИЕ ПОДПИСКОЙ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(actionSubscribeButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        
        return button
    }()
    
    
    //MARK: - For edit mode
    let buttonSave: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 700, width: 375, height: 58))
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(actionSaveButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        
        return button
    }()
    
   
    
    
    let buttonAddImage: UIButton = {
        let button = UIButton(frame: CGRect(x: 133, y: 100, width: 110, height: 110))
        let image = UIImage.init(named: "maskAvatar")
        button.setBackgroundImage(image, for: .normal)
        button.layer.cornerRadius = button.bounds.size.width / 2.0
        button.addTarget(self, action: #selector(addNewImage), for: .touchUpInside)
        
        return button
    }()
    
    
    
    //MARK: - Управление подпиской
    
    let contentViewSubscribe: UIView = {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let view = UIView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: 1100))
        return view
    }()
    
    let statusSubscribeView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 45, width: 375, height: 120))
        view.backgroundColor = .vanillaWhiteContrast
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    let labelSubscribe: UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 20, width: 250, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Активная премиум подписка"
        
        return label
    }()
    
    let labelPromptSubscribe: UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 50, width: 300, height: 70))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.text = "действует до 5 апреля 2021 года\n350Р / месяц"
        
        return label
    }()
    
    
    let historyPremium: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 200, width: 350, height: 150))
       
        
        return view
    }()
    
    //MARK: - Top
    let lastPremiumTop: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 300, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Продление премиум доступа"
        
        return label
    }()
    
    
    let lastPremiumTopDate: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 35, width: 130, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "5 февраля 2021"
        
        return label
    }()
    
    let lastPremiumPriceTop: UILabel = {
        let label = UILabel(frame: CGRect(x: 300, y: 10, width: 80, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "- 350P"
        
        
        return label
    }()
    
    //MARK: - Bottom
    let lastPremiumBottom: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: 300, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Продление премиум доступа"
        
        return label
    }()
    
    
    let lastPremiumBottomDate: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 105, width: 130, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "5 марта 2021"
        
        return label
    }()
    
    let lastPremiumPriceBottom: UILabel = {
        let label = UILabel(frame: CGRect(x: 300, y: 80, width: 80, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "- 350P"
        
        
        return label
    }()
    
    
    
    let buttonExtend: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 370, width: 375, height: 60))
        button.setTitle("ПРОДЛИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionExtend), for: .touchUpInside)
        
        return button
    }()
    
    let buttonChange: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 450, width: 375, height: 60))
        button.setTitle("ИЗМЕНИТЬ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionChange), for: .touchUpInside)
        
        
        return button
    }()
    
    let buttonCancel: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 530, width: 375, height: 60))
        button.setTitle("ОТМЕНИТЬ ПОДПИСКУ", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionCancel), for: .touchUpInside)
        
        return button
    }()
    
    @objc func actionExtend() {
        print("action extend")
    }
    
    @objc func actionChange() {
        print("action change")
    }
   
    
    @objc func actionCancel() {
        print("cancel subscribe")
    }
    
    
    
    @objc func addNewImage() {
        print("добавить настройку чтобы фото добавлять")
    }
    
    //MARK: - Button
    @objc func actionEditButton() {
        
        print("добавить настройку чтобы фото добавлять")
        
        textName.isEditable = true
        textEmail.isEditable = true
        textPhone.isEditable = true
        textLanguage.isEditable = true
        buttonEdit.isHidden = true
        
        buttonAddImage.isHidden = false
        
        buttonSubscribeControl.isHidden = true
        contentViewMenu.addSubview(buttonSave)
        contentViewMenu.addSubview(buttonAddImage)
    }
    
    
    @objc func actionSaveButton() {
        
      
        
        textName.isEditable = false
        textEmail.isEditable = false
        textPhone.isEditable = false
        textLanguage.isEditable = false
        buttonEdit.isHidden = false
        buttonAddImage.isHidden = false
        buttonSubscribeControl.isHidden = false
        buttonSave.removeFromSuperview()
        buttonAddImage.removeFromSuperview()
        print("statusEdit: false")
        
//        DataNetwork.textNameData = textName.text
//        DataNetwork.textEmailData = textEmail.text
//        DataNetwork.textPhoneData = textPhone.text
//        DataNetwork.textLanguageData = textLanguage.text
        
     
        
        
    }
    
    
    @objc func actionSubscribeButton() {
        print("actionSubscribeButton")
        editSubscribe()
    }
    
    
    func screenProfile() {
        
        contentView.addSubview(contentViewMenu)
        
        contentViewMenu.addSubview(titleLabel)
        contentViewMenu.addSubview(imageAvatar)
        
        //MARK: - nameView
        contentViewMenu.addSubview(nameView)
        nameView.addSubview(labelName)
        nameView.addSubview(textName)
        nameView.addSubview(nameLines)
        
        //MARK: - emailView
        contentViewMenu.addSubview(emailView)
        emailView.addSubview(labelEmail)
        emailView.addSubview(textEmail)
        emailView.addSubview(emailLines)
        
        //MARK: - phoneView
        contentViewMenu.addSubview(phoneView)
        phoneView.addSubview(labelPhone)
        phoneView.addSubview(textPhone)
        phoneView.addSubview(phoneLines)
        
        //MARK: - phoneView
        contentViewMenu.addSubview(languageView)
        languageView.addSubview(labelLanguage)
        languageView.addSubview(textLanguage)
        languageView.addSubview(languageLines)
        
        //обьекты могут не работать из-за размера contentViewMenu
        contentViewMenu.addSubview(buttonEdit)
        contentViewMenu.addSubview(buttonSubscribeControl)
        
    }
    
    func editSubscribe() {
        contentViewMenu.removeFromSuperview()
        contentView.addSubview(contentViewSubscribe)
        contentViewSubscribe.addSubview(statusSubscribeView)
        
        statusSubscribeView.addSubview(labelSubscribe)
        statusSubscribeView.addSubview(labelPromptSubscribe)
        
        contentViewSubscribe.addSubview(historyPremium)
        historyPremium.addSubview(lastPremiumTop)
        historyPremium.addSubview(lastPremiumTopDate)
        historyPremium.addSubview(lastPremiumPriceTop)
        
        historyPremium.addSubview(lastPremiumBottom)
        historyPremium.addSubview(lastPremiumBottomDate)
        historyPremium.addSubview(lastPremiumPriceBottom)
        
        
        contentViewSubscribe.addSubview(buttonExtend)
        contentViewSubscribe.addSubview(buttonChange)
        contentViewSubscribe.addSubview(buttonCancel)
        
    }
    
    
    
    
    //MARK: - Мои визитки
    
    let contentViewMyCard: UIView = {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let view = UIView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: 1100))
        
        return view
    }()
    
    
    let viewEdit: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 30, width: 375, height: 380))
        view.layer.cornerRadius = 5
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let avatarCard: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 15, y: 20, width: 100, height: 100))
        image.layer.cornerRadius = 50
        image.image = nil
        
        return image
    }()
    
    let nameCard: UILabel = {
        let label = UILabel(frame: CGRect(x: 130, y: 0, width: 315, height: 100))
        label.numberOfLines = 0
        label.text = "Яна\nНасыбуллина"
        
        return label
    }()
    
    
    let statusCard: UILabel = {
        let label = UILabel(frame: CGRect(x: 130, y: 90, width: 300, height: 20))
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Участник"
        
        return label
    }()
    
    let verificationStatus: UILabel = {
        let label = UILabel(frame: CGRect(x: 130, y: 110, width: 300, height: 20))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "подтвержден  ✓"
        
        return label
    }()
    
    
    //MARK: - industry
    let industry: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 170, width: 350, height: 75))
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let labelIndustry: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 70, height: 15))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "ИНДУСТРИЯ"
        
        return label
    }()
    
    let textIndustry: UITextView = {
        let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "ИНДУСТРИЯ"
        text.backgroundColor = .vanillaWhiteContrast
        
        return text
    }()
    
    let linesIndustry: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: - Company
    let company: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 260, width: 350, height: 75))
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let labelCompany: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 15))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "НАЗВАНИЕ КОМПАНИИ"
        
        return label
    }()
    
    let textCompany: UITextView = {
        let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "U-Bissines"
        text.backgroundColor = .vanillaWhiteContrast
        
        return text
    }()
    
    let linesCompany: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    //MARK: - Button Detailed And Action Func
    let buttonDetailed: UIButton = {
        let button = UIButton(frame: CGRect(x: 250, y: 340, width: 100, height: 30))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(actionDetailed), for: .touchUpInside)
        button.underLineButton(text: "подробнее ∨")
        
        
        
        
        return button
    }()
    
    @objc func actionDetailed() {
        UIView.animate(withDuration: 0.4) { [self] in
            viewEdit.frame = CGRect(x: 20, y: 50, width: 375, height: 930) // default height: 380
            buttonChangeCard.frame = CGRect(x: 20, y: 1000, width: 375, height: 60) // default height: 435
            
           
            
            industry.isHidden = false
            company.isHidden = false
            imageCompany.isHidden = false
            phone.isHidden = false
            country.isHidden = false
            street.isHidden = false
            tag.isHidden = false
            
            
            
            buttonTurn.isHidden = false
            buttonDetailed.isHidden = true
            heightConstraint.constant = 1200
        }
        
    }
    
    
    

    //MARK: - Avatar

    let imageCompany: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 15, y: 370, width: 100, height: 100))
        image.contentMode = .scaleToFill // ??? acspectFill?
        image.image = #imageLiteral(resourceName: "logo")
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        
        return image
    }()
    
    

        //MARK: - Phone
        let phone: UIView = {
            let view = UIView(frame: CGRect(x: 15, y: 500, width: 350, height: 75))
            view.backgroundColor = .vanillaWhiteContrast
            
            
            return view
        }()
        
        let labelPhoneTwo: UILabel = {
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 15))
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = .lightGray
            label.text = "ТЕЛЕФОН"
            
            return label
        }()
        
        let textPhoneTwo: UITextView = {
            let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
            text.font = UIFont.systemFont(ofSize: 14)
            text.text = "+7 (926) 753-66-95"
            text.backgroundColor = .vanillaWhiteContrast
            
            return text
        }()
        
        let linesPhoneTwo: UIView = {
            let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
            view.backgroundColor = .black
            
            return view
        }()
    
    //MARK: - Country
    let country: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 600, width: 350, height: 75))
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let labelCountry: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 15))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "СТРАНА"
        
        return label
    }()
    
    let textCountry: UITextView = {
        let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "Россия"
        text.backgroundColor = .vanillaWhiteContrast
        
        return text
    }()
    
    let linesCountry: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: - Street
    let street: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 700, width: 350, height: 75))
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let labelStreet: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 15))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "АДРЕС КОМПАНИИ"
        
        return label
    }()
    
    let textStreet: UITextView = {
        let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "Маломосковская улица 22/1"
        text.backgroundColor = .vanillaWhiteContrast
        
        return text
    }()
    
    let linesStreet: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    //MARK: - Tag
    let tag: UIView = {
        let view = UIView(frame: CGRect(x: 15, y: 800, width: 350, height: 75))
        view.backgroundColor = .vanillaWhiteContrast
        
        
        return view
    }()
    
    let labelTag: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 15))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "ТЕГИ"
        
        return label
    }()
    
    let textTag: UITextView = {
        let text = UITextView(frame: CGRect(x: 5, y: 30, width: 310, height: 30))
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = "#live #bisuness #moneyFlow"
        text.backgroundColor = .vanillaWhiteContrast
        
        return text
    }()
    
    let linesTag: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 70, width: 310, height: 1))
        view.backgroundColor = .black
        
        return view
    }()
    
    
    //MARK: - Button Turn
    let buttonTurn: UIButton = {
        let button = UIButton(frame: CGRect(x: 250, y: 885, width: 100, height: 30))
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(turnDetailed), for: .touchUpInside)
        button.underLineButton(text: "свернуть ∧")
        return button
    }()
    
    @objc func turnDetailed() {
        
        UIView.animate(withDuration: 0.4) { [self] in
            viewEdit.frame = CGRect(x: 20, y: 50, width: 375, height: 380)
            buttonChangeCard.frame = CGRect(x: 20, y: 450, width: 375, height: 60)
            
            industry.isHidden = false
            company.isHidden = false
            imageCompany.isHidden = true
            phone.isHidden = true
            country.isHidden = true
            street.isHidden = true
            tag.isHidden = true
            
            buttonTurn.isHidden = true
            buttonDetailed.isHidden = false
            
         
            heightConstraint.constant = 800
            
            
     
        }
    }
    

    
    
    
    
    let buttonChangeCard: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 450, width: 375, height: 60))
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("ИЗМЕНИТЬ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionChangeCard), for: .touchUpInside)
        
        
        return button
    }()
    
    let buttonSaveCard: UIButton = {
        let button = UIButton(frame: CGRect(x: 15, y: 900, width: 375, height: 60))
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionSaveCard), for: .touchUpInside)
        
        return button
    }()
    
    
   
    
    //MARK: - actionChangeCard
    @objc func actionChangeCard() {
        print("ActionSaveButton")
        buttonChangeCard.isHidden = true
        buttonSaveCard.isHidden = false

        viewEdit.isHidden = false
        viewEdit.frame.size.height = 930
        buttonSaveCard.frame = CGRect(x: 20, y: 1000, width: 375, height: 60) // default height: 435
        heightConstraint.constant = 1200
        
        
        
        
        buttonDetailed.isHidden = true
        buttonTurn.isHidden = true
        
        
        industry.isHidden = false
        company.isHidden = false
        imageCompany.isHidden = false
        phone.isHidden = false
        country.isHidden = false
        street.isHidden = false
        tag.isHidden = false
        
        
        settingEditableAndScroll(textView: textIndustry, isWorksEdit: true)
        settingEditableAndScroll(textView: textCompany, isWorksEdit: true)
        settingEditableAndScroll(textView: textPhoneTwo, isWorksEdit: true)
        settingEditableAndScroll(textView: textCountry, isWorksEdit: true)
        settingEditableAndScroll(textView: textStreet, isWorksEdit: true)
        settingEditableAndScroll(textView: textTag, isWorksEdit: true)
        
    }
    
    
    //MARK: - actionSaveCard
    @objc func actionSaveCard() {
        print("actionChangeButton")
        buttonChangeCard.isHidden = false
        buttonSaveCard.isHidden = true
    
        viewEdit.isHidden = false
        
        
        
        UIView.animate(withDuration: 0.4) {
            self.viewEdit.frame.size.height = 380
            self.buttonChangeCard.frame = CGRect(x: 20, y: 450, width: 375, height: 60) // default height: 435
        }
       
        
        
        
        
        
        buttonDetailed.isHidden = false
        buttonTurn.isHidden = true
        
        
        industry.isHidden = false
        company.isHidden = false
        imageCompany.isHidden = true
        phone.isHidden = true
        country.isHidden = true
        street.isHidden = true
        tag.isHidden = true
        
        settingEditableAndScroll(textView: textIndustry, isWorksEdit: false)
        settingEditableAndScroll(textView: textCompany, isWorksEdit: false)
        settingEditableAndScroll(textView: textPhoneTwo, isWorksEdit: false)
        settingEditableAndScroll(textView: textCountry, isWorksEdit: false)
        settingEditableAndScroll(textView: textStreet, isWorksEdit: false)
        settingEditableAndScroll(textView: textTag, isWorksEdit: false)
        
        heightConstraint.constant = 800
    }
    
    
    //MARK: - ScreenCard
    func screenCard() {
        
        contentView.addSubview(contentViewMyCard)
        
        contentViewMyCard.addSubview(viewEdit)
        
        viewEdit.addSubview(avatarCard)
        viewEdit.addSubview(nameCard)
        viewEdit.addSubview(statusCard)
        viewEdit.addSubview(verificationStatus)
        
        viewEdit.addSubview(industry)
        industry.addSubview(labelIndustry)
        industry.addSubview(textIndustry)
        industry.addSubview(linesIndustry)
        
       
        
        viewEdit.addSubview(company)
        company.addSubview(labelCompany)
        company.addSubview(textCompany)
        company.addSubview(linesCompany)
        
        viewEdit.addSubview(buttonDetailed)
        
        viewEdit.addSubview(imageCompany)
        
        viewEdit.addSubview(phone)
        phone.addSubview(labelPhoneTwo)
        phone.addSubview(textPhoneTwo)
        phone.addSubview(linesPhoneTwo)
        
        
        viewEdit.addSubview(country)
        country.addSubview(labelCountry)
        country.addSubview(textCountry)
        country.addSubview(linesCountry)
        
        viewEdit.addSubview(street)
        street.addSubview(labelStreet)
        street.addSubview(textStreet)
        street.addSubview(linesStreet)
        
        
        viewEdit.addSubview(tag)
        tag.addSubview(labelTag)
        tag.addSubview(textTag)
        tag.addSubview(linesTag)
        

        
        settingEditableAndScroll(textView: textIndustry, isWorksEdit: false)
        settingEditableAndScroll(textView: textCompany, isWorksEdit: false)
        settingEditableAndScroll(textView: textPhoneTwo, isWorksEdit: false)
        settingEditableAndScroll(textView: textCountry, isWorksEdit: false)
        settingEditableAndScroll(textView: textStreet, isWorksEdit: false)
        settingEditableAndScroll(textView: textTag, isWorksEdit: false)
        
        viewEdit.addSubview(buttonTurn)
        
        buttonTurn.isHidden = true
        
        industry.isHidden = false
        company.isHidden = false
        imageCompany.isHidden = true
        phone.isHidden = true
        country.isHidden = true
        street.isHidden = true
        tag.isHidden = true
        
        
        contentViewMyCard.addSubview(buttonChangeCard)
        contentViewMyCard.addSubview(buttonSaveCard)

        buttonSaveCard.isHidden = true
        
        //MARK: - droppingViewEdit
        viewEdit.frame = CGRect(x: 20, y: 50, width: 375, height: 380)
        buttonChangeCard.frame = CGRect(x: 20, y: 450, width: 375, height: 60)
        
        industry.isHidden = false
        company.isHidden = false
        imageCompany.isHidden = true
        phone.isHidden = true
        country.isHidden = true
        street.isHidden = true
        tag.isHidden = true
        
        buttonTurn.isHidden = true
        buttonDetailed.isHidden = false
        
        buttonChangeCard.isHidden = false
        buttonSaveCard.isHidden = true
        
        heightConstraint.constant = 800
    }
    
    
    
    //MARK: -c ontentViewOffer
    let contentViewOffer: UIView = {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let view = UIView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: 1100))
        return view
    }()
    
    let buttonBar: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 43))
        view.backgroundColor = .vanillaWhite
        
        return view
    }()
    
    let buttonActual: UIButton = {
        let button = UIButton(frame: CGRect(x: 30, y: 5, width: 150, height: 35))
        button.setTitle("актуальные", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .vanillaWhiteContrast
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionActual), for: .touchUpInside)
        
        return button
    }()
    
    let buttonOverdue: UIButton = {
        let button = UIButton(frame: CGRect(x: 180, y: 5, width: 150, height: 35))
        button.setTitle("просроченные", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionOverdue), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func actionActual() {
        
        buttonOverdue.setTitleColor(.lightGray, for: .normal)
        buttonOverdue.backgroundColor = .clear
        
        buttonActual.setTitleColor(.black, for: .normal)
        buttonActual.backgroundColor = .vanillaWhiteContrast
        
        
    }
    
    @objc func actionOverdue() {
        
        buttonActual.setTitleColor(.lightGray, for: .normal)
        buttonActual.backgroundColor = .clear
        
        buttonOverdue.setTitleColor(.black, for: .normal)
        buttonOverdue.backgroundColor = .vanillaWhiteContrast
        
    }
    
    
    
    //MARK: - Offers
    let offerOne: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 80, width: 355, height: 200))
        view.layer.cornerRadius = 5
        view.backgroundColor = .red
        
        return view
    }()
    
    let topOne: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 315, height: 35))
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        label.text = "СПЕЦИАЛЬНАЯ ЦЕНА\nДЛЯ УЧАСТНИКОВ СООБЩЕСТВА"
        
        return label
    }()
    
    let centerTwo: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 128, width: 315, height: 25))
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.text = "СКИДКА 10%"
        
        return label
    }()
    
    
    let bottomThree: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 160, width: 315, height: 25))
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "НА ВСЕ АРОМА МАСЛА Как реализовать остальные?"
        
        return label
    }()
    
    
    let buttonCreate: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 250, width: 375, height: 65))
        button.backgroundColor = .black
        button.setTitle("СОЗДАТЬ ЕЩЕ", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionCreate), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func actionCreate() {
        print("actionCreate")
        
        let vc = EditOffer()
        contentViewOffer.addSubview(vc)
        
   
    }
 
    
    func screenOffer() {
        
        contentView.addSubview(contentViewOffer)
        contentViewOffer.addSubview(buttonBar)
        
        buttonBar.addSubview(buttonActual)
        buttonBar.addSubview(buttonOverdue)
        
    
        contentViewOffer.addSubview(offerOne)
        
        offerOne.addSubview(topOne)
        offerOne.addSubview(centerTwo)
        offerOne.addSubview(bottomThree)
        
        contentViewOffer.addSubview(buttonCreate)


    }
    
    
}


 
