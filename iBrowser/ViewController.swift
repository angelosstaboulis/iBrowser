//
//  ViewController.swift
//  iBrowser
//
//  Created by Angelos Staboulis on 14/1/24.
//

import UIKit
import WebKit
import CoreData
class PDFFlag:ObservableObject{
    
}
class ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate {
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var tableViewMenu: UITableView!
    
    @IBOutlet weak var topView: UIView!
    private var menu = ["Search Engine","Go Backward","Go Forward","Add Bookmark","List Bookmarks","Export to PDF","Export to WebArchive"]
    
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var txtWebAddress: UITextField!
    var pdfFlag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBrowserView()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnInstagram(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"https://www.instagram.com")!) {
            UIApplication.shared.open(URL(string:"https://www.instagram.com")!)
        }
        
    }
    @IBAction func btnFacebook(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"https://www.facebook.com")!) {
            UIApplication.shared.open(URL(string:"https://www.facebook.com")!)
        }
    }
    @IBAction func btnTwitter(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"https://www.twitter.com")!) {
            UIApplication.shared.open(URL(string:"https://www.twitter.com")!)
        }
    }
    
    
    @IBAction func btnWebReload(_ sender: Any) {
        webView.reload()
    }

    
    @IBAction func btnMenu(_ sender: Any) {
        tableViewMenu.isHidden.toggle()
        tableViewMenu.backgroundColor = .blue
    }
    
    
}
extension ViewController{
    func setupBrowserView(){
        webView.navigationDelegate = self
        webView.isFindInteractionEnabled = true
        webView.isUserInteractionEnabled = true
        txtWebAddress.delegate = self
        tableViewMenu.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        tableViewMenu.isHidden = true
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        createConstraints()
    }
    func createConstraints(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([tableViewMenu.topAnchor.constraint(equalTo: guide.topAnchor, constant: -5),tableViewMenu.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.6),tableViewMenu.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.53)])
        NSLayoutConstraint.activate([webView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.85),webView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.999),webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0.1)])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        webView.load(URLRequest(url: URL(string: textField.text!)!))
        return true
    }
}
extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    func openListBookmarks(){
        let bookmarks = storyboard?.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
        bookmarks.modalPresentationStyle = .fullScreen
        self.navigationController!.pushViewController(bookmarks, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.textLabel!.text == "Search Engine"{
            txtWebAddress.text = "https://duckduckgo.com"
            webView.load(URLRequest(url: URL(string:"https://duckduckgo.com")!))
        }
        if webView.canGoBack && cell?.textLabel!.text == "Go Backward"{
            webView.goBack()
        }
        if webView.canGoForward && cell?.textLabel!.text == "Go Forward"{
            webView.goForward()
        }
        if cell?.textLabel!.text == "Add Bookmark"{
            BookmarksViewModel.shared.addBookmark(webAddress: txtWebAddress.text!)
        }
        if cell?.textLabel!.text == "List Bookmarks"{
           openListBookmarks()
        }
        if cell?.textLabel!.text == "Export to PDF"{
            Helper.shared.createPDF(webView: webView)
        }
        if cell?.textLabel!.text == "Export to WebArchive"{
            Helper.shared.createWebArchive(webView: webView)
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.textLabel?.textColor = .yellow
        cell.textLabel!.text = menu[indexPath.row]
        return cell
    }
}
