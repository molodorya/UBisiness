//
//  StretchHeaderController.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 10.06.2021.
//

import UIKit


class EventPage: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeContent: UILabel!
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var dateContent: UILabel!
    @IBOutlet weak var headerViewLabel: UIView!
    @IBOutlet weak var userHeader: UIView!
    @IBOutlet weak var stackViewLabel: UIStackView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewProfileLabel: UIView!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var share: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventFetchId()
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        headerView.backgroundColor = .vanillaWhite
        label.backgroundColor = .vanillaWhite
        headerViewLabel.backgroundColor = .vanillaWhite
        userHeader.backgroundColor = .vanillaWhite
        stackViewLabel.backgroundColor = .vanillaWhite
        viewProfileLabel.backgroundColor = .vanillaWhite
        
        typeContent.textColor = .white
        typeContent.textAlignment = .left
        typeContent.font = UIFont.systemFont(ofSize: 12)
        
        titleContent.textColor = .white
        titleContent.textAlignment = .left
        titleContent.font = UIFont.boldSystemFont(ofSize: 18)
        
        dateContent.textColor = .lightGray
        dateContent.textAlignment = .left
        dateContent.font = UIFont.systemFont(ofSize: 12)

        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textAlignment = .left
        
        label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.6)
        
        button.layer.cornerRadius = 5
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
    }
    
    @IBAction func navBack(_ sender: UIBarButtonItem) {
      dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: UIView) {
        let articleTitle = titleContent.text
        let titleImage = imageView.image ?? #imageLiteral(resourceName: "logo")
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare: String = "U-Bisiness: \(articleTitle ?? "Pages")"
        if let myWebsite = URL(string: "https://ubusiness-ithub.ru/") {
            let objectsToShare = [textToShare, myWebsite, image ?? titleImage] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonTouch(_ sender: UIButton) {
        let alertController = UIAlertController(title: "В разработке", message: "Возможны ошибки", preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
}



struct eventPage: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var text: String?
    var banner: String?
    var category: String?
    var users: [Int]?
    var type: String?
}

extension EventPage {
    func eventFetchId() {
        let id = UserDefaults.standard.integer(forKey: "idEventClick")
        print(id)
        
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchevent?id=\(id)")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try? JSONDecoder().decode(eventPage.self, from: data)
                    DispatchQueue.main.async {
//                        titleContent.text = "json?.title"
                        typeContent.text = json?.type
                        dateContent.text = json?.date
                        imageView.downloaded(from: "https://ubusiness-ithub.ru/events/\(json?.banner ?? "")")
                        
                       
                        
                        label.text = json?.text
                        print("fwdefge")
                    }
                } catch let error as NSError {
                    print("EventPage: \(error.localizedDescription)")
                }
            }
        })
        task.resume()
    }
}
