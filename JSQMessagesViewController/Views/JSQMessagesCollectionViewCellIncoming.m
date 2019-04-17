//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesCollectionViewCellIncoming.h"

@implementation JSQMessagesCollectionViewCellIncoming
    
#pragma mark - Overrides
    
- (void)awakeFromNib
    {
        [super awakeFromNib];
        self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
        self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
        self.shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
- (void)actuallyShare:(UIButton *)sender {
    NSLog(@"Going to share %@", self.shareURL);
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.shareURL] applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = sender;
    activityViewController.popoverPresentationController.sourceRect = sender.bounds;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)shareButtonTapped:(UIButton *)sender {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Further options" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    alertController.popoverPresentationController.sourceView = sender;
//    alertController.popoverPresentationController.sourceRect = sender.bounds;
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Share answer with others" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self actuallyShare:sender];
//    }];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Send feedback" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"Open Feedback interface...");
//
//
//        FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:[NSBundle bundleForClass:[FeedbackViewController class]] ];
//        feedbackViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:feedbackViewController animated:YES completion:nil];
//    }];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        // do nothing
//    }];
//    [alertController addAction:action1];
//    [alertController addAction:action2];
//    [alertController addAction:cancelAction];
//
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    [self actuallyShare:sender];
}
    
    @end
