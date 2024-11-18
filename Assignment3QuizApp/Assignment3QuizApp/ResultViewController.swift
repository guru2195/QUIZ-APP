//
//  ResultViewController.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The Result"
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        let correctlyAnsweredQuestionCount: Int = {
            var count = 0
            DataManager.shared.questionBank.forEach { QuestionModel in
                if QuestionModel.userAnswer == QuestionModel.correctAnswer {
                    count += 1
                }
            }
            return count
        }()
        resultLbl.text = "You answered \(correctlyAnsweredQuestionCount) out of \(DataManager.shared.questionBank.count) questions correctly."
    }
    
    @objc func backAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
