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
        return "Question #1"
    }
}
