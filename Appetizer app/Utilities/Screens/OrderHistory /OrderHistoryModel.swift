import Foundation

final class OrderHistoryModel: ObservableObject {

    @Published var pastOrders: [(Int,String,Double,Int)] = []

    init() {

        loadOrders()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadOrders),
            name: .ordersUpdated,
            object: nil
        )
    }

    @objc func reloadOrders() {
        loadOrders()
    }

    func loadOrders() {
        pastOrders = DatabaseManager.shared.fetchOrders()
    }
}
