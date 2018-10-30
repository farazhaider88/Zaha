//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ResultSignup : Codable {

	let user : User?


	enum CodingKeys: String, CodingKey {
		case user
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user = try values.decodeIfPresent(User.self, forKey: .user)  //?? User()
	}


}
