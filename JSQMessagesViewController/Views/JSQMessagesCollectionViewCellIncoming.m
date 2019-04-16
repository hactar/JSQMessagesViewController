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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Weitere Optionen" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Antwort mit anderen teilen" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actuallyShare:sender];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Feedback geben" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Open Feedback interface...");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Abbrechen" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // do nothing
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
    
    @end
