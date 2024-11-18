//
//  MainViewController.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Quiz"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for index in 0..<DataManager.shared.questionBank.count {
            DataManager.shared.questionBank[index].userAnswer = nil
        }
    }
    
    @IBAction func buildQuestionBankTapped(_ sender: Any) {
        let questionBankViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionBankViewController") as! QuestionBankViewController
        navigationController?.pushViewController(questionBankViewController, animated: true)
    }
    
    @IBAction func startTheQuizTapped(_ sender: Any) {
        let quizViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        navigationController?.pushViewController(quizViewController, animated: true)
    }

}

