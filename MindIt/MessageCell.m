//
//  DealCell.m
//  iPet
//
//  Created by rajender on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageCell.h"


@interface MessageCell()
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end
 
@implementation MessageCell

@synthesize objMessages, lblCategory, lblMessage, lblDateTime, imgBG;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		UIImageView *img = [[UIImageView alloc]init];
		self.imgBG = img;
		[self.contentView addSubview:self.imgBG];
		[imgBG release];
		
        
		self.lblCategory = [self newLabelWithPrimaryColor:[UIColor purpleColor] selectedColor:[UIColor clearColor] fontSize:16.0 bold:YES];
		[self.contentView addSubview:self.lblCategory];
		[self.lblCategory release];
		
		self.lblMessage = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor clearColor] fontSize:12.0 bold:NO];
		[self.contentView addSubview:self.lblMessage];
		[self.lblMessage release];
		
		self.lblDateTime = [self newLabelWithPrimaryColor:[UIColor grayColor] selectedColor:[UIColor clearColor] fontSize:16.0 bold:NO];
		[self.contentView addSubview:self.lblDateTime];
		[self.lblDateTime release];
		
    }
    return self;
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	
    UIFont *font;
	
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = selectedColor;
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = primaryColor ;
	newLabel.font = font;
	return newLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

-(void)setMessage:(MessageObj *)message
{
	[message retain];
	[objMessages release];
	objMessages = message;
    imgBG.frame=CGRectMake(0,0,320,100);
	UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"messageBG"] ofType:@"png"]];
	[imgBG setImage:tempImage];
	[tempImage release];

	self.lblCategory.frame = CGRectMake(20, 75, 40, 20);
	self.lblCategory.text = @"Keys";
	self.lblMessage.frame = CGRectMake(20, 10, 300, 60);
	self.lblMessage.numberOfLines = 4;
	self.lblMessage.text = objMessages.text;
    self.lblDateTime.frame = CGRectMake(100, 75, 200, 20);
    [self.lblDateTime setTextAlignment:UITextAlignmentRight];
    self.lblDateTime.text = @"July 17th, 2011";
}

- (void)dealloc {
    [super dealloc];
}


@end
