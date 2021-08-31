//
//  QuestionsViewController.swift
//  PersonalityQuiz
//
//  Created by Олег Федоров on 31.08.2021.
//

import UIKit

class QuestionsViewController: UIViewController {
    // создаем аутлеты для лейбла, который содержит вопрос и для прогресс вью
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionsProgressView: UIProgressView!
    
    // создаем аутлет для стэка, который содержит одиночные ответы на вопрос
    // так же создаем аутлет с массивом кнопок, которые находятся в этом стеке
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    // создаем аутлет для стека, который содержит ответы на вопрос, на который может быть несколько вариантов ответа
    // создаем массив названий ответов, которые находятся в этом стеке
    // создаем массив свичей, которые так же находятся в стеке
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    // создаем аутлет для стека, который содержит ответы на вопрос, которые выбираются исходя из значения слайдера
    // создаем массив с названиями ответов для крайних значений слайдера
    // создаем аутлет слайдера
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    // создаем приватное свойство, которое на базе нашей модели, создает нам массив с вопросами
    private let questions = Question.getQuestions()
    // создаем еще одно приватное свойство, которое будет отображать индекс вопроса в массиве, свойство будет вычисляемым
    private var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // создаем экшн для всех кнопок, которые находятся в singleStackView
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
    }
    
    // создаем экшн для кнопки, которая находится в multipleStackView
    @IBAction func multipleAnswerButtonPressed() {
    }
    
    // создаем экшн для кнопки, которая находится в rangedStackView
    @IBAction func rangedAnswerButtonPressed() {
    }
}

// MARK: - Private Methods
extension QuestionsViewController {
    // создаем метод, который будет связан со всем, что обновляет интерфейс экрана
    private func updateUI() {
        // Сначала скрываем все стеки
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // получение текущего вопроса
        // создаем экземпляр модели, которая извлекает нам элемент массива questions с индексом questionIndex
        let currentQuestion = questions[questionIndex]
        
        // установка текущего вопроса для questionLabel
        // для текстового значения лейбла присваиваем название текущего вопроса, которое мы берем из свойства title модели currentQuestion
        questionLabel.text = currentQuestion.title
        
        // отображение текущего прогресса, за которой отвечает questionsProgressView
        // расчет прогресса
        // для этого делим индекс элемента массива на количество его элементов
        // для того, чтобы прогресс не равнялся 0, нужно привести операнды к типу Float
        let totalProgress = Float(questionIndex) / Float(questions.count)
        // устанавливаем уровень прогресс для questionsProgressView
        questionsProgressView.setProgress(totalProgress, animated: true)
        
        // Устанавливаем названия для навигейшен контроллера, который отображает номер вопроса из общего количества вопросов
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // показываем ответы для текущего вопроса
        // для этого нужно написать еще один метод, который будет с параметром currentQuestion.type, отвечающим за тип текущего вопроса
        // свойство type мы так же берем из модели currentQuestion
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    // создаем метод, который нам нужен для метода updateUI(), чтобы отображать ответы текущего вопроса
    // у метода будет параметр type с типом ResponseType (это перечисление типов вопроса из нашей основной модели)
    // внутри с помощью switch для нашего параметра type, мы будем перебирать наши типы вопросов из модели
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            break
        case .multiple:
            break
        case .ranged:
            break
        }
    }
}
