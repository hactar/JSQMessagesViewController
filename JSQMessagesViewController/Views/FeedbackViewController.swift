//
//  FeedbackViewController.swift
//  JSQMessages
//
//  Created by patrick on 16.04.19.
//  Copyright © 2019 Hexed Bits. All rights reserved.
//

import UIKit

class Feedback: Codable {
    let language: String
    let question: String
    let answer: String
    var userText: String?
}

@objc class FeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeButtonHit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackButtonHit(_ sender: Any) {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
}
