//
//  PicturesTableViewController.swift
//  Project3
//
//  Created by Alex Ladines on 7/15/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class PicturesTableViewController: UITableViewController {

    // MARK: - Properties
    var pictures = [String]()

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Methods

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"

        navigationController?.navigationBar.prefersLargeTitles = true

        // Create Navigation Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!

        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }

        pictures.sort()
    }

    // MARK: - Navigation

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

        cell.textLabel?.text = pictures[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {

            vc.selectedImage = pictures[indexPath.row]
            vc.totalNumberOfPictures = pictures.count
            vc.currentPictureIndex = indexPath.row

            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - UITableViewDelegate


}
