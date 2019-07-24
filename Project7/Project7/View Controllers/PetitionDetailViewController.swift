//
//  PetitionDetailViewController.swift
//  Project7
//
//  Created by Alex Ladines on 7/24/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit
import WebKit

class PetitionDetailViewController: UIViewController {

    // MARK: - Properties
    var webView: WKWebView!
    var detailItem: Petition?

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-
        scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }

    // MARK: - Methods

    // MARK: - Navigation

}
