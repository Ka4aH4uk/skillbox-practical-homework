import Foundation

struct Breed: Identifiable {
    let id = UUID()
    let name: String
    let url: String
}

struct Animal: Identifiable {
    let name: String
    let description: String
    let breeds: [Breed]
    let id = UUID()
}

struct DataAnimals {
    let animals = [
        Animal(name: "Dog", description: "Собаки - домашние животные, одни из самых популярных и распространённых питомцев в мире. Относятся к семейству Псовых, представляя собой одомашненный подвид волков.", breeds: [Breed(name: "Bulldog", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4C9uK0aKifAP_AzqJ751RA5_7utMqagTz1A&usqp=CAU"), Breed(name: "German Shepard", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAO0MSHjt7Wb7qb2fz7DgL5IHNVYJcdSflSg&usqp=CAU"), Breed(name: "Golden Retriever", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5A-lNMgybyri7ojG0yV6J7CWKqKzkQq8P0w&usqp=CAU")]),
        Animal(name: "Cat", description: "Домашняя кошка - социальное животное, обладающее развитым интеллектом и способностями к общению, умеющее испытывать и выражать сложные чувства и эмоции. Относится к семейству Кошачьих, представляя собой одомашненный подвид лесных котов.", breeds: [Breed(name: "Siamese", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROFy7QQMPzdltjgsTeFw5soa5Klpv5FzqF9A&usqp=CAU"), Breed(name: "Persian", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-aqtzNhR8u2YIA_O-OsLUD-njmn-MH_fCkQ&usqp=CAU"), Breed(name: "Bengal", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_0FZPO3mhHPoG21BkDdXT14JZlGe4BrM2w&usqp=CAU")]),
        Animal(name: "Bird", description: "Птицы - класс позвоночных животных, представители которого хорошо характеризуются тем, что тело их покрыто перьями и передние конечности видоизменены в органы полета — крылья. ", breeds: [Breed(name: "Parrot", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFFWnfpSNcwer4KoAvM9ehTxfFVUnvVPRWhw&usqp=CAU"), Breed(name: "Dove", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWIcWaThzhxzDLFf8SMLHmlqmO-wpWxBrsPA&usqp=CAU"), Breed(name: "Finch", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxEld8cLhXGjTNXm9buaIT0pmNdLkOV-MneQ&usqp=CAU")])
    ]
}
