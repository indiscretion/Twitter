//
//  MainViewController.m
//  TwitterFeed
//
//  Created by Cornelius Coachman on 10/18/12.
//
//

#import "MainViewController.h"
#import "TimelineCell.h"
#import "DetailViewController.h"

@interface MainViewController (Private)

- (void)customizeAppearance;
- (void)getTweets;

@end

@implementation MainViewController

@synthesize headerSearchBar;
@synthesize dataArray;
@synthesize actView;
@synthesize overlayView;
@synthesize tempImageData;
@synthesize tempStr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeAppearance];

    [self.overlayView setHidden:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)customizeAppearance
{
    // Overlay View
    self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.overlayView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.overlayView];
    
    // Activity Indicator View
    self.actView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110, 150, 100, 100)];
    [self.actView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.overlayView addSubview:self.actView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Search Bar
    self.headerSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    
    self.headerSearchBar.barStyle = UIBarStyleDefault;
    self.headerSearchBar.showsCancelButton = NO;
    self.headerSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.headerSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.headerSearchBar.delegate = self;
    self.headerSearchBar.placeholder = @"Enter Twitter Handle";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    
    [view addSubview:self.headerSearchBar];
    
    return view;
}

#pragma mark - SearchBar Delegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [searchBar resignFirstResponder];
        [self getTweets];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [self getTweets];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.dataArray count] != 0)
    {
        return [self.dataArray count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.scrollEnabled = YES;

    static NSString *CellIdentifier = @"Cell";
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...

    if (self.dataArray != nil) {
        NSDictionary *tweetInfo = [self.dataArray objectAtIndex:indexPath.row];
        NSLog(@"tweetInfo %@", tweetInfo);
        
        cell.tweetLabel.text = [tweetInfo objectForKey:@"text"];
        
        dispatch_queue_t queue = dispatch_queue_create("com.twitter.search", NULL);
        dispatch_queue_t main = dispatch_get_main_queue();
        
        dispatch_async(queue, ^{
            NSURL *imageURL = [NSURL URLWithString:[[tweetInfo objectForKey:@"user"] objectForKey:@"profile_image_url"]];
            self.tempImageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(main, ^{
                cell.imageView.image = [UIImage imageWithData:self.tempImageData];
            });
        });
        
        dispatch_release(queue);
        
        return cell;
    }else{
        return cell;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tweetInfo = [self.dataArray objectAtIndex:indexPath.row];
    
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        
    NSURL *imageURL = [NSURL URLWithString:[[tweetInfo objectForKey:@"user"] objectForKey:@"profile_image_url"]];
    
    self.tempImageData = [NSData dataWithContentsOfURL:imageURL];
    
    controller.tempStr = [tweetInfo objectForKey:@"text"];
    controller.tempImageData = self.tempImageData;
    
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)getTweets
{
    self.tableView.scrollEnabled = NO;
    [self.overlayView setHidden:NO];
    [self.actView startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:self.headerSearchBar.text forKey:@"screen_name"];
    [parameters setObject:@"50" forKey:@"count"];
    [parameters setObject:@"1" forKey:@"include_entities"];
        
    TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (responseData != nil) {
            NSError *error = nil;
            self.dataArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];

            if (self.dataArray != nil)
            {
                NSLog(@"%@", self.dataArray);
                
                [self.tableView reloadData];
                [self.overlayView setHidden:YES];
                [self.actView stopAnimating];
                
            } else {
                NSLog(@"Error serializing response data %@ with user info %@.", error, error.userInfo);
            }
        } else {
            NSLog(@"Error requesting timeline %@ with user info %@.", error, error.userInfo);
        }
    }];
}

@end
