//
//  DataManager.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    var questionBank = [QuestionModel]()
    
    private init() {
        if let savedQuestionBank = UserDefaults.standard.data(forKey: "questionBank") {
            let decoder = JSONDecoder()
            do {
                questionBank = try decoder.decode([QuestionModel].self, from: savedQuestionBank)
            } catch {
                print("Failed to decode data: \(error.localizedDescription)")
            }
        }
    }
}

extension UIViewController {
    
    func showErrorAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: completion)
    }
}
