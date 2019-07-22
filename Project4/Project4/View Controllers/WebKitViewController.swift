//
//  WebKitViewController.swift
//  Project4
//
//  Created by Alex Ladines on 7/22/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        // UIProgressView
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)


        // The addObserver() method takes four parameters: who the observer is (we're the observer, so we use self),
        // what property we want to observe (we want the estimatedProgress property of WKWebView), which value we
        // want (we want the value that was just set, so we want the new one), and a context value.
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }

    // MARK: - Methods
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac,animated: true)

    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    // MARK: - Navigation

    // MARK: - WKNavigationDelegate
    // This decisionHandler is also a closure, except it's the other way around – rather than giving someone else a chunk of code to execute,
    // you're being given it and are required to execute it.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }

        decisionHandler(.cancel)
    }


}
