//
//  ProfileResponse.swift
//  AESApp
//
//  Created by Alex on 7/6/20.
//  Copyright © 2020 AES. All rights reserved.
//   let profileResponse = try? newJSONDecoder().decode(ProfileResponse.self, from: jsonData)

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let data: [ProfileResponseData]
    let message, status: String
}

// MARK: - Datum
struct ProfileResponseData: Codable {
    let birthday, createdAt, email, firebaseUUID: String?
    let id: Int
    let lang, lastNames, lastSeen, names: String?
    let phoneNumber, picURL, provider, pushTok: String?
    let statusPhoneNumber: Bool

    enum CodingKeys: String, CodingKey {
        case birthday
        case createdAt = "created_at"
        case email
        case firebaseUUID = "firebase_uuid"
        case id, lang
        case lastNames = "last_names"
        case lastSeen = "last_seen"
        case names
        case phoneNumber = "phone_number"
        case picURL = "pic_url"
        case provider
        case pushTok = "push_tok"
        case statusPhoneNumber = "status_phone_number"
    }
}
