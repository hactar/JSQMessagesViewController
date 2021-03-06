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
#import "NSBundle+JSQMessages.h"


// when building this for a pod use angled brackets. when testing locally use quotes.

#ifdef COCOAPODS
#import <JSQMessagesViewController/JSQMessagesViewController-Swift.h>
#else
#import "JSQMessagesViewController-Swift.h"
#endif

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end

@implementation UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end

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
    NSLog(@"Going to share %@", self.additionalBubbleOptions.shareURL);
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.additionalBubbleOptions.shareURL] applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = sender;
    activityViewController.popoverPresentationController.sourceRect = sender.bounds;
    
    UIViewController *controller = [self firstAvailableUIViewController];
    
    [controller presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)shareButtonTapped:(UIButton *)sender {
    UIViewController *controller = [self firstAvailableUIViewController];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSBundle jsq_localizedStringForKey:@"Further options"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:[NSBundle jsq_localizedStringForKey:@"Share answer with others"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actuallyShare:sender];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:[NSBundle jsq_localizedStringForKey:@"Send Feedback"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Open Feedback interface...");
        
        
        FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:[NSBundle bundleForClass:[FeedbackViewController class]] ];
        feedbackViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        feedbackViewController.additionalBubbleOptions = self.additionalBubbleOptions;
        
        [controller presentViewController:feedbackViewController animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[NSBundle jsq_localizedStringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // do nothing
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
