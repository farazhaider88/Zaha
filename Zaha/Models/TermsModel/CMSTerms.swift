//
//	CMSTerms.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CMSTerms : Codable {

	let code : String?
	let message : String?
	let result : CMSResult?
	let userBlocked : Int?
	let pages : Int?


	enum CodingKeys: String, CodingKey {
		case code = "Code"
		case message = "Message"
		case result = "Result"
		case userBlocked = "UserBlocked"
		case pages = "pages"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code) ?? String()
		message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
		result = try values.decodeIfPresent(CMSResult.self, forKey: .result)  //?? CMSResult()
		userBlocked = try values.decodeIfPresent(Int.self, forKey: .userBlocked) ?? Int()
		pages = try values.decodeIfPresent(Int.self, forKey: .pages) ?? Int()
	}


}
