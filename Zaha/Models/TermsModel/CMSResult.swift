//
//	CMSResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CMSResult : Codable {

	let crm : CMSCrm?


	enum CodingKeys: String, CodingKey {
		case crm
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		crm = try values.decodeIfPresent(CMSCrm.self, forKey: .crm)  //?? CMSCrm()
	}


}