//
//  DetailViewController.swift
//  Project3
//
//  Created by Alex Ladines on 7/15/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var currentPictureIndex: Int?
    var totalNumberOfPictures: Int?

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Methods
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return

        }

            let vc = UIActivityViewController(activityItems: [image],
                                              applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem =
                navigationItem.rightBarButtonItem
            present(vc, animated: true)

        }

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(currentPictureIndex! + 1) of \(totalNumberOfPictures!)"
        //title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Create Navigation Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    // MARK: - Navigation
    
}
