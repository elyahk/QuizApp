//
//  QuestionPresenter.swift
//  
//
//  Created by Eldorbek on 21/05/22.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }

        return "Question #\(index + 1)"
    }
}
