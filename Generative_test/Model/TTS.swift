//
//  TTS.swift
//  Generative_test
//
//  Created by apple on 2023/08/31.
//

import Foundation
import AVFoundation

class SpeechModel {
    let synthesizer = AVSpeechSynthesizer()
    
    func speechText(to sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
//        utterance.voice = AVSpeechSynthesisVoice(language: "kr-KO")
        utterance.voice = AVSpeechSynthesisVoice(language: Locale.preferredLanguages.first)
        utterance.rate = 0.5
        
        self.synthesizer.speak(utterance)
    }
    
    func speechStop() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
}


