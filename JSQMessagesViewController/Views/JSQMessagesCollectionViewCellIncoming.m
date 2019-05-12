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


// when building this for a pod use angled brackets. when testing locally use quotes.
#import <JSQMessagesViewController/JSQMessagesViewController-swift.h>
//#import "JSQMessagesViewController-swift.h"

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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Further options", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"Share answer with others", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actuallyShare:sender];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"Send feedback", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Open Feedback interface...");
        
        
        FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:[NSBundle bundleForClass:[FeedbackViewController class]] ];
        feedbackViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        feedbackViewController.additionalBubbleOptions = self.additionalBubbleOptions;
        
        [controller presentViewController:feedbackViewController animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // do nothing
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
