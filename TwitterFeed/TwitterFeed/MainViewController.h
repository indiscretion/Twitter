//
//  MainViewController.h
//  TwitterFeed
//
//  Created by Cornelius Coachman on 10/18/12.
//
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface MainViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *headerSearchBar;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIActivityIndicatorView *actView;
@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) NSData *tempImageData;
@property (strong, nonatomic) NSString *tempStr;
@end
