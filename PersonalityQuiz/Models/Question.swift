//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Олег Федоров on 27.08.2021.
//

// Структура Question, которая содержит 3 свойства и один метод
// первое свойство - это название вопроса
// второе свойство - это тип вопроса, тип данных у этого свойства ResponseType (название перечисления с типами вопросов)
// третье свойство - это массив ответов на вопросы, тип данных у этого свойства [Answer] (массив ответов с типом Answer, который является названием структуры с ответами)
// метод, который реализован в структуре, создан для получения массива вопросов. всего в массиве будет 3 вопроса, каждый вопрос имеет свой тип ResponseType, свое название title и свой массив ответов answers, в свою очередь каждый ответ в массиве answers имеет свои параметры title и animal, которые берутся из структуры Answer.
struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обнимать", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                    Answer(title: "Обожаю", animal: .dog)
                ]
            )
        ]
    }
}

// Структура Answer, которая содержит два свойства
// первое свойство - само название ответа
// второе свойство - это животное, которое будет соотносится с ответом, тип данных у свойства Animal (название перечисления содержащего кейсы с названием животных)
struct Answer {
    let title: String
    let animal: Animal
}

// Перечисление ResponseType, которое содержит 3 свойства (кейса)
// Каждый кейс отвечает за тип вопроса: выбирается один вариант, выбирается несколько вариантов и выбирается исходя из положения слайдера 
enum ResponseType {
    case single
    case multiple
    case ranged
}

// Перечисление Animal со связанным типом Character, содержит 4 кейса и одно вычисляемое свойство
// Каждому кейсу присвоено свое значение (эмоджи, которое отображает тип животного)
// Вычисляемое свойство definition, возвращающее строковое значение, где реализован метод switch, который перебирает кейсы в этом перечислении, и в зависимости от того, какой выбран кейс, возвращает описание конкретного кейса
enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь"
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энерегии "
        case .turtle:
             return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}
