//
//  DetailViewController.h
//  TwitterFeed
//
//  Created by Cornelius Coachman on 10/18/12.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) NSString *tempStr;
@property (strong, nonatomic) NSData *tempImageData;

@end
