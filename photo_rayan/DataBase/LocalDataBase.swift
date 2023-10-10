//
//  LocalDataBase.swift
//  photo_rayan
//
//  Created by Amir on 10/9/23.
//

import Foundation
import RealmSwift

public class RealmManager {
    private let database: Realm
    
    /// The shared instance of the realm manager.
    static let sharedInstance = RealmManager()
    
    /// Private initializer for the realm manager. Crashes if it cannot open the database.
    private init() {
        
        do {
            database = try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
   
    /// Retrieves the given object type from the database.
    ///
    /// - Parameter object: The type of object to retrieve.
    /// - Returns: The results in the database for the given object type.
     func fetch<T: Object>(object: T) -> Results<T> {
        return database.objects(T.self)
    }
    
    /// Writes the given object and array to the database.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
     func saveArray<T: Object>(object: [T], _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.add(object)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    func saveObject<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
       do {
           try database.write {
               database.add(object)
           }
       }
       catch {
           errorHandler(error)
       }
   }
}
