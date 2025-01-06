//
//  DataController.swift
//  Checkmate
//
//  Created by Tanner George on 10/16/24.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Checkmate")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
}
