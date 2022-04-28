//
//  WebKitViewController.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 18.04.22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKUIDelegate {
    deinit {
        print("WebKitViewController deinit")
    }
    var webView: WKWebView!
    private let url: URL

    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
        
        configureButtons()
    }
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRefresh() {
        webView.load(URLRequest(url: url))
    }
    
}
