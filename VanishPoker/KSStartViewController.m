//
//  KSStartViewController.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/17.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSStartViewController.h"
#import "KSMainViewController.h"
#import "KSResultsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KSDiviceHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface KSStartViewController ()

@property (nonatomic, retain) UIView                   *menuView;
@property (nonatomic, retain) KSMenuButton             *StartButton;
@property (nonatomic, retain) KSMenuButton             *ShowResultsButton;
@property (nonatomic, retain) KSMenuAnimationHelper    *animationHelper;
@property (nonatomic, retain) KSMainViewController     *mainViewController;

// opening SE
@property (nonatomic, retain) AVAudioPlayer            *audio;
@property (nonatomic, retain) NSTimer                  *timer_BGM;

@end

@implementation KSStartViewController

#pragma mark -
#pragma mark ---------- life cycle ----------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // start view title and desing!
    [self startViewTitle];
    
    //eyeCatch
    [self addEyeCatchToView];
    
    //game start button
    self.StartButton     = [[KSMenuButton new] startButton];
    self.StartButton.tag = TAG_Start;
    [self.StartButton addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.StartButton];
    
    // show results button
    self.ShowResultsButton     = [[KSMenuButton new] showResultsButton];
    self.ShowResultsButton.tag = TAG_ShowResults;
    [self.ShowResultsButton addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.ShowResultsButton];
    
    //animationHelper
    NSArray    *viewArray = @[self.StartButton, self.ShowResultsButton];
    self.animationHelper          = [[KSMenuAnimationHelper alloc] initWithViewsArray:viewArray];
    self.animationHelper.delegate = self;
    
    // main scene prep
    UIStoryboard    *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainViewController = [storyboard instantiateViewControllerWithIdentifier:MAIN_SCENE];
    
    //game mode 今回は実装しない, normal modeで固定
    NSArray     *modeArray = [NSArray arrayWithObjects:kGAME_MODE_ARRAY];
    self.mainViewController.gameMode = [modeArray objectAtIndex:normalMode];
    
    NSString    *path = [[NSBundle mainBundle]
                         pathForResource:@"ppBGM" ofType:@"caf"];             //bgm1.mp3ってファイルを読み込んでます。
    NSURL       *url = [NSURL fileURLWithPath:path];
    self.audio = [[AVAudioPlayer alloc]
                  initWithContentsOfURL:url error:nil];
    self.audio.volume        = 0.5;
    self.audio.numberOfLoops = -1;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self showMenu];
    [self.audio play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ---------- title design ----------

#define TITLE_SENTENCE_POSI_X 10
#define TITLE_SENTENCE_POSI_Y 40
#define TITLE_SENTENCE_width  300
#define TITLE_SENTENCE_hight  50

- (void)startViewTitle {
    
    UILabel    *titleSentence = ({
        UILabel *sentence = [UILabel new];
        sentence.frame = CGRectMake(TITLE_SENTENCE_POSI_X,
                                    TITLE_SENTENCE_POSI_Y,
                                    TITLE_SENTENCE_width,
                                    TITLE_SENTENCE_hight);
        
        sentence.font  = [UIFont fontWithName:APPLI_FONT size:24];
        sentence.text  = @"VanishPoker";
        sentence;
        
    });
    [self.view addSubview:titleSentence];
    
    // divice
    CGFloat    credit_posi_y = SCREEN_SIZE.height - TITLE_SENTENCE_hight - 10;
    UILabel    *creditLabel  = ({
        UILabel *sentence = [UILabel new];
        sentence.frame = CGRectMake(TITLE_SENTENCE_POSI_X,
                                    credit_posi_y,
                                    TITLE_SENTENCE_width,
                                    TITLE_SENTENCE_hight);
        
        sentence.font  = [UIFont fontWithName:APPLI_FONT size:18];
        sentence.text  = @"Momiji-Mac.com";
        sentence.textAlignment = NSTextAlignmentRight;
        sentence;
        
    });
    [self.view addSubview:creditLabel];
    
}

- (void)addEyeCatchToView {
    UILabel    *eyeCatch;
    eyeCatch                 = [UILabel new];
    eyeCatch.frame           = CGRectMake(0, 0, EYE_CATCH_width, EYE_CATCH_height);
    eyeCatch.backgroundColor = COLOR_red;
    [self.view addSubview:eyeCatch];
    
}

#pragma mark -
#pragma mark ---------- menu animation ----------

- (void)showMenu {
    
    [self.animationHelper showMenu];
    
}

- (void)hideMenu:(id)sender {
    
    [self.animationHelper hideMenu:sender];
    
}

- (void)fadeOutBGM {
   self.timer_BGM = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(volumeDown)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)volumeDown {
    CGFloat    volume = self.audio.volume;
    volume -= 0.03;
    if ( volume < 0 ) {
        [self.audio stop];
        [self.timer_BGM invalidate];
//        NSLog(@"audio stop");
    } else {
        [self.audio setVolume:volume];
    }
}

#pragma mark -
#pragma mark ---------- delegate method ----------

- (void)pushedStartButton:(KSMenuAnimationHelper *)helper {
    // game start
    //    [self presentViewController:self.mainViewController animated:YES completion:nil];
    [self presentViewController:self.mainViewController
                       animated:YES
                     completion:^{
                         [self fadeOutBGM];
                     }];
}

- (void)pushedShowResultsButton:(KSMenuAnimationHelper *)helper {
    // show game score list
    UIStoryboard               *storyboard            = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KSResultsViewController    *resultsViewController = [storyboard instantiateViewControllerWithIdentifier:RESULTS_SCENE];
    [self presentViewController:resultsViewController animated:YES completion:nil];
    
}

@end
