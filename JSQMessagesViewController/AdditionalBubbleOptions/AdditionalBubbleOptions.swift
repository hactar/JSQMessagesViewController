//
//  AdditionalBubbleOptions.swift
//  Wave
//
//  Created by patrick on 09.05.19.
//  Copyright © 2019 patrick. All rights reserved.
//

import Foundation

@objc public class AdditionalBubbleOptions: NSObject, Codable {
    @objc public let shareURL: URL?
    @objc public let feedback: Feedback?
    @objc public let feedbackEndpoint: URL?
    
    @objc public init(shareURL: URL?, feedback: Feedback?, feedbackEndpoint: URL?) {
        self.shareURL = shareURL
        self.feedback = feedback
        self.feedbackEndpoint = feedbackEndpoint
    }
}
