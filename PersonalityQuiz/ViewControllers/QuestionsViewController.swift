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
    
    // создаем аутлет для стека, который содержит ответы на вопрос, которые выбираются исходя из положения слайдера
    // создаем массив с названиями ответов для крайних значений слайдера
    // создаем аутлет слайдера
    // для слайдера создаем обсервер, который будет устанавливать максимальное значение для слайдера, зависящее от количества элементов в массиве currentAnswers, и так же устанавливает стандартное значение слайдера, которое всегда равно количество ответов разделенному на 2 (то есть по середине располагается)
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    // создаем приватное свойство, которое на базе нашей модели, создает нам массив с вопросами
    private let questions = Question.getQuestions()
    // создаем еще одно приватное свойство, которое будет отображать индекс элемента в массиве questions, свойство будет вычисляемым
    private var questionIndex = 0
    // создаем приватное свойство, которое извлекает массив ответов из каждого элемента массива questions
    // свойство будет вычисляемым, в зависимости от индекса элемента будем извлекать нужный массив ответов
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    // создаем свойство, которое будет содержать массив выбранных нами ответов
    // помещать ответы в него мы будем при помощи экшенов, которые мы создали для кнопок
    private var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // создаем экшн для всех кнопок, которые находятся в singleStackView
    // первым действием определяем индекс нажатой кнопки
    // вторым действием, когда у нас есть индекс кнопки, извлекаем из массива ответов currentAnswers конкретный ответ выбранный пользователем
    // третьем действием нам нужно положить currentAnswer в массив выбранных ответов
    // четвертым действием нужно обновить интерфейс, для этого нужно вызвать метод nextQuestion(), который вызовет следующий вопрос либо вызовет экран с результатами
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    // создаем экшн для кнопки, которая находится в multipleStackView
    // первым действием перебираем множество элементов multipleSwitch и answer из массивов multipleSwitches и currentAnswers, с помощью метода zip, в теле цикла будем осуществлять проверку, если multipleSwitch включен, то мы добавляем ответ в массив выбранных ответов answersChosen
    // вторым действием вызываем метод nextQuestion(), для перехода к следующему вопросу
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    // создаем экшн для кнопки, которая находится в rangedStackView
    // первым действием создаем константу индекс, которая зависит от значения rangedSlider, так как значение слайдера с типом Float, а индекс с типом Int, надо значение слайдера подставить в функцию lrintf, которая значение с типом Float приводит к типу Int (правильно округляя до целых)
    // вторым действием добавляем в массив выбранных ответов ответ из массива currentAnswers с индексом, который мы высчитали в зависимости от положения слайдера
    // третьим действием вызываем метод nextQuestion(), который в нашем случае должен переходить на экран результатов
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
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
    // для первого кейса будет выполняться метод showSingleStackView, который принимает параметр currentAnswers, вычисляемое свойство, которое содержит в себе массив ответов для текущего вопроса
    // для второго кейса будет выполняться метод showMultipleStackView, который принимает параметр currentAnswers, который содержит в себе массив ответов для текущего вопроса
    // для третьего кейса будет выполнять метод showRangedStackView, который принимает параметр currentAnswers, который содержит в себе массив ответов для текущего вопроса
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    // отображаем стек с одиночными ответами
    // для этого создаем новый метод, который мы будем передавать для кейса .single функции showCurrentAnswers
    // метод будет иметь параметр answers с типом [Answer] (это массив ответов из нашей модели)
    // первым действием в методе мы будет показывать на экран singleStackView
    // вторым действием мы будем перебирать элементы button и answer из двух массивов singleButtons и answers
    // для того, чтобы бы перебрать таким образом два массива их нужно объединить при помощи метода zip
    // метод zip формирует из двух последовательностей одну, где каждый элемент этих последовательностей соотносится друг с другом
    // массив answers мы берем из нашей модели
    // внутри цикла for для кнопок из массива singleButtons присваиваем значения answer.title (title свойство из модели), которые находятся в массиве answers
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons,answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    // создаем метод для отображения стека для вопроса, где может быть несколько вариантов ответа
    // первым действием мы будем показывать на экран multipleStackView
    // вторым действием перебираем элементы label и answer из двух массивов multipleLabels и answers
    // для этого так же как и в методе showSingleStackView используем метод zip
    // внутри цикла for для лейблов из массива multipleLabels присваиваем значения answer.title, которые находятся в массиве answers
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    // создаем метод для отображения стека для вопроса, где содержатся ответы, которые выбираются исходя из положения слайдера
    // первым действием показываем на экран rangedStackView
    // вторым действием присваиваем массиву лейблов, которые находятся в этом стеке, значения ответов из массива answers
    // так как у нас 2 лейбла, а ответа 4, то нам нужно отобразить только 2 элемента из массива answers, первый и последний
    // при помощи методов first и last присваиваем текстовому значению первого элемента массива rangedLabels название первого ответа из массива answers, аналогично для текстового значения последнего элемента массива rangedLabels присваиваем название последнего ответа из массива answers
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    // создаем метод для перехода к следующему вопросу или для перехода на экран результатов
    // первым действием увеличивает questionIndex на 1, для того, чтобы перейти к следующему элементу в массиве questions
    // вторым действием делаем проверку, если индекс вопроса меньше количества элементов в массиве questions, то вызываем метод updateUI(), который вызывает уже следующий стек с новым вопросом и ответами, после чего выходит из метода
    // третье действие это переход по сегвею на экран результатов, если индекс вопроса не соответствует проверке из второго действия
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
