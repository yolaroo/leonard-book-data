//
//  BookViewController.m
//  Leonard's Pond Storybook
//
//  Created by MGM on 9/25/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()
{
    bool soundCheck;
}
@property (weak, nonatomic) IBOutlet BookView *myBookView;

@end

@implementation BookViewController

@synthesize BookLoad=_BookLoad,theCurrentCount=_theCurrentCount,mySentenceAudio;


#define DELAY 0.3

#pragma mark - Touch Action

- (IBAction)goNextSwipe:(UISwipeGestureRecognizer *)sender {
    self.theCurrentCount++;
    [self thePageLoad];
}

- (IBAction)goBackSwipe:(UISwipeGestureRecognizer *)sender {
    self.theCurrentCount--;
    [self thePageLoad];
}

#pragma mark - Book Setter

- (void) setMyBookView:(BookView *)myBookView {
    _myBookView=myBookView;
}

-(void) thePageLoad {
    [self loadDefaults];

    NSArray*myArray = [self.BookLoad loadBookData];
    BookData*myBookData = [[BookData alloc] init];
    
    [self pageCheck:(int)[myArray count]];
    
    myBookData = [myArray objectAtIndex:self.theCurrentCount];
    
    self.myBookView.theSentence=myBookData.theSentence;
    self.myBookView.thePageNumber=myBookData.thePageNumber;
    
    if (!soundCheck) {
        [self performSelector:@selector(soundAction:) withObject:[NSString stringWithFormat:@"%d",self.theCurrentCount] afterDelay:DELAY];
    }
}

- (void) pageCheck: (int) myArrayCountLimit {
    if (self.theCurrentCount < 0) {
        self.theCurrentCount = 0;
    }
    else if (self.theCurrentCount >= myArrayCountLimit-1) {
        self.theCurrentCount = myArrayCountLimit-1;
    }
}

#pragma mark - Menu Load

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Load Menu Defaults


- (void) loadDefaults {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults boolForKey:@"sound"] == TRUE) {
        soundCheck = false;
    }
    else {
        soundCheck = true;
    }
}

#pragma mark - Audio

void myAddedFinalAudioServicesSystemSoundCompletionProc (SystemSoundID mySentenceAudio,void* clientData){
    AudioServicesDisposeSystemSoundID(mySentenceAudio);
}

- (void) soundAction: (NSString*)soundtitle{
    
    NSString* SOUNDPATH = [[NSBundle mainBundle]
                           pathForResource:soundtitle
                           ofType:@"m4a"
                           inDirectory:@""];
    if (SOUNDPATH != nil) {

        CFURLRef baseURL = (__bridge_retained CFURLRef)  [[NSURL alloc] initFileURLWithPath:SOUNDPATH];
        AudioServicesCreateSystemSoundID (baseURL, &mySentenceAudio);
        
        AudioServicesPlaySystemSound(mySentenceAudio);
        CFRelease(baseURL);
        
        AudioServicesAddSystemSoundCompletion (mySentenceAudio,NULL,NULL,myAddedFinalAudioServicesSystemSoundCompletionProc,(__bridge void*)self);
    }
    else {
    }
}


#pragma mark - Life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self menuLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.BookLoad=[[BookLoad alloc]init];
    
    self.theCurrentCount = 0;

    [self thePageLoad];
    
}

- (void) menuLoad {
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
