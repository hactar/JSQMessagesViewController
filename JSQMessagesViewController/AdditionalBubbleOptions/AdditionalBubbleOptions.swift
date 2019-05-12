//
//  AdditionalBubbleOptions.swift
//  Wave
//
//  Created by patrick on 09.05.19.
//  Copyright © 2019 patrick. All rights reserved.
//

import Foundation

@objc public class AdditionalBubbleOptions: NSObject, Codable {
    @objc public var shareURL: URL? {
        get {
            guard var url = self.baseShareURL, let feedback = feedback else {
                return nil
            }
            //            if let locale = feedback.locale {
            //                url.appendPathComponent(locale)
            //            }
            url.appendPathComponent(feedback.query)
            return url
        }
    }
    @objc public let baseShareURL: URL?
    @objc public let feedback: Feedback?
    @objc public let feedbackEndpoint: URL?
    
    @objc public init(baseShareURL: URL?, feedback: Feedback?, feedbackEndpoint: URL?) {
        self.baseShareURL = baseShareURL
        self.feedback = feedback
        self.feedbackEndpoint = feedbackEndpoint
    }
}
