import SwiftUI

final class DetailsState: ObservableObject {
    @Published var period: String
    @Published var insurant: String
    @Published var owner: String
    @Published var brand: String
    @Published var plate: String
    @Published var noLimits: Bool
    @Published var policyID: String

    @Published var isLoading = true
    @Published var isPresentingFailAlert = false
        
    init(
        period: String,
        insurant: String,
        owner: String,
        brand: String,
        plate: String,
        noLimits: Bool,
        policyID: String
    ) {
        self.period = period
        self.insurant = insurant
        self.owner = owner
        self.brand = brand
        self.plate = plate
        self.noLimits = noLimits
        self.policyID = policyID
    }

    static func makeState(policy: DetailsResponse) -> DetailsState {
        let startDate = policy.policyStartDate ?? ""
        let endDate = policy.policyEndDate ?? ""
        let insurant = policy.insurant
        let owner = policy.owner
        let policyID = policy.id
        let licensePlate = policy.licencePlate
        return DetailsState(
            period: "\(startDate) - \(endDate)",
            insurant: insurant ,
            owner: owner,
            brand: policy.car ?? "",
            plate: licensePlate ?? "",
            noLimits: true,
            policyID: "\(policyID ?? 0)"
        )
    }
}
