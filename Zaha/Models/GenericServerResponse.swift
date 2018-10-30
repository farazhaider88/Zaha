//
//  GenericServerResponse.swift
//  Ezhalbatek-Technician
//
//  Created by Waqas Ali on 8/13/18.
//  Copyright © 2018 HassanKhan. All rights reserved.
//

import Foundation

class GenericServerResponse <T> : Codable where T: Encodable, T: Decodable {
    
    let message : String?
    let response : String?
    let result : T?
    
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case response = "Response"
        case result = "Result"
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? String()
        result = try values.decodeIfPresent(T.self, forKey: .result)  //?? Result()
        
    }
}




class BaseResponse  : Codable  {
    
    let message : String?
    let response : String?
   
    
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case response = "Response"
      
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        response = try values.decodeIfPresent(String.self, forKey: .response) ?? String()
        
        
    }
}
