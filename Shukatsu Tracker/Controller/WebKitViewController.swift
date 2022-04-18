//
//  WebKitViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 18.04.22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var link: String
    
    init(link: String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
