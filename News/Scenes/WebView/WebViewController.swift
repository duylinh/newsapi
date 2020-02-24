//
//  WebViewController.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
import WebKit

// swiftlint:disable all

final class WebViewController: BaseController {
    
    internal static func instantiate() -> WebViewController {
        return Storyboard.Article.instantiate(type: WebViewController.self)
    }
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    var article: ArticleModel? {
        didSet {
            guard let urlString = article?.url else { return }
            guard let myURL = URL(string: urlString) else { return }
            self.displayLoading()
            let myRequest = URLRequest(url: myURL,
                                       cachePolicy: .reloadIgnoringCacheData,
                                       timeoutInterval: 10.0)
            webView.load(myRequest)
            self.title = article?.title ?? urlString
        }
    }
    
    // MARK: - Overridden: UIViewController
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBarImage = "ic_back"
    }
}

extension WebViewController: WKUIDelegate {}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoading()
        self.view.endEditing(true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideLoading()
        self.view.endEditing(true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url, let scheme = url.scheme else {
            decisionHandler(.cancel)
            return
        }
        if scheme == "tel" {
            let resourceSpecifier = (url as NSURL?)?.resourceSpecifier
            UIApplication.shared.open(URL(string: "telprompt://" + resourceSpecifier!)!)
        }
        if (url.absoluteString.contains("//itunes.apple.com")){
            if url.scheme == "itms-apps" {
                guard let urlString = url.absoluteString.components(separatedBy: "itms-apps").last else { return  }
                if let link = URL(string: ("https" + urlString)) {
                    UIApplication.shared.open(link)
                }
            } else{
                if let link = URL(string: (url.absoluteString)) {
                    UIApplication.shared.open(link)
                }
            }
        }
        decisionHandler(.allow)
    }
}
