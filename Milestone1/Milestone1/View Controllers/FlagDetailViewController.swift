//
//  FlagDetailViewController.swift
//  Milestone1
//
//  Created by Alex Ladines on 7/19/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class FlagDetailViewController: UIViewController {
    // MARK: - Properties
    var imageName: String?
    var imageToLoad: String?

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let flagName = imageName,
            let flagImage = imageToLoad else {
                return
        }

        title = flagName.uppercased()
        navigationItem.largeTitleDisplayMode = .never

        imageView.image = UIImage(named: flagImage)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }

    // MARK: - Methods
    @objc func shareFlag() {
        guard let flag = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found.")
            return
        }

        let vc = UIActivityViewController(activityItems: [flag], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)

        // Crash if selects save because we need to allow user permission in Info.plist
    }

    // MARK: - Navigation


}
