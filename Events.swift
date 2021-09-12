//
//  Events.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.06.2021.
//

import UIKit



class Events: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var leftBar: UIBarButtonItem!
    
    @IBOutlet weak var bannerButton: UIButton!
    
    
    static let cellName = "eventsCell"
    
    var search: [eventSearchType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventFetch(url: "https://ubusiness-ithub.ru/api/fetchevents")
        view.backgroundColor = UIColor.vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
        searchTextField.indent(size: 20)
        searchTextField.placeholder = "Поиск"
        
        searchView.layer.cornerRadius = 5
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.masksToBounds = true
        
        headerView.backgroundColor = UIColor.vanillaWhite
        tableView.separatorStyle = .none
        
     
        navigationController?.navigationBar.barTintColor = .vanillaWhite
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.shadowImage = UIImage()
        
        hideKeyboardWhenTappedScreen()
        
        leftBar(.init())
    }
    
    @IBAction func leftBar(_ sender: UIBarButtonItem) {
        leftBar.target = revealViewController()
        leftBar.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    var isSearch = false
    var countSearch = 0
    var countCell = 0
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        isSearch = true
        searchEvent(url: "https://ubusiness-ithub.ru/api/searchevents")
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch == true {
            return 1
        } else {
            return countCell
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch == true {
            return countSearch
        } else {
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if isSearch == true {
            if let idCard = search?[indexPath.section] {
            
                UserDefaults.standard.setValue(idCard[indexPath.row].id ?? 0, forKey: "idEventClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "EventPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        } else {
            if let idCard = search?[indexPath.row] {
            
                UserDefaults.standard.setValue(idCard[indexPath.section].id ?? 0, forKey: "idEventClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "EventPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        }
        
       

    
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Events.cellName, for: indexPath) as! EventsCell
        
        
        
        if isSearch == true {
            if let search = search?[indexPath.section] {
                cell.titleNews.text = search[indexPath.row].title
                cell.dateNews.text = search[indexPath.row].date
                cell.categoryNews.text = search[indexPath.row].type
                cell.imageNews.image = nil
                cell.imageNews.downloaded(from: "https://ubusiness-ithub.ru/events/\(search[indexPath.row].banner ?? "")")
            }
        } else {
            if let notSearch = search?[indexPath.row] {
                cell.titleNews.text = notSearch[indexPath.section].title
                cell.dateNews.text = notSearch[indexPath.section].date
                cell.categoryNews.text = notSearch[indexPath.section].type
                cell.imageNews.image = nil
                cell.imageNews.downloaded(from: "https://ubusiness-ithub.ru/events/\(notSearch[indexPath.section].banner ?? "")")
            }
        }

        
        return cell
    }
}


class EventsCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var categoryNews: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        viewCell.backgroundColor = .vanillaWhite
        imageNews.layer.cornerRadius = 30
        contentView.backgroundColor = UIColor.vanillaWhite
        
    }
}


struct EventSearch: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var banner: String?
    var category: String?
    var users: [Int]?
    var type: String?
}

typealias eventSearchType = [EventSearch]

extension Events {
    func eventFetch(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(eventSearchType.self, from: data)
                    self.search = [json]

                    DispatchQueue.main.async {
                        self.countCell = json.endIndex
                        self.tableView.reloadData()
                        
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
        })
        task.resume()
    }
    
    
    func searchEvent(url: String) {
        let parameters: [String: Any] = ["word": searchTextField.text ?? ""]

        let url = NSURL(string: url)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            if let data = data {
                print(statusCode)
                do {
                    let json = try JSONDecoder().decode(eventSearchType.self, from: data)
                    
                    self.search = [json]
                    
                    DispatchQueue.main.async {
                        self.countSearch = json.endIndex
                        self.tableView.reloadData()
                    }
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
