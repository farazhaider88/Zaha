//
//	CMSCrm.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CMSCrm : Codable {

	let body : String?
	let createdAt : String?
	let id : Int?
	let status : String?
	let type : String?


	enum CodingKeys: String, CodingKey {
		case body = "body"
		case createdAt = "created_at"
		case id = "id"
		case status = "status"
		case type = "type"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		body = try values.decodeIfPresent(String.self, forKey: .body) ?? String()
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		status = try values.decodeIfPresent(String.self, forKey: .status) ?? String()
		type = try values.decodeIfPresent(String.self, forKey: .type) ?? String()
	}


}
