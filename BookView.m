//
//  BookView.m
//  worknow
//
//  Created by MGM on 9/24/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import "BookView.h"

@implementation BookView

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad
#define isDeviceIPhone UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

#define LETTER_SHADOW [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.1f]
#define FONT_HELVETICA @"Helvetica-Light"

#define lABEL_BG_COLOR [UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:.5f]
#define lABEL_BG_COLOR_IPAD [UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:.3f]

#define FONT_SIZE 18
#define FONT_SIZE_IPAD 32

#define LABEL_X 0
#define LABEL_Y 0.80
#define NAME_Y 0.01

 - (void)drawRect:(CGRect)rect
 {
     [self cleanTheSubview];
     [self drawImage];
     [self drawImageLabel];     
 }

#pragma mark - Image

- (void) drawImage
{
    NSString *fileName;

    if (isDeviceIPad) {
        fileName= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d book ipad",self.thePageNumber] ofType:@"png"];
    }
    else {
        fileName= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d book",self.thePageNumber] ofType:@"png"];
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:fileName];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = self.bounds;
    imageView.clipsToBounds = true;
    
    [self insertSubview:imageView atIndex:1];
}

#pragma mark - Lower Label

#define HALF_WIDTH_DIFFERENCE 0.02
#define WIDTH 0.96
#define HEIGHT 1.025
#define HEIGHT_IPAD 1.09
#define ORIGIN_HEIGHT_MULT_IPAD 1.075

- (void) drawImageLabel
{
    CGRect textBounds;
    
    if (isDeviceIPad){
        textBounds.origin = CGPointMake(HALF_WIDTH_DIFFERENCE*self.bounds.size.width, self.bounds.size.height*LABEL_Y*ORIGIN_HEIGHT_MULT_IPAD);
        textBounds.size.width =  self.bounds.size.width*WIDTH;
        textBounds.size.height =  self.bounds.size.height*(1-LABEL_Y*HEIGHT_IPAD);
    }
    else {
        textBounds.origin = CGPointMake(HALF_WIDTH_DIFFERENCE*self.bounds.size.width, self.bounds.size.height*LABEL_Y);
        textBounds.size.width =  self.bounds.size.width*WIDTH;
        textBounds.size.height =  self.bounds.size.height*(1-LABEL_Y*HEIGHT);
    }
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:textBounds];
    [myLabel setAttributedText:[self myTextSet:self.theSentence thebounds:textBounds.size.width]];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:myLabel.bounds byRoundingCorners:UIRectCornerAllCorners  cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = myLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    myLabel.layer.mask = maskLayer;
    
    if (isDeviceIPad){
        myLabel.backgroundColor= lABEL_BG_COLOR_IPAD;
    }
    else {
        myLabel.backgroundColor= lABEL_BG_COLOR;
    }
    
    [self insertSubview:myLabel atIndex:2];
}

#pragma mark - String Style

- (NSAttributedString*) myTextSet: (NSString*)myString thebounds: (float)theBounds {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont * labelFont;
    
    if (isDeviceIPad){
        labelFont = [UIFont fontWithName:FONT_HELVETICA size:FONT_SIZE_IPAD];
    }
    else {
        labelFont = [UIFont fontWithName:FONT_HELVETICA size:FONT_SIZE];
    }
    
    UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: LETTER_SHADOW];
    [shadow setShadowOffset:CGSizeMake (1.0, 1.0)];
    [shadow setShadowBlurRadius:1];
    
    NSAttributedString *labelText = [[NSAttributedString alloc] initWithString:
                                     [NSString stringWithFormat:@"%@",myString] attributes:@ {
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                         NSFontAttributeName : labelFont,
                                         NSForegroundColorAttributeName : labelColor,
                                         NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
                                         NSShadowAttributeName : shadow }];
    
    if ([labelText size].width > theBounds) {
        labelFont = [UIFont fontWithName:FONT_HELVETICA size:FONT_SIZE-2];
        labelText = [[NSAttributedString alloc] initWithString:
                                         [NSString stringWithFormat:@"%@",myString] attributes:@ {
                                         NSParagraphStyleAttributeName:paragraphStyle,
                                             NSFontAttributeName : labelFont,
                                             NSForegroundColorAttributeName : labelColor,
                                             NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
                                             NSShadowAttributeName : shadow }];
    }
    return labelText;
}

#pragma mark - Clear

- (void) cleanTheSubview {
    
    for(UIView *subview in [self subviews]) {
        if([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
        else if([subview isKindOfClass:[UILabel class]]) {
            [subview removeFromSuperview];
        }
        else if([subview isKindOfClass:[UIImage class]]) {
            [subview removeFromSuperview];
        }
        else
        {}
    }
}

#pragma mark - Setters

-(void)setTheSentence:(NSString *)theSentence {
    _theSentence = theSentence;
    [self setNeedsDisplay];
}

-(void)setThePageNumber:(int)thePageNumber {
    _thePageNumber = thePageNumber;
    [self setNeedsDisplay];
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

@end


/*
 myLabel.numberOfLines = 1;
 myLabel.minimumScaleFactor = 1;
 myLabel.adjustsFontSizeToFitWidth = YES;
 [myLabel sizeToFit];
*/

