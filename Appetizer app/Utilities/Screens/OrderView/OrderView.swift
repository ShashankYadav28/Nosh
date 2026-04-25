import SwiftUI

struct OrderView: View {

    @Binding var selectedTab: Int
    @State private var showConformationScreen = false

    @EnvironmentObject var order: Order
    @EnvironmentObject var orderHistory: OrderHistoryModel

    var body: some View {

        NavigationView {

            ZStack {

                VStack {

                    List {

                        ForEach(order.items, id: \.id) { item in
                            orderLIstCell(orderItem: item)
                        }

                        .onDelete { indexSet in
                            order.items.remove(atOffsets: indexSet)
                        }
                    }

                    .listStyle(.plain)

                    Button {
                        showConformationScreen = true
                    } label: {
                        APButton(title: "$\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
                    .padding(.bottom, 25)
                    .disabled(order.items.isEmpty)

                    .fullScreenCover(isPresented: $showConformationScreen) {

                        OrderConformationScreen(
                            showConformationScreen: $showConformationScreen,
                            selectedTab: $selectedTab
                        )
                        .environmentObject(order)
                        .environmentObject(orderHistory)
                    }
                }

                if order.items.isEmpty {

                    EmptyState(
                        imageName: "empty-order",
                        message: "You have no items in your order.\nPlease add an appetizer!"
                    )
                }
            }

            .navigationTitle("🧾 Orders")
        }
    }
}
