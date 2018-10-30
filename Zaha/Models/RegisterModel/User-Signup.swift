//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class UserSignup : Codable {
    
    
 
	let address : String?
	let createdAt : String?
	let deletedAt : String?
	let email : String?
	let id : Int?
	let image : String?
	let isVerified : String?
	let name : String?
	let notificationStatus : String?
	let phone : String?
	let roleId : String?
	let status : String?
	let token : String?
	let updatedAt : String?


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
	}
	required init(from decoder: Decoder) throws {
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
	}


}
