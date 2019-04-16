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
    
- (IBAction)shareButtonTapped:(UIButton *)sender {
    NSLog(@"Going to share %@", self.shareURL);
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.shareURL] applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = sender;
    activityViewController.popoverPresentationController.sourceRect = sender.bounds;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityViewController animated:YES completion:nil];
}
    
    @end
