//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Олег Федоров on 31.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateResult()
        
        navigationItem.hidesBackButton = true
    }
    
    private func calculateResult() {
        var frequencyOfAnswers: [Animal: Int] = [:]
        
        let answerTypes = answers.map { $0.animal }
        
        for answer in answerTypes {
            frequencyOfAnswers[answer] = (frequencyOfAnswers[answer] ?? 0) + 1
        }
        
        let sortingFrequentAnswers = frequencyOfAnswers.sorted { pairOne, pairTwo in
            pairOne.value > pairTwo.value
        }
        
        let mostFrequentAnswer = sortingFrequentAnswers.first?.key
        
        resultLabel.text = "Вы - \(mostFrequentAnswer?.rawValue ?? "🐍")"
        definitionLabel.text = mostFrequentAnswer?.definition
    }
    
}
