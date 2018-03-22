//
//  KSResultsViewController.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/17.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSResultsViewController.h"
#import "KSMenuButton.h"
#import "deff.h"
#import "KSCoreDataController.h"
#import "KSResults.h"
#import "KSRecord.h"
#import "KSDiviceHelper.h"
#import "KSRecordAnimationHelper.h"

#define BEST_5_SCORE                   5
#define BEST_4_SCORE                   4
#define RECORD_width                   300
#define RECORD_height                  60
#define SPACE_BWTEEN_RECORDS           30
#define INTERVAL_FOR_ANIMATION_TRIGGER 0.1

@interface KSResultsViewController ()

@property (nonatomic, retain) KSRecordAnimationHelper    *animeHelper;
@property (nonatomic, retain) NSTimer                    *triggerTimer;

@end

@implementation KSResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load
    [self load];

    KSMenuButton    *doneButton = [[KSMenuButton new] doneButton];
    [doneButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:doneButton];
    
    UILabel    *eyeCatch;
    eyeCatch                 = [UILabel new];
    eyeCatch.frame           = CGRectMake(0, 0, EYE_CATCH_width, EYE_CATCH_height);
    eyeCatch.backgroundColor = COLOR_blue;
    [self.view addSubview:eyeCatch];
    
    //animation helper
    self.animeHelper = [KSRecordAnimationHelper new];
    
    //animation timer
    self.timer = 0;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.triggerTimer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_FOR_ANIMATION_TRIGGER
                                                         target:self
                                                       selector:@selector(animationTrigger:)
                                                       userInfo:nil
                                                        repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
    
    //画面遷移
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark -
#pragma mark ---------- animation schedule ----------
- (void)animationTrigger:(NSTimer *)delta {
    
    self.timer += INTERVAL_FOR_ANIMATION_TRIGGER;
    if ( self.timer > 0.5 ) {
        if ( [self.recordViewArray count] > 0 ) { // recordsが作成されていれば
            
            [self.animeHelper showRecord:self.recordViewArray];
            //            NSLog(@"timer!");
            [self.triggerTimer invalidate];
            
        } else { // recordsが作成されていない
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            [self.triggerTimer invalidate];
        }
        
    }
}

#pragma mark - --------- load ----------

- (void)load {
    
    //最新のデータを用意
    NSArray    *bestScore = [[NSArray alloc] initWithArray:[KSCoreDataController sharedManager].sortedEntityByScore];
    
    NSUInteger    recordedNumber = [bestScore count];

    // divice
    int        best = 0;
    if ( [KSDiviceHelper is568h] ) {
        best = BEST_5_SCORE;
    } else {
        best = BEST_4_SCORE;
    }
    
    if (recordedNumber > best) {
        recordedNumber = best;
    }
    
    
    
    self.recordViewArray = @[].mutableCopy;
    
    for ( int i = 0; i < recordedNumber; i++ ) {
        KSResults    *aResult = [bestScore objectAtIndex:i];
        KSRecord     *record  = [KSRecord new];
        [record makeRecord:aResult];
        record.orderLabel.text = [NSString stringWithFormat:@"%d", i + 1];
        
        record.frame = CGRectMake(SCREEN_SIZE.width,
                                  (EYE_CATCH_height * (i + 1)) + (i * SPACE_BWTEEN_RECORDS),
                                  RECORD_width,
                                  RECORD_height);
        
        [self.view addSubview:record];
        [self.recordViewArray addObject:record];
        
    }
    
}

@end
