//
//  ShoppingListTableViewController.swift
//  Milestone2
//
//  Created by Alex Ladines on 7/23/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

    // MARK: - Properties
    var shoppingItems = [String]()

    // MARK: - IBOutlets

    // MARK: - IBActions

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Bar button items
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems))
    }

    // MARK: - Methods

    // Right Bar Button - This brings up an alert controller to add an item
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Add Item", message: "Please enter your item below", preferredStyle: .alert)
        ac.addTextField()

        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text, item.count > 0 else { return }
            self?.addItem(item)
        }

        ac.addAction(action)
        present(ac, animated: true)
    }

    // Adds item to shopping list
    func addItem(_ item: String) {
        shoppingItems.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // Deletes all items
    @objc func deleteItems() {
        shoppingItems.removeAll()
        tableView.reloadData()
    }

    // MARK: - Navigation

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

}
