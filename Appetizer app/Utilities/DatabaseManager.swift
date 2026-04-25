import Foundation
import SQLite3

extension Notification.Name {
    static let ordersUpdated = Notification.Name("ordersUpdated")
}

final class DatabaseManager {

    static let shared = DatabaseManager()
    private var db: OpaquePointer?

    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    private init() {
        openDatabase()
        createTables()
    }

    // MARK: OPEN DATABASE

    private func openDatabase() {

        let fileURL = try! FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("FoodOrdering.sqlite")

        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {

            sqlite3_exec(db, "PRAGMA foreign_keys = ON;", nil, nil, nil)

            print("✅ SQLite opened at:")
            print(fileURL.path)

        } else {
            print("❌ Failed to open database")
        }
    }

    // MARK: CREATE TABLES

    private func createTables() {

        let createUserTable = """
        CREATE TABLE IF NOT EXISTS User(
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT,
        last_name TEXT,
        email TEXT UNIQUE,
        birthdate TEXT,
        extra_napkins INTEGER,
        frequent_refills INTEGER
        );
        """

        execute(query: createUserTable)

        let createOrdersTable = """
        CREATE TABLE IF NOT EXISTS Orders(
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        order_date TEXT,
        total_amount REAL,
        item_count INTEGER,
        FOREIGN KEY(user_id) REFERENCES User(user_id)
        );
        """

        execute(query: createOrdersTable)
        
        let createOrderItemsTable = """
        CREATE TABLE IF NOT EXISTS OrderItems(
        item_id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        appetizer_name TEXT,
        quantity INTEGER,
        price REAL,
        FOREIGN KEY(order_id) REFERENCES Orders(order_id)
        );
        """

        execute(query: createOrderItemsTable)

    }

    private func execute(query: String) {

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Query executed")
            }

        } else {
            print("❌ Query failed")
        }

        sqlite3_finalize(statement)
    }

    // MARK: USER FUNCTIONS

    func userExists() -> Bool {

        let query = "SELECT COUNT(*) FROM User"

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            if sqlite3_step(statement) == SQLITE_ROW {

                let count = sqlite3_column_int(statement, 0)
                sqlite3_finalize(statement)
                return count > 0
            }
        }

        sqlite3_finalize(statement)
        return false
    }

    func getUserId() -> Int? {

        let query = "SELECT user_id FROM User LIMIT 1"

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            if sqlite3_step(statement) == SQLITE_ROW {

                let id = sqlite3_column_int(statement, 0)
                sqlite3_finalize(statement)
                return Int(id)
            }
        }

        sqlite3_finalize(statement)
        return nil
    }

    func insertUser(user: User) {

        if userExists() {
            updateUser(user: user)
            return
        }

        let query = """
        INSERT INTO User
        (first_name,last_name,email,birthdate,extra_napkins,frequent_refills)
        VALUES(?,?,?,?,?,?)
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            sqlite3_bind_text(statement, 1, (user.firstName as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 2, (user.lastName as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 3, (user.email as NSString).utf8String, -1, SQLITE_TRANSIENT)

            let birth = ISO8601DateFormatter().string(from: user.birthdate)
            sqlite3_bind_text(statement, 4, (birth as NSString).utf8String, -1, SQLITE_TRANSIENT)

            sqlite3_bind_int(statement, 5, user.extraNapkin ? 1 : 0)
            sqlite3_bind_int(statement, 6, user.frequentRefills ? 1 : 0)

            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ User saved successfully")
            }
        }

        sqlite3_finalize(statement)
    }

    func updateUser(user: User) {

        guard let userId = getUserId() else { return }

        let query = """
        UPDATE User
        SET first_name=?,last_name=?,email=?,birthdate=?,extra_napkins=?,frequent_refills=?
        WHERE user_id=?
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            sqlite3_bind_text(statement, 1, (user.firstName as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 2, (user.lastName as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 3, (user.email as NSString).utf8String, -1, SQLITE_TRANSIENT)

            let birth = ISO8601DateFormatter().string(from: user.birthdate)
            sqlite3_bind_text(statement, 4, (birth as NSString).utf8String, -1, SQLITE_TRANSIENT)

            sqlite3_bind_int(statement, 5, user.extraNapkin ? 1 : 0)
            sqlite3_bind_int(statement, 6, user.frequentRefills ? 1 : 0)
            sqlite3_bind_int(statement, 7, Int32(userId))

            sqlite3_step(statement)
        }

        sqlite3_finalize(statement)
    }

    // MARK: INSERT ORDER

    func insertOrder(items:[OrderItem], totalAmount:Double, itemCount:Int) {

        guard let userId = getUserId() else {
            print("❌ No user found")
            return
        }

        let query = """
        INSERT INTO Orders(user_id,order_date,total_amount,item_count)
        VALUES(?,?,?,?)
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            let date = ISO8601DateFormatter().string(from: Date())

            sqlite3_bind_int(statement, 1, Int32(userId))
            sqlite3_bind_text(statement, 2, (date as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_double(statement, 3, totalAmount)
            sqlite3_bind_int(statement, 4, Int32(itemCount))

            if sqlite3_step(statement) == SQLITE_DONE {

                let orderId = sqlite3_last_insert_rowid(db)

                print("✅ Order inserted id:", orderId)

                insertOrderItems(orderId: Int(orderId), items: items)

                NotificationCenter.default.post(name: .ordersUpdated, object: nil)
            }
        }

        sqlite3_finalize(statement)
    }

    // MARK: INSERT ORDER ITEMS

    func insertOrderItems(orderId:Int, items:[OrderItem]) {

        let query = """
        INSERT INTO OrderItems(order_id,appetizer_name,quantity,price)
        VALUES(?,?,?,?)
        """

        for item in items {

            var statement: OpaquePointer?

            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

                sqlite3_bind_int(statement, 1, Int32(orderId))
                sqlite3_bind_text(statement, 2, (item.appetizer.name as NSString).utf8String, -1, SQLITE_TRANSIENT)
                sqlite3_bind_int(statement, 3, Int32(item.quantity))
                sqlite3_bind_double(statement, 4, item.appetizer.price)

                sqlite3_step(statement)
            }

            sqlite3_finalize(statement)
        }
    }

    // MARK: FETCH ORDERS

    func fetchOrders() -> [(Int,String,Double,Int)] {

        let query = """
        SELECT order_id,order_date,total_amount,item_count
        FROM Orders
        ORDER BY order_id DESC
        """

        var statement: OpaquePointer?
        var results:[(Int,String,Double,Int)] = []

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            while sqlite3_step(statement) == SQLITE_ROW {

                let id = sqlite3_column_int(statement, 0)
                let date = String(cString: sqlite3_column_text(statement, 1))
                let amount = sqlite3_column_double(statement, 2)
                let count = sqlite3_column_int(statement, 3)

                results.append((Int(id),date,amount,Int(count)))
            }
        }

        sqlite3_finalize(statement)
        return results
    }
    
    // MARK: FETCH USER

    func fetchUser() -> User? {

        let query = """
        SELECT first_name,last_name,email,birthdate,extra_napkins,frequent_refills
        FROM User
        LIMIT 1
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

            if sqlite3_step(statement) == SQLITE_ROW {

                let firstName = String(cString: sqlite3_column_text(statement, 0))
                let lastName = String(cString: sqlite3_column_text(statement, 1))
                let email = String(cString: sqlite3_column_text(statement, 2))
                let birthString = String(cString: sqlite3_column_text(statement, 3))

                let extraNapkins = sqlite3_column_int(statement, 4) == 1
                let frequentRefills = sqlite3_column_int(statement, 5) == 1

                let formatter = ISO8601DateFormatter()
                let birthdate = formatter.date(from: birthString) ?? Date()

                sqlite3_finalize(statement)

                return User(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    birthdate: birthdate,
                    extraNapkin: extraNapkins,
                    frequentRefills: frequentRefills
                )
            }
        }

        sqlite3_finalize(statement)

        return nil
    }
    
}
