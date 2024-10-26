//
//  WebViewController.swift
//  PersonInformation
//
//  Created by Isabel on 19/02/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    var webURL: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlWeb = URL(string: webURL)
        let webURLRequest = URLRequest(url: urlWeb!)
        webView.load(webURLRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
