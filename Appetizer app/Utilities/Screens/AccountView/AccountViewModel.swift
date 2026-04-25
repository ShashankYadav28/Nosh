import SwiftUI

final class AccountViewModel: ObservableObject {

    @Published var user = User()
    @Published var alertItem: AlertItem?

    // MARK: Load user from SQLite
    func retrieveUser() {

        if let dbUser = DatabaseManager.shared.fetchUser() {
            user = dbUser
        }
    }

    // MARK: Save or Update User
    func saveChanges() {

        guard isValidForm else { return }

        DatabaseManager.shared.insertUser(user: user)

        alertItem = AlertContext.savedSuccess
    }

    // MARK: Form Validation
    var isValidForm: Bool {

        guard !user.firstName.isEmpty,
              !user.lastName.isEmpty,
              !user.email.isEmpty else {

            alertItem = AlertContext.invalidForm
            return false
        }

        guard user.email.isValid else {

            alertItem = AlertContext.invalidemailId
            return false
        }

        return true
    }
}
