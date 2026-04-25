import SwiftUI

struct OrderHistoryView: View {

    @EnvironmentObject var orderHistory: OrderHistoryModel

    var body: some View {

        Group {

            if orderHistory.pastOrders.isEmpty {

                Text("No past orders")
                    .foregroundColor(.gray)
                    .italic()

            } else {

                List {

                    ForEach(orderHistory.pastOrders, id: \.0) { order in

                        VStack(alignment: .leading, spacing: 8) {

                            Text("Order #\(order.0)")
                                .font(.headline)

                            Text(formatDate(order.1))
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Items: \(order.3)")
                                .font(.subheadline)

                            Text("Total: $\(order.2, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                        }
                        .padding(.vertical,6)
                    }
                }
            }
        }

        .navigationTitle("Order History")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Date Formatter

    func formatDate(_ isoDate:String) -> String {

        let isoFormatter = ISO8601DateFormatter()

        if let date = isoFormatter.date(from: isoDate) {

            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short

            return formatter.string(from: date)
        }

        return isoDate
    }
}
