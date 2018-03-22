//
//  KSScoreViewController.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/17.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSScoreViewController.h"
#import "KSResultsViewController.h"
#import "KSMenuButton.h"
#import "KSCoreDataController.h"
#import "KSResults.h"
#import "KSDataFormatter.h"
#import "KSScoreItemLabel.h"
#import "deff.h"
#import "KSDiviceHelper.h"

@interface KSScoreViewController ()

@property (nonatomic, retain) NSTimer           *viewStartTimer;
@property (nonatomic) CGFloat                   startIndicator;
@property (nonatomic, retain) NSMutableArray    *labelArray;
@property (nonatomic) NSInteger                 labelIndex;
@property (nonatomic, retain) UILabel           *eyeCatch;
@property (nonatomic, retain) KSMenuButton      *ShowResultsButton;
@property (nonatomic, retain) KSMenuButton      *reStartButton;


@end

@implementation KSScoreViewController

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
    
    
    // eye chatch
    self.eyeCatch       = [UILabel new];
    self.eyeCatch.frame = CGRectMake(0,
                                     0,
                                     EYE_CATCH_width,
                                     EYE_CATCH_height);
    
    self.eyeCatch.backgroundColor = COLOR_green;
    [self.view addSubview:self.eyeCatch];
    
    //Restart button
    self.reStartButton = [[KSMenuButton new] reStartButon];    
    self.reStartButton.tag = TAG_Start;
    [self.reStartButton addTarget:self action:@selector(reStartGame) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.reStartButton];
    
    //show Results
    self.ShowResultsButton = [[KSMenuButton new] showResultsButton];
    

    CGRect     gRect  = CGRectMake(SCREEN_SIZE.width * 0.5 + ADJUST_POSI_X,
                                   SCREEN_SIZE.height,
                                   BUTTON_WIDTH,
                                   BUTTON_HEIGHT);
    
    self.ShowResultsButton.frame = gRect;
    self.ShowResultsButton.tag   = TAG_ShowResults;
    [self.ShowResultsButton addTarget:self action:@selector(showResultView) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.ShowResultsButton];
    
    self.labelIndex = 0;
    [self displayScore];
    
}

- (void)viewWillAppear:(BOOL)animated { //restart時に必要な処理
    
    [super viewWillAppear:animated];
    
    self.viewStartTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                           target:self
                                                         selector:@selector(animationTrigger)
                                                         userInfo:nil
                                                          repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ---------- display score ----------

#define ITEM_width  300
#define ITEM_heigh  30
#define ITEM_heigh_iPhone4 25
#define ITEMS_SPACE 10

- (void)displayScore {
    
    NSDictionary    *dataDic = [self load];
    
    // 結果概要
    NSArray         *titleData = @[dataDic[DATA_SCORE],
                                   dataDic[DATA_PLAYTIME],
                                   dataDic[DATA_DATE],
                                   dataDic[DATA_REMAINCARDS]];
    
    NSArray    *titleArray = @[@"score",
                               @"time",
                               @"date",
                               @"remain"];
    
    self.labelArray = @[].mutableCopy;
    if ( [titleData count] != [titleArray count] ) {
        NSLog(@"error at %@", NSStringFromSelector(_cmd));
    }
    
    
    //機種依存
    CGFloat hieght  = 0;
    if ( [KSDiviceHelper is568h] ) {
        hieght = ITEM_heigh;
    } else {
        hieght = ITEM_heigh_iPhone4;
    }

    for ( int i = 0; i < [titleArray count]; i++ ) {
        KSScoreItemLabel    *kslabel = [KSScoreItemLabel new];
        CGRect              rect     = CGRectMake(SCREEN_SIZE.width,
                                                  10 + (hieght * (i) + (ITEMS_SPACE * i)),
                                                  //EYE_CATCH_height + (hieght * (i) + (ITEMS_SPACE * i)),
                                                  ITEM_width,
                                                  hieght);
        kslabel.frame           = rect;
        kslabel.backgroundColor = COLOR_MENU_BAR;
        
        kslabel.itemTitle.text = [NSString stringWithFormat:@"%@", titleArray[i]];
        
        if (i == 0) { // score　表示だけはFormatte
            KSDataFormatter* df = [KSDataFormatter new];
            NSString* str = [df scoreFormatted:[titleData[i] integerValue]];
            kslabel.itemValue.text = str;
//            kslabel.itemValue.text = titleData[i];
            
        }else{
            kslabel.itemValue.text = titleData[i];
        }
        
        [self.view addSubview:kslabel];
        [self.labelArray addObject:kslabel];
    }
    
    //結果詳細
    NSArray    *detailArray = @[@"flash",
                                @"flash pari",
                                @"pair",
                                @"straight",
                                @"straight flash",
                                @"four",
                                @"loyal straight flash"];
    
    NSArray    *datailData = @[dataDic[DATA_FLASH],
                               dataDic[DATA_PAIRFLASH],
                               dataDic[DATA_PAIR],
                               dataDic[DATA_STRAIGHT],
                               dataDic[DATA_STRAIGHTFLASH],
                               dataDic[DATA_FOUR],
                               dataDic[DATA_LOYAL_STRAIGHFLASH]];
    
    for ( int i = 0; i < [detailArray count]; i++ ) {
        KSScoreItemLabel    *kslabel = [KSScoreItemLabel new];
        CGRect              rect     = CGRectMake(SCREEN_SIZE.width,
                                                  (SCREEN_SIZE.height * 0.34) + (hieght * (i) + (ITEMS_SPACE * i)),
                                                  ITEM_width,
                                                  hieght);
        kslabel.frame           = rect;
        kslabel.backgroundColor = COLOR_MENU_Charactors;
        
        kslabel.itemTitle.text      = [NSString stringWithFormat:@"%@", detailArray[i]];
        kslabel.itemTitle.textColor = [UIColor whiteColor];
        
        kslabel.itemValue.text      = datailData[i];
        kslabel.itemValue.textColor = [UIColor whiteColor];
        
        [self.view addSubview:kslabel];
        [self.labelArray addObject:kslabel];
        
    }
    
}

#pragma mark - --------- load ----------

- (NSDictionary *)load {
    
    //最新のデータを用意
    NSArray                *resultsArray = [[NSArray alloc]initWithArray:[[KSCoreDataController sharedManager] sortedEntity:NO]];
    KSResults              *aResult      = [resultsArray objectAtIndex:0];
    
    //dataをまとめる（表示しやすいようにまとめる）
    NSMutableDictionary    *dataDic = [@{} mutableCopy];
    
    //日付
    NSDate                 *date       = aResult.date;
    KSDataFormatter        *dataF      = [KSDataFormatter new];
    NSDateComponents       *dateComps  = [dataF separateDateComponets:date];
    NSString               *dateString = [NSString stringWithFormat:@"%d,%d,%d", dateComps.year, dateComps.month, dateComps.day];
    dataDic[DATA_DATE] = dateString;
    
    //play time
    dataDic[DATA_PLAYTIME] = aResult.playTime;
    
    //score
    NSString    *scoreString = [NSString stringWithFormat:@"%d", [aResult.score integerValue]];
    dataDic[DATA_SCORE] = scoreString;
    
    // remain cards
    dataDic[DATA_REMAINCARDS] = aResult.remainCards;
    
    dataDic[DATA_FLASH]              = aResult.times_F;
    dataDic[DATA_STRAIGHT]           = aResult.times_S;
    dataDic[DATA_PAIR]               = aResult.times_P;
    dataDic[DATA_PAIRFLASH]          = aResult.times_PF;
    dataDic[DATA_STRAIGHTFLASH]      = aResult.times_SF;
    dataDic[DATA_FOUR]               = aResult.times_Four;
    dataDic[DATA_LOYAL_STRAIGHFLASH] = aResult.times_LSF;
    
    return dataDic;
}

#pragma mark -
#pragma mark ---------- animation ----------

#define ANIMATION_START_INTERVAL 0.5

- (void)animationTrigger {
    self.startIndicator += 0.1;
    if ( self.startIndicator > ANIMATION_START_INTERVAL ) {
        [self.viewStartTimer invalidate];
        [self scoreAnimation];
    }
    
}

- (void)scoreAnimation {
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self scoreEachAnimation:self.labelIndex];
                     } completion:^(BOOL finished) {
                         if ( self.labelIndex < [self.labelArray count] - 1 ) {
                             self.labelIndex++;
                             [self scoreAnimation];
                         } else {
                             [self buttonAnimation];
                         }
                         
                     }];
}

- (void)buttonAnimation {
    
    //機種依存
    CGFloat height  = 0;
    height = SCREEN_SIZE.height - BUTTON_HEIGHT * 2 + ADJUST_BUTTON_HIGHT;
    if ( [KSDiviceHelper is568h] ) {
        
    } else {
        height += 10;
    }


    [UIView animateWithDuration:0.2f
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect rect = self.reStartButton.frame;
                         rect.origin.y = height;
                         self.reStartButton.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                               delay:0.1
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              
                                              CGRect rect = self.ShowResultsButton.frame;
                                              rect.origin.y = height;
                                              self.ShowResultsButton.frame = rect;
                                              
                                          } completion:^(BOOL finished) {
                                              nil;
                                          }];
                     }];
    
}

- (void)scoreEachAnimation:(NSInteger)index {
    KSScoreItemLabel    *label = (KSScoreItemLabel *)self.labelArray[index];
    CGRect              rect   = label.frame;
    rect.origin.x = EYE_CATCH_width;
    label.frame   = rect;
    
}

#pragma mark -
#pragma mark ---------- reStart ----------

- (void)reStartGame {
    //画面遷移
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

#pragma mark -
#pragma mark ---------- Show Results ----------
- (void)showResultView {
    
    UIStoryboard               *storyboard            = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KSResultsViewController    *resultsViewController = [storyboard instantiateViewControllerWithIdentifier:RESULTS_SCENE];
    [self presentViewController:resultsViewController animated:YES completion:nil];
    
}

@end
