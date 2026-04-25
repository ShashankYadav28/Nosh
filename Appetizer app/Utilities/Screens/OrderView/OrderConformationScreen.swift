import SwiftUI

struct OrderConformationScreen: View {

    @EnvironmentObject var order: Order
    @EnvironmentObject var orderHistory: OrderHistoryModel

    @Binding var showConformationScreen: Bool
    @Binding var selectedTab: Int

    @State private var isProcessing = true
    @State private var showSuccess = false
    @State private var showProfileAlert = false

    var body: some View {

        NavigationStack {

            ZStack {

                if isProcessing {

                    ProgressView("Processing your order")
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: .brandPrimary)
                        )
                }

                if showSuccess {

                    VStack(spacing: 20) {

                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)

                        Text("Order Confirmed")
                            .font(.system(size: 32, weight: .semibold))

                        Text("Your order is on the way")
                            .foregroundColor(.secondary)

                        Button("Back to Home") {
                            showConformationScreen = false
                            selectedTab = 0
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }

            .onAppear {

                guard !order.items.isEmpty else { return }

                guard DatabaseManager.shared.userExists() else {

                    isProcessing = false
                    showProfileAlert = true
                    return
                }

                let totalAmount = order.totalPrice
                let itemCount = order.items.reduce(0) { $0 + $1.quantity }

                DatabaseManager.shared.insertOrder(
                    items: order.items,
                    totalAmount: totalAmount,
                    itemCount: itemCount
                )

                orderHistory.loadOrders()

                order.clear()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                    withAnimation(.easeIn(duration: 0.5)) {

                        isProcessing = false
                        showSuccess = true
                    }
                }
            }

            .alert("Profile Required",
                   isPresented: $showProfileAlert) {

                Button("Go to Profile") {

                    showConformationScreen = false
                    selectedTab = 1
                }

                Button("Cancel", role: .cancel) {

                    showConformationScreen = false
                }

            } message: {

                Text("Please complete your account profile before placing an order.")
            }
        }
    }
}
