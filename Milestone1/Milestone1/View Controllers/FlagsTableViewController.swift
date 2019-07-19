//
//  FlagsTableViewController.swift
//  Milestone1
//
//  Created by Alex Ladines on 7/19/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class FlagsTableViewController: UITableViewController {
    // MARK: - Properties
    var flags: [String] = []

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Flag Viewer"

        navigationController?.navigationBar.prefersLargeTitles = true

        // Load flag names
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }

        // print(flags.count)
    }
    
    // MARK: - Methods

    // MARK: - Navigation

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row].capitalized
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FlagDetail") as? FlagDetailViewController {
            let tappedFlag = flags[indexPath.row]
            vc.imageToLoad = tappedFlag

            // Edit name of flag before passing it
            var components = tappedFlag.components(separatedBy: ".")
            components.removeLast()

            vc.imageName = components.first!

            navigationController?.pushViewController(vc, animated: true)
        }

    }

}
