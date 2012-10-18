//
//  DetailViewController.m
//  TwitterFeed
//
//  Created by Cornelius Coachman on 10/18/12.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize tempStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.detailLabel.text = self.tempStr;
    self.detailImageView.image =  [UIImage imageWithData:self.tempImageData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDetailImageView:nil];
    [self setDetailLabel:nil];
    [super viewDidUnload];
}
@end
