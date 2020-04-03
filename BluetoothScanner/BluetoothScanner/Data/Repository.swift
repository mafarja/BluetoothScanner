//
//  Repository.swift
//  FamHub
//
//  Created by Marcelo Farjalla on 11/25/19.
//  Copyright © 2019 StackRank, LLC. All rights reserved.
//

import Foundation

protocol Repository {
  
  associatedtype T
  
  func getAll() -> [T]
  func get( identifier:Int ) -> T?
  func create( a:T ) -> Bool
  func update( a:T ) -> Bool
  func delete( a:T ) -> Bool
}
