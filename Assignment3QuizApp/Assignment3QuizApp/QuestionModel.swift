//
//  QuestionModel.swift
//  Assignment3QuizApp
//
//  Created by Gursharan Singh on 15/11/24.
//

import Foundation

struct QuestionModel: Codable {
    var question: String?
    var options: [String]?
    var correctAnswer: Int = 0
    var userAnswer: Int?
    var id = UUID()
}
