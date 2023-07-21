import UIKit
import Combine
import SnapKit

class RandomNumWithTimerCombine: UIViewController {
    
    private let numberRange = 1...100
    private var randomNumber = Int.random(in: 1...100)
    private var isGameFinished = false
    private var startTime: Date?
    private var timerSubscription: AnyCancellable?
    private var currentElapsedTime: Int = 0

    private let timerSubject = CurrentValueSubject<Int?, Never>(nil)

    // UI-элементы
    private lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.placeholder = "Введите число"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        textField.isHidden = true
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 2.0
        textField.layer.shadowOpacity = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2.0
        textField.delegate = self
        return textField
    }()
    
    private lazy var pointLabel: UILabel = {
        let label = UILabel()
        label.text = "Угадай число от \(numberRange.lowerBound) до \(numberRange.upperBound).\nДля старта нажми 'Играть'"
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИГРАТЬ", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        restartButton.layer.cornerRadius = restartButton.bounds.width / 2.0
    }
    
    // Объявляем Publisher
    private lazy var numberPublisher = numberTextField.publisher(for: \.text)
        .compactMap { $0 }
        .map { Int($0) }
        .eraseToAnyPublisher()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        // Подписываемся на изменение текста в TextField
        numberPublisher
            .sink { [weak self] number in
                guard let self = self, let number = number, !self.isGameFinished else { return }
                self.checkNumber(number)
            }
            .store(in: &cancellables)

        // Создаем Timer.publish и связываем его с UILabel
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map { _ in
                self.currentElapsedTime += 1
                return self.currentElapsedTime
            }
            .sink { value in
                self.timerSubject.send(value)
            }
            .store(in: &cancellables)
    }

    // Обработка угаданного числа
    private func checkNumber(_ number: Int) {
        if number == randomNumber {
            isGameFinished = true
            timerSubscription?.cancel()
            timerSubscription = nil
            showResult(isTimeUp: false)
        } else if number < randomNumber {
            pointLabel.text = "Загаданное число больше"
        } else {
            pointLabel.text = "Загаданное число меньше"
        }
    }

    private func resetGame() {
        // Сброс значений
        randomNumber = Int.random(in: numberRange)
        restartButton.setTitle("СБРОС", for: .normal)
        isGameFinished = false
        pointLabel.text = nil
        timerLabel.text = nil
        numberTextField.isHidden = false
        numberTextField.text = nil
        currentElapsedTime = 0
        startTime = Date()
    }
    
    @objc private func startNewGame() {
        resetGame()

        // Отменяем предыдущий таймер и создаем новый
        timerSubscription?.cancel()
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self, let startTime = self.startTime else { return }
                let elapsedTime = Int(Date().timeIntervalSince(startTime))
                let secondsLeft = 60 - elapsedTime
                if secondsLeft > 0 {
                    self.timerLabel.text = String(format: "Осталось времени %02d:%02d сек.", secondsLeft / 60, secondsLeft % 60)
                } else {
                    self.timerLabel.text = "Время вышло. Попробуй еще раз"
                    self.pointLabel.text = nil
                    self.isGameFinished = true
                    self.timerSubscription?.cancel()
                    self.timerSubscription = nil
                }
            })
    }

    // Обновляем UILabel для отображения прошедшего времени
    private func updateTimerLabel() {
        let secondsLeft = 60 - currentElapsedTime
        timerLabel.text = secondsLeft > 0 ? "Прошло \(currentElapsedTime) сек." : nil
    }

    // Обработка результата
    private func showResult(isTimeUp: Bool) {
        timerLabel.text = nil
        pointLabel.text = nil
        numberTextField.text = nil
        let title = isTimeUp ? "Время вышло" : "Поздравляю! 🎉"
        let message = isTimeUp ? "Попробуй еще раз" : "Ты угадал число \(randomNumber) за \(Int(Date().timeIntervalSince(startTime!))) сек."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.resetGame()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Extension & UITextFieldDelegate
extension RandomNumWithTimerCombine: UITextFieldDelegate {
    private func setupViews() {
        view.addSubview(numberTextField)
        view.addSubview(pointLabel)
        view.addSubview(timerLabel)
        view.addSubview(restartButton)
    }
    
    private func setupConstraints() {
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-140)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        pointLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
        }
        
        restartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
            make.top.equalTo(numberTextField.snp.bottom).offset(100)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, let number = Int(text), !isGameFinished else {
            return
        }
        updateTimerLabel()
        checkNumber(number)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let existingText = textField.text else { return true }
        let newLength = existingText.count + string.count - range.length
        return newLength <= 3
    }
}
