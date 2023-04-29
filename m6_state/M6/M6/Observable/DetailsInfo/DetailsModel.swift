import Foundation

struct DetailsResponse {
    let id: Int?
    let isActive: Bool?
    let policyStartDate: String?
    let policyEndDate: String?
    let price: Double?
    let company: String?
    let car: String?
    let licencePlate: String?
    let insurant: String
    let owner: String
}

extension DetailsResponse {
    enum Seeds {
        public static let defaultModel = DetailsResponse(
            id: 5287607,
            isActive: true,
            policyStartDate: "2021-12-14",
            policyEndDate: "2022-12-13",
            price: 5825.22,
            company: "Компания",
            car: "Audi",
            licencePlate: "Н 747 НН 77",
            insurant: "Антон К.",
            owner: "Антон К."
        )
        
        public static let empty = DetailsResponse(
            id: 0,
            isActive: false,
            policyStartDate: "",
            policyEndDate: "",
            price: 0,
            company: "",
            car: "",
            licencePlate: "",
            insurant: "",
            owner: ""
        )
    }
}
