//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Eldorbek on 19/05/22.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>
    let correctAnswers: [Question<String>: [String]]

    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }

    var presentableAnswers: [PresentableAnswer] {
        return result.answers.map { question, answers in
            switch question {
            case .singleAnswer(let value):
                return PresentableAnswer(
                    question: value,
                    answer: correctAnswers[question]!.first!,
                    wrongAnswer: nil
                )

            default:
                return PresentableAnswer(question: "", answer: "", wrongAnswer: nil)
            }
        }
    }
}

