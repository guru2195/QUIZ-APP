//
//  AddEditQuestionViewController.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import UIKit

class AddEditQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
        
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    @IBOutlet weak var option3TextField: UITextField!
    @IBOutlet weak var option4TextField: UITextField!
        
    var questionModel: QuestionModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question Builder"
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,action: #selector(leftButtonTapped))
        self.navigationItem.setLeftBarButton(leftButton, animated: true)

        
        
        if questionModel == nil {
            questionModel = QuestionModel()
            
            let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,action: #selector(rightButtonTapped))
            
            self.navigationItem.setRightBarButton(rightButton, animated: true)
        } else {
            questionTextField.text = questionModel.question
            option1TextField.text = questionModel.options?[0]
            option2TextField.text = questionModel.options?[1]
            option3TextField.text = questionModel.options?[2]
            option4TextField.text = questionModel.options?[3]
            
            let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self,action: #selector(rightButtonTapped))
            self.navigationItem.setRightBarButton(rightButton, animated: true)
        }
    }
    
    @objc func leftButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightButtonTapped() {
        guard validateTextFields() else { return }
        questionModel.question = questionTextField.text
        questionModel.options = []
        if let text1 = option1TextField.text, !text1.isEmpty {
            questionModel.options?.append(text1)
        }
        if let text2 = option2TextField.text, !text2.isEmpty {
            questionModel.options?.append(text2)
        }
        if let text3 = option3TextField.text, !text3.isEmpty {
            questionModel.options?.append(text3)
        }
        if let text4 = option4TextField.text, !text4.isEmpty {
            questionModel.options?.append(text4)
        }
        questionModel.correctAnswer = 0
        
        if let idx = DataManager.shared.questionBank.firstIndex(where: { QuestionModel in
            QuestionModel.id == questionModel.id
        }) {
            DataManager.shared.questionBank[idx] = questionModel
        } else {
            DataManager.shared.questionBank.append(questionModel)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func validateTextFields() -> Bool {
        guard let text1 = questionTextField.text, !text1.isEmpty else {
            showErrorAlert(message: "Question can't be empty")
            return false
        }
        
        guard let text2 = option1TextField.text, !text2.isEmpty else {
            showErrorAlert(message: "Option 1 can't be empty")
            return false
        }
        
        guard let text3 = option2TextField.text, !text3.isEmpty else {
            showErrorAlert(message: "Option 2 can't be empty")
            return false
        }
        
        guard let text4 = option3TextField.text, !text4.isEmpty else {
            showErrorAlert(message: "Option 3 can't be empty")
            return false
        }
        
        guard let text5 = option4TextField.text, !text5.isEmpty else {
            showErrorAlert(message: "Option 4 can't be empty")
            return false
        }
        
        return true
    }
    
    

}
