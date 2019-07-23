//
//  AnagramsTableViewController.swift
//  Project5
//
//  Created by Alex Ladines on 7/22/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class AnagramsTableViewController: UITableViewController {
    // MARK: - Properties
    var allWords = [String]()
    var usedWords = [String]()

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newWord))

        // Use words from start.txt
        guard
            let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            // try? -> if error throw back nil
            let startWords = try? String(contentsOf: startWordsURL)
            else { return }

        allWords = startWords.components(separatedBy: "\n")

        if allWords.isEmpty {
            allWords = ["laptop"]
        }

        startGame()
    }

    // MARK: - Methods
    // Selects a random word
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        // .reloadData() -> calls numberOfRowsInSection and cellForRowAt
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    @objc func newWord() {
        startGame()
    }

    func submit(_ answer: String) {
        let lowercasedAnswer = answer.lowercased()

        let errorTitle: String
        let errorMessage: String

        if isPossible(word: lowercasedAnswer) {
            if isOriginal(word: lowercasedAnswer) {
                if isReal(word: lowercasedAnswer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                }
                else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            }
            else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        }
        else {
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }

        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)

    }

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }
            else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    // MARK: - Navigation

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

}
