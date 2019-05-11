//
//  Feedback.swift
//  Wave
//
//  Created by patrick on 09.05.19.
//  Copyright © 2019 patrick. All rights reserved.
//

import Foundation

@objc public class Feedback: NSObject, Codable {
    /// Query sent to server
    public let query: String
    
    /// Answer sent back by server
    public let answer: String
    
    
    /// The message from user
    public var feedbackMessage: String?
    
    /// User's locale
    public let locale: String?
    
    /// android, ios, web
    public let clientType: String
    
    /// version number
    public let versionNumber: String
    
    // additional tag to simplify scanning log file
    public let feedback = true
    
    @objc public init(query: String, answer: String, feedbackMessage: String, locale: String, clientType: String, versionNumber: String) {
        self.query = query
        self.answer = answer
        self.feedbackMessage = feedbackMessage
        self.locale = locale
        self.clientType = clientType
        self.versionNumber = versionNumber
    }
    
}
