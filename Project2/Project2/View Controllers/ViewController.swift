//
//  ViewController.swift
//  Project2
//
//  Created by Alex Ladines on 7/4/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    // MARK: - IBOutlets
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var countries: [String] = []
    var score = 0
    var correctAnswer = 0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland", "russia", "spain",
                      "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor


        askQuestion(action: nil)
    }

    // MARK: - Methods
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }

    // MARK: - IBActions

    @IBAction func flagButtonTapped(_ sender: UIButton) {
        var message = ""
        if sender.tag == correctAnswer {
            score = score + 1
            message = "Congrats! You got it right."
        }
        else {
            message = "Whoops! You got it wrong."
        }

        let alert = UIAlertController(title: "Total Score: \(score)", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Continue", style: .default, handler: askQuestion)
        alert.addAction(action)
        present(alert,animated: true)

    }

}

