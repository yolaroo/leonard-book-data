//
//  BookViewController.h
//  Leonard's Pond Storybook
//
//  Created by MGM on 9/25/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

#import "ECSlidingViewController.h"
#import "MenuViewController.h"

#import "BookLoad.h"
#import "BookData.h"
#import "BookView.h"

@class BookLoad;

@interface BookViewController : UIViewController
{
    BookLoad *BookLoad;
}

@property (nonatomic, retain) BookLoad*BookLoad;
@property (nonatomic) int theCurrentCount;
@property SystemSoundID mySentenceAudio;


- (IBAction)revealMenu:(id)sender;


@end
