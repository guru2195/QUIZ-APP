//
//  QuestionBankViewController.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import UIKit

class QuestionBankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question Bank"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionTableView.reloadData()
    }
    
    @IBAction func editingBtnTapped() {
        questionTableView.isEditing.toggle()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.questionBank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionTableViewCell", for: indexPath)
        cell.textLabel?.text = DataManager.shared.questionBank[indexPath.row].question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionModel = DataManager.shared.questionBank[indexPath.row]
        let addEditQuestionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditQuestionViewController") as! AddEditQuestionViewController
        addEditQuestionViewController.questionModel = questionModel
        navigationController?.pushViewController(addEditQuestionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Perform the action for deleting the row
            DataManager.shared.questionBank.remove(at: indexPath.row)  // Example: remove from your data source
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
}
