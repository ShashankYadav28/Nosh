//
//  DatabaseManager.swift
//  Appetizer app
//
//  Created by Shashank Yadav on 05/02/26.
//

import Foundation
import SQLite3

final class DatabaseManager {
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTables()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("FoodOrdering.sqlite")
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("✅ SQLite database opened at:")
            print(fileURL.path)
        } else {
            print("❌ Failed to open SQLite database")
        }
    }
    
    private func createTables() {
        
        let createUserTable = """
        CREATE TABLE IF NOT EXISTS User (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT,
            last_name TEXT,
            email TEXT,
            birthdate TEXT,
            extra_napkins INTEGER,
            frequent_refills INTEGER
        );
        """
        
        execute(query: createUserTable)
        
        let createOrderTable = """
        CREATE TABLE IF NOT EXISTS Orders (
            order_id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_date TEXT,
            total_amount REAL,
            item_count INTEGER
        );
        """
        execute(query: createOrderTable)
    }
        
    private func execute(query: String) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Table created successfully")
            }
        } else {
            print("❌ Failed to create table")
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertOrder(totalAmount: Double, itemCount: Int) {
        let query = """
        INSERT INTO Orders (order_date, total_amount, item_count)
        VALUES (?, ?, ?);
        """
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            let date = ISO8601DateFormatter().string(from: Date())
            
            sqlite3_bind_text(statement, 1, date, -1, SQLITE_TRANSIENT)
            sqlite3_bind_double(statement, 2, totalAmount)
            sqlite3_bind_int(statement, 3, Int32(itemCount))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ Order inserted")
            }
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertUser(user: User) {
        
        let insertQuery = """
        INSERT INTO User (
            first_name,
            last_name,
            email,
            birthdate,
            extra_napkins,
            frequent_refills
        )
        VALUES (?, ?, ?, ?, ?, ?);
        """
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(statement, 1, (user.firstName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (user.lastName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (user.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (user.birthdate.description as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 5, user.extraNapkin ? 1 : 0)
            sqlite3_bind_int(statement, 6, user.frequentRefills ? 1 : 0)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("✅ User inserted into SQLite table")
            } else {
                print("❌ Failed to insert user")
            }
            
        } else {
            print("❌ Insert query preparation failed")
        }
        
        sqlite3_finalize(statement)
    }
}

