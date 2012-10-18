//
//  TimelineCell.m
//  TwitterFeed
//
//  Created by Cornelius Coachman on 10/18/12.
//
//

#import "TimelineCell.h"

@implementation TimelineCell

@synthesize imageView;
@synthesize tweetLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
