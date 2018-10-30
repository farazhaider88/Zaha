//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import Realm
import RealmSwift

class User :  Object , Codable {

	@objc dynamic var address : String?
	@objc dynamic var createdAt : String?
	@objc dynamic var deletedAt : String?
	@objc dynamic var email : String?
	@objc dynamic var id : Int = 0
	@objc dynamic var image : String?
	@objc dynamic var isVerified : String?
	@objc dynamic var name : String?
	@objc dynamic var notificationStatus : String?

	@objc dynamic var phone : String?
	@objc dynamic var roleId : String?
	@objc dynamic var status : String?
	@objc dynamic var token : String?
	@objc dynamic var updatedAt : String?
    @objc dynamic var verificationCode : Int = 0


	enum CodingKeys: String, CodingKey {
		case address = "address"
		case createdAt = "created_at"
		case deletedAt = "deleted_at"
		case email = "email"
		case id = "id"
		case image = "image"
		case isVerified = "is_verified"
		case name = "name"
		case notificationStatus = "notification_status"
	
		case phone = "phone"
		case roleId = "role_id"
		case status = "status"
		case token = "token"
		case updatedAt = "updated_at"
        case verificationCode = "verification_code"
	}
    
    
    /**
     Override Object.primaryKey() to set the model’s primary key. Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value.
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
	convenience required init(from decoder: Decoder) throws {
          self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address) ?? String()
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt) ?? String()
		email = try values.decodeIfPresent(String.self, forKey: .email) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		image = try values.decodeIfPresent(String.self, forKey: .image) ?? String()
		isVerified = try values.decodeIfPresent(String.self, forKey: .isVerified) ?? String()
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? String()
		notificationStatus = try values.decodeIfPresent(String.self, forKey: .notificationStatus) ?? String()
	
		phone = try values.decodeIfPresent(String.self, forKey: .phone) ?? String()
		roleId = try values.decodeIfPresent(String.self, forKey: .roleId) ?? String()
		status = try values.decodeIfPresent(String.self, forKey: .status) ?? String()
		token = try values.decodeIfPresent(String.self, forKey: .token) ?? String()
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? String()
        verificationCode = try values.decodeIfPresent(Int.self, forKey: .verificationCode) ?? Int()
	}

    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

}
