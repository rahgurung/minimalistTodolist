//
//  ViewController.swift
//  SimpleTodoList
//
//  Created by Rahul Gurung on 10/08/24.
//

import UIKit

class ViewController: UITableViewController {
    // Todos added by user
    var todos = [String]()

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        let prompTodoButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPromptForTodo))
        let shareTodoButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

        navigationItem.rightBarButtonItems = [prompTodoButton, shareTodoButton]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }

    // MARK: - Private methods
    @objc
    private func didTapPromptForTodo() {
        let todoPromptController = UIAlertController(title: "Enter todo", message: nil, preferredStyle: .alert)
        todoPromptController.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak todoPromptController] _ in
            guard let answer = todoPromptController?.textFields?[0].text else { return }
            self?.addTodo(answer)
        }
        todoPromptController.addAction(submitAction)
        present(todoPromptController, animated: true)
    }
    
    @objc
    func didTapShare() {
        let todoListString = todos.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [todoListString], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func addTodo(_ todo: String) {
        todos.insert(todo, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

