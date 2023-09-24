//
//  OpenAIService.swift
//  Generative_test
//
//  Created by apple on 2023/08/28.
//

import Foundation
import Alamofire

class OpenAIService {
    private let baseUrl = ""
    
    func sendMessage(message: [Message]) async -> OpenAIChatResponse? {
        let openAIMessage = message.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-4", messages: openAIMessage)
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(Contants.OpenAIAPIKey)"
        ]
        
        return try? await AF.request(baseUrl, method: .post, parameters: body, encoder: .json, headers: header).serializingDecodable(OpenAIChatResponse.self).value
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
