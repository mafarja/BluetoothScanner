//
//  User.swift
//  FamHub
//
//  Created by Marcelo Farjalla on 11/6/19.
//  Copyright © 2019 StackRank, LLC. All rights reserved.
//

import Foundation
import CloudKit

class User {
  
  private var id: String?
   
  init() {
    
  }
  
  public func getUserId(_ completion: @escaping (String?, Error?) -> Void) {
    
    if let userId = self.id {
      completion(userId, nil)
      return
    }
    
    let container = CKContainer.default()
    container.fetchUserRecordID { (recordId, error) in
      guard let recordId = recordId else {
        print(error)
        completion(nil, error)
        return
      }
      completion(recordId.recordName, nil)
    }
  }
}
