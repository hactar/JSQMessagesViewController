//
//  FeedbackViewController.swift
//  JSQMessages
//
//  Created by patrick on 16.04.19.
//  Copyright © 2019 Hexed Bits. All rights reserved.
//

import UIKit

// To parse the JSON, add this file to your project and do:
//
//   let deeplResponse = try? newJSONDecoder().decode(DeeplResponse.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.deeplResponseTask(with: url) { deeplResponse, response, error in
//     if let deeplResponse = deeplResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation



// MARK: - URLSession response handlers



@objc class FeedbackViewController: UIViewController {
    @objc var additionalBubbleOptions: AdditionalBubbleOptions?

    @IBOutlet weak var sendFeedbackButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.popupView.layer.cornerRadius = 5.0
        self.popupView.layer.masksToBounds = true
        
        self.textView.layer.cornerRadius = 5.0
        self.textView.layer.masksToBounds = true
        
        self.sendFeedbackButton.layer.cornerRadius = 5.0
        self.sendFeedbackButton.layer.masksToBounds = true
        
    }
    
    func cancelFeedback() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func backgroundHit(_ sender: Any) {
        cancelFeedback()
    }
    override func viewWillAppear(_ animated: Bool) {
        let finalColor = view.backgroundColor
        view.backgroundColor = .clear
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor = finalColor
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        self.view.backgroundColor = .clear
        
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
        cancelFeedback()

    }
    
    @IBAction func sendFeedbackButtonHit(_ sender: Any) {
        
        guard self.textView.text.count > 0 else {
            return
        }
        do {
            additionalBubbleOptions?.feedback?.feedbackMessage = self.textView.text
            guard let feedback = additionalBubbleOptions?.feedback else {
                print("No feedback set...")
                return
            }
            let data = try JSONEncoder().encode(feedback)
            
            guard let url = additionalBubbleOptions?.feedbackEndpoint else {
                print("No feedback endpoint set...")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("Posted Feedback... error was \(String(describing: error))")
            }
            task.resume()
        } catch {
            print("Could not post Feedback: \(error)")
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
