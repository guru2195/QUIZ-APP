//
//  QuizViewController.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question Bank"
        
        optionButton1.setImage(UIImage(systemName: "circle"), for: .normal)
        optionButton1.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        optionButton2.setImage(UIImage(systemName: "circle"), for: .normal)
        optionButton2.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        optionButton3.setImage(UIImage(systemName: "circle"), for: .normal)
        optionButton3.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        optionButton4.setImage(UIImage(systemName: "circle"), for: .normal)
        optionButton4.setImage(UIImage(systemName: "circle.fill"), for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateQuestion()
    }
    
    func updateQuestion() {
        guard DataManager.shared.questionBank.count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "No questions available", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        questionLabel.text = DataManager.shared.questionBank[count].question
        
        optionButton1.setTitle(DataManager.shared.questionBank[count].options?[0], for: .normal)
        optionButton2.setTitle(DataManager.shared.questionBank[count].options?[1], for: .normal)
        optionButton3.setTitle(DataManager.shared.questionBank[count].options?[2], for: .normal)
        optionButton4.setTitle(DataManager.shared.questionBank[count].options?[3], for: .normal)
        
        optionButton1.isSelected = DataManager.shared.questionBank[count].userAnswer == 0
        optionButton2.isSelected = DataManager.shared.questionBank[count].userAnswer == 1
        optionButton3.isSelected = DataManager.shared.questionBank[count].userAnswer == 2
        optionButton4.isSelected = DataManager.shared.questionBank[count].userAnswer == 3
        
        progressView.setProgress(Float(count + 1)/Float(DataManager.shared.questionBank.count), animated: true)
    }
    
    @IBAction func option1Selected(_ sender: UIButton) {
        optionButton1.isSelected = true
        optionButton2.isSelected = false
        optionButton3.isSelected = false
        optionButton4.isSelected = false
    }
    
    @IBAction func option2Selected(_ sender: UIButton) {
        optionButton1.isSelected = false
        optionButton2.isSelected = true
        optionButton3.isSelected = false
        optionButton4.isSelected = false
    }
    
    @IBAction func option3Selected(_ sender: UIButton) {
        optionButton1.isSelected = false
        optionButton2.isSelected = false
        optionButton3.isSelected = true
        optionButton4.isSelected = false
    }
    
    @IBAction func option4Selected(_ sender: UIButton) {
        optionButton1.isSelected = false
        optionButton2.isSelected = false
        optionButton3.isSelected = false
        optionButton4.isSelected = true
    }
    
    @IBAction func forwardButtonTapped() {
        guard optionButton1.isSelected || optionButton2.isSelected || optionButton3.isSelected || optionButton4.isSelected else {
            showErrorAlert(message: "All questions must be answered.")
            return
        }
        DataManager.shared.questionBank[count].userAnswer = optionButton1.isSelected ? 0 : optionButton2.isSelected ? 1 : optionButton3.isSelected ? 2 : 3
        
        if count < DataManager.shared.questionBank.count - 1 {
            count += 1
            updateQuestion()
        } else {
            calculateResult()
        }
    }
    
    func calculateResult() {
        let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @IBAction func backwardButtonTapped() {
        guard count > 0 else { return }
        count -= 1
        updateQuestion()
    }
    
}
