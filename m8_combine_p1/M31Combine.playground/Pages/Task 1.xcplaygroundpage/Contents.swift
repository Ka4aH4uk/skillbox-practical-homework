import Combine

//let publisher = PassthroughSubject<Int, Never>()

let publisher = (1...5).map { _ in
    Int.random(in: 1...100)
}.publisher

let subscription = publisher
    .sink(receiveValue: { value in
        print(value)
    })
