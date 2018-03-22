//
//  KSOriginalButton.m
//  FlowtingMenuTest
//
//  Created by 清水 一征 on 13/08/14.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSMenuButton.h"
#import <QuartzCore/QuartzCore.h>
#import "deff.h"
#import "KSDiviceHelper.h"

#pragma mark -
#pragma mark ---------- under line ----------
@interface LineLayer : CALayer

@property (nonatomic, retain) UIColor    *lineColor;

@end
@implementation LineLayer
- (void)drawInContext:(CGContextRef)ctx {
    CGMutablePathRef    path = CGPathCreateMutable();
    //配列で、描画する点を指定します。　指定した点同士をつなぐように直線を描きます。
    CGPoint             points[] = {
        CGPointMake(0,                      self.bounds.size.height),
        CGPointMake(self.bounds.size.width, self.bounds.size.height),
    };
    
    int                 numPoints = sizeof(points) / sizeof(points[0]);
    //点と点の数を指定して直線を描写します。
    CGPathAddLines(path, NULL, points, numPoints);
    
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    
    //線の色を設定
    UIColor    *lineColor_ = self.lineColor;
    CGContextSetStrokeColorWithColor(ctx, lineColor_.CGColor);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextDrawPath(ctx, kCGPathStroke);
}

@end

#pragma mark -
#pragma mark ---------- ここまで ----------

@interface KSMenuButton ()

@end

@implementation KSMenuButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        
        //共通
        [self setTitleColor:COLOR_MENU_Charactors forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:APPLI_FONT size:24];
        
        //<tapped>
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // <layer corner round>
        CALayer    *mLayer = [self layer];
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];
        
        self.eyeCatch = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.eyeCatch];
        
        self.subjectLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subjectLabel.font = [UIFont fontWithName:APPLI_FONT size:14];
        [self addSubview:self.subjectLabel];
        
        self.numberLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numberLabel.font = [UIFont fontWithName:APPLI_FONT size:14];
        [self addSubview:self.numberLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.eyeCatch.frame           = CGRectMake(10, 10, 10, 10);
    self.eyeCatch.backgroundColor = COLOR_yellow;
    
    if ( !CGRectIsEmpty(self.subjectRect)) {
        CGRect    r = self.subjectRect;
        self.subjectLabel.frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height);
    }
    
    if ( !CGRectIsEmpty(self.numberRect)) {
        CGRect    r = self.numberRect;
        self.numberLabel.frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height);
    }
    
}

#pragma mark -
#pragma mark ---------- each button ----------

- (KSMenuButton *)startButton {
    
    CGRect    rRect = CGRectMake(SCREEN_SIZE.width,
                                 BUTTONS_TOP_POSI,
                                 BUTTON_WIDTH,
                                 BUTTON_HEIGHT);
    
    KSMenuButton    *startButton = ({
        
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:rRect];
        menuButton.backgroundColor = COLOR_red;
        [menuButton setTitle:@"START" forState:UIControlStateNormal];
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_MENU_Charactors;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return startButton;
    
}

- (KSMenuButton *)showResultsButton {
    
    // divice
    if ( [KSDiviceHelper is568h] ) { // iPhone 5
        
    } else { // iphone3 ~ iphone 4
        
    }
    
    CGRect    gRect = CGRectMake(SCREEN_SIZE.width,
                                 BUTTONS_TOP_POSI + BUTTON_HEIGHT + BUTTONS_SPACE,
                                 BUTTON_WIDTH,
                                 BUTTON_HEIGHT);
    KSMenuButton    *showResultsButton = ({
        
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:gRect];
        menuButton.backgroundColor = COLOR_blue;
        [menuButton setTitle:@"SCORE" forState:UIControlStateNormal];
        
        //        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_MENU_Charactors;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return showResultsButton;
}

- (KSMenuButton *)reStartButon {
    
    CGFloat    x_hidden = SCREEN_SIZE.width * 0.5 - BUTTON_WIDTH - ADJUST_POSI_X;
    
    CGRect     rRect = CGRectMake(x_hidden,
                                  SCREEN_SIZE.height,
                                  BUTTON_WIDTH,
                                  BUTTON_HEIGHT);
    
    KSMenuButton    *reStartButton = ({
        
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:rRect];
        menuButton.backgroundColor = COLOR_red;
        [menuButton setTitle:@"Re-START" forState:UIControlStateNormal];
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_MENU_Charactors;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return reStartButton;
    
}

- (KSMenuButton *)giveUpButton {
    CGRect    gRect = CGRectMake(0,
                                 0,
                                 MENU_width,
                                 MENU_height);
    
    KSMenuButton    *giveUpButton = ({
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:gRect];
        menuButton.backgroundColor = COLOR_green;
        [menuButton setTitle:@"GIVE UP" forState:UIControlStateNormal];
        menuButton.center = CGPointMake(SCREEN_SIZE.width * 0.5,
                                        SCREEN_SIZE.height * 0.5 + POSITION_OFFSET);
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_red;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return giveUpButton;
}

- (KSMenuButton *)cancelButton {
    CGRect          cRect         = CGRectMake(0, 0, MENU_width, MENU_height);
    KSMenuButton    *CancelButton = ({
        
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:cRect];
        menuButton.backgroundColor = COLOR_MENU_BAR;
        [menuButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        menuButton.center = CGPointMake(SCREEN_SIZE.width * 0.5,
                                        SCREEN_SIZE.height * 0.5 - POSITION_OFFSET);
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_red;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
    });
    
    return CancelButton;
}

- (KSMenuButton *)timerButton {
    CGRect    mRect = CGRectMake(MENU_BASE_POSI_X - ADJUST_POSI_X,
                                 MENU_BASE_POSI_Y,
                                 MENU_width,
                                 MENU_height);
    
    KSMenuButton    *time_menuButton = ({
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:mRect];
        menuButton.backgroundColor = COLOR_MENU_BAR;
        [menuButton setTitle:@"" forState:UIControlStateNormal];
        menuButton.subjectLabel.text = @"time";
        menuButton.subjectRect = CGRectMake(ITEM_BASE_X,
                                            ITEM_BASE_LINE,
                                            ITEM_SUBJECT_width,
                                            ITEM_SUBJECT_heigh);
        
        menuButton.subjectLabel.backgroundColor = [UIColor clearColor];
        menuButton.numberLabel.text = @"123456789";
        menuButton.numberRect = CGRectMake(ITEM_BASE_X + ITEM_SUBJECT_width + ADJUST_NUMBER_POSI,
                                           ITEM_BASE_LINE,
                                           ITEM_NUMBER_width,
                                           ITEM_NUMBER_height);
        
        menuButton.numberLabel.backgroundColor = [UIColor clearColor];
        menuButton.numberLabel.textAlignment = NSTextAlignmentRight;
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_red;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
    });
    
    return time_menuButton;
}

- (KSMenuButton *)scoreButton {
    CGRect    sRect = CGRectMake(MENU_BASE_POSI_X + MENU_width + ADJUST_POSI_X,
                                 MENU_BASE_POSI_Y,
                                 MENU_width,
                                 MENU_height);
    
    KSMenuButton    *socre_menuButton = ({
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:sRect];
        menuButton.backgroundColor = COLOR_MENU_BAR;
        [menuButton setTitle:@"" forState:UIControlStateNormal];
        menuButton.subjectLabel.text = @"score";
        menuButton.subjectRect = CGRectMake(ITEM_BASE_X,
                                            ITEM_BASE_LINE,
                                            ITEM_SUBJECT_width,
                                            ITEM_SUBJECT_heigh);
        
        menuButton.subjectLabel.backgroundColor = [UIColor clearColor];
        menuButton.numberLabel.text = @"123456789";
        menuButton.numberRect = CGRectMake(ITEM_BASE_X + ITEM_SUBJECT_width + ADJUST_NUMBER_POSI,
                                           ITEM_BASE_LINE,
                                           ITEM_NUMBER_width,
                                           ITEM_NUMBER_height);
        
        menuButton.numberLabel.backgroundColor = [UIColor clearColor];
        menuButton.numberLabel.textAlignment = NSTextAlignmentRight;
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_red;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return socre_menuButton;
}

- (KSMenuButton *)doneButton {
    CGRect    rect = CGRectMake((SCREEN_SIZE.width - BUTTON_WIDTH) * 0.5,
                                SCREEN_SIZE.height - BUTTON_HEIGHT * 2,
                                BUTTON_WIDTH,
                                BUTTON_HEIGHT);
    KSMenuButton    *doneButton = ({
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:rect];
        menuButton.backgroundColor = COLOR_red;
        [menuButton setTitle:@"DONE" forState:UIControlStateNormal];
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_MENU_Charactors;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return doneButton;
    
}

- (KSMenuButton *)endingButton:(NSInteger) score {
    CGRect    rect =  CGRectMake(0,
                                 0,
                                 SCREEN_SIZE.width * 0.9,
                                 SCREEN_SIZE.height * 0.2);
    
    KSMenuButton    *endBtn = ({
        
        KSMenuButton *btn = [[KSMenuButton alloc] initWithFrame:rect];
        btn.center  = CGPointMake(SCREEN_SIZE.width * 0.5,
                                               SCREEN_SIZE.height * 0.5);
        btn.backgroundColor = COLOR_green;

        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(btn.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_red;
        [btn.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];


        
        btn;
    });
    

#define POSI_Y_ADJUST_AT_ENDING 10

    UILabel    *massageLabel = [UILabel new];
    massageLabel.frame = CGRectMake(10,
                                    10,
                                    250,
                                    50);
    massageLabel.center = CGPointMake(endBtn.frame.size.width * 0.5,
                                      endBtn.frame.size.height * 0.5 - POSI_Y_ADJUST_AT_ENDING);
    massageLabel.text            = @"Congratulations!";
    massageLabel.textAlignment   = NSTextAlignmentCenter;
    massageLabel.font            = [UIFont fontWithName:APPLI_FONT size:24];
    massageLabel.backgroundColor = [UIColor clearColor];
    [endBtn addSubview:massageLabel];
    
    UILabel    *notificationLabel = [UILabel new];
    notificationLabel.frame = CGRectMake(10,
                                         10,
                                         250,
                                         50);
    notificationLabel.center = CGPointMake(endBtn.frame.size.width * 0.5,
                                           endBtn.frame.size.height * 0.5 + POSI_Y_ADJUST_AT_ENDING);
    notificationLabel.text            = [NSString stringWithFormat:@"Clear Bounus:%d x 2 = %d",score, score*2];
    notificationLabel.textAlignment   = NSTextAlignmentCenter;
    notificationLabel.font            = [UIFont fontWithName:APPLI_FONT size:14];
    notificationLabel.backgroundColor = [UIColor clearColor];
    [endBtn addSubview : notificationLabel];



    return endBtn;
}

@end
