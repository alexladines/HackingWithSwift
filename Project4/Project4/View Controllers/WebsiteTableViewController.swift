//
//  WebsiteTableViewController.swift
//  Project4
//
//  Created by Alex Ladines on 7/22/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class WebsiteTableViewController: UITableViewController {

    // MARK: - Properties
    var websites = ["apple.com", "hackingwithswift.com"]

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Methods

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWebsite" {
            guard
                let WKVC = segue.destination as? WebKitViewController,
                let cell = sender as? UITableViewCell
                else { return }

            WKVC.websiteToLoad = cell.textLabel?.text

        }
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    
}
