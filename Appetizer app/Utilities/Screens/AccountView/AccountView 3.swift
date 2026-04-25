import SwiftUI

struct AccountView: View {

    @StateObject var viewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField?

    private var hundredTenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }

    private var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }

    enum FormTextField {
        case firstName, lastName, email
    }

    var body: some View {

        NavigationView {

            Form {

                // MARK: PERSONAL INFO
                Section {

                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusedTextField, equals: .firstName)
                        .submitLabel(.next)

                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusedTextField, equals: .lastName)
                        .submitLabel(.next)

                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusedTextField, equals: .email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    DatePicker(
                        "Birthday",
                        selection: $viewModel.user.birthdate,
                        in: hundredTenYearsAgo...eighteenYearsAgo,
                        displayedComponents: .date
                    )

                    Button("Save Changes") {
                        viewModel.saveChanges()
                    }

                } header: {
                    Text("Personal Info")
                }

                // MARK: REQUESTS
                Section(header: Text("Requests")) {

                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkin)
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                }
                .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))

                // MARK: ORDERS
                Section(header: Text("Orders")) {

                    NavigationLink(destination: OrderHistoryView()) {
                        Label("Order History", systemImage: "clock.arrow.circlepath")
                    }
                }
            }

            .navigationTitle("Account")

            .toolbar {

                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") {
                        focusedTextField = nil
                    }
                }
            }
        }

        .onAppear {
            viewModel.retrieveUser()
        }

        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.Title,
                message: alertItem.message,
                dismissButton: alertItem.dissmedButton
            )
        }
    }
}
