//
//  ChatViewModel.swift
//  Generative_test
//
//  Created by apple on 2023/08/29.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    @Published var currentInput: String = ""
    @Published var isLoding: Bool = false
    
    private let openAIService = OpenAIService()
    
    func systemSettingMessage(systemMessage: String) {
        self.isLoding = true
        messages.append(Message(id: UUID(), role: .assistant, content: "너는 이제 동화작가야. 6세 아이와 같이 동화를 만들거야. 주제는 이거(\(systemMessage)야, 너랑 한문장씩 번갈아 가며 동화를 쓸거야. 5개의 문장으로 동화는 끝이 나야해. 쌍따옴표 안에 한문장만 말해줘", createAt: Date()))
        
        Task {
            let response = await openAIService.sendMessage(message: messages)
            guard let receivedOpenAIMessage = response?.choices.first?.message else { return }
            let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
            await MainActor.run {
                messages.append(receivedMessage)
                self.isLoding = false
            }
        }
    }
    
    func sendMessage() {
        self.isLoding = true
        let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
        messages.append(newMessage)
        currentInput = ""
        
        Task {
            let response = await openAIService.sendMessage(message: messages)
            guard let receivedOpenAIMessage = response?.choices.first?.message else { return }
            let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
            await MainActor.run {
                messages.append(receivedMessage)
                self.isLoding = false
            }
        }
    }
}


struct Message: Decodable, Hashable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
