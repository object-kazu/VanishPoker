//
//  deff.h
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/07/30.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#ifndef PuzzlePoker_deff_h
#define PuzzlePoker_deff_h

#pragma mark -
#pragma mark ---------- General ----------

//画面
#define SCREEN_BOUNDS                     ([UIScreen mainScreen].bounds)
#define SCREEN_SIZE                       (SCREEN_BOUNDS.size)

//color macro
#define RGBA(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define RGB(r, g, b)     [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1]

// basic color
#define COLOR_red                         [UIColor colorWithRed:244 / 255.0 green:82 / 255.0 blue:137 / 255.0 alpha:1]
#define COLOR_yellow                      [UIColor colorWithRed:255 / 255.0 green:211 / 255.0 blue:85 / 255.0 alpha:1]
#define COLOR_blue                        [UIColor colorWithRed:100 / 255.0 green:106 / 255.0 blue:233 / 255.0 alpha:1]
#define COLOR_green                       [UIColor colorWithRed:163 / 255.0 green:248 / 255.0 blue:83 / 255.0 alpha:1]
#define COLOR_MENU_Charactors             [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]
#define COLOR_MENU_BAR                    (RGBA(224, 224, 224, 1.0))
#define COLOR_SELECTED                    ([UIColor whiteColor])//([UIColor purpleColor])

//log macro
#define LOG_METHOD_NAME                   NSLog(@"method name is %@", NSStringFromSelector(_cmd));
#define LOG_ERROR_METHOD                  NSLog(@"error at %@", NSStringFromSelector(_cmd));

#pragma mark -
#pragma mark ---------- Application general ----------

#define APPLI_FONT @"Skia-Regular"


#pragma mark -
#pragma mark ---------- Scene ----------

//画面遷移
#define START_SCENE                       @"start"
#define MAIN_SCENE                        @"main"
#define SCORE_SCENE                       @"score"
#define RESULTS_SCENE                     @"results"

#pragma mark -
#pragma mark ---------- save & load ----------
//save data
#define DATA_DATE                         @"dateDATA"
#define DATA_PLAYTIME                     @"playtimeDATA"
#define DATA_SCORE                        @"scoreDATA"
#define DATA_REMAINCARDS                  @"remainCardDATA"
#define DATA_FLASH                        @"flashDATA"
#define DATA_STRAIGHT                     @"straightDATA"
#define DATA_PAIR                         @"pairDATA"
#define DATA_PAIRFLASH                    @"pairflashDATA"
#define DATA_STRAIGHTFLASH                @"straightFlashDATA"
#define DATA_FOUR                         @"fourDATA"
#define DATA_LOYAL_STRAIGHFLASH           @"loyalstraightflashDATA"

#pragma mark -
#pragma mark ---------- display layer ----------

// shadow offset
#define SHADOW_OFFSET                     (CGSizeMake(5, 3))

// eyeCatch
#define EYE_CATCH_width                   50.0f
#define EYE_CATCH_height                  50.0f

#pragma mark -
#pragma mark ---------- card ----------

#define CARD_COLOR_RED                    @"cardColor_red"
#define CARD_COLOR_BLUE                   @"cardColor_blue"
#define CARD_COLOR_GREEN                  @"cardColor_green"
#define CARD_COLOR_YELLOW                 @"cardColor_yellow"
#define CARD_COLOR_ERROR                  @"_error_"

// card number
#define CARD_NUMBER_MAX                   13 // card number 1 ~ 13
#define CARD_COLOR_MAX                    4 // card color is red, green, blue, yellow

//card marker animation
#define ANIME_MARKER_ROTATE_SPEED         0.1f
#define ANIME_MARKER_TORATE_DELAY         0.0f

// card's property
#define CARD_WIDTH                        50
#define CARD_HIGHT                        50
#define CARD_TAG_SECOND_DIGIT             10 //二桁目にするための定数

#define INTERSECTION_X_MAX                6
#define INTERSECTION_Y_MAX                9 // <<<<<<<<<<< 8
#define INTERSECTION_Y_MAX_EXCEPT_iPhone5 8

// card animation
#define ANIME_FILL_CARD_DURATION          0.1f
#define ANIME_FILL_CARD_DELAY             0.0f
#define ANIME_REMOVE_CARD_DURATION        0.1f
#define ANIME_REMOVE_CARD_DELAY           0.0f
#define ANIME_HIDDEN_CARD_DURATION        0.3f
#define ANIME_HIDDEN_CARD_DELAY           0.1f

//card mark font
#define CARD_MARK_FONT_SIZE 20

#pragma mark -
#pragma mark ---------- masu ----------
//masuの番地は（０，０）〜（５，８）
#define MASU_X_MAX                        5
#define MASU_Y_MAX                        8 // <<<<<<<<<<<<<< 7
#define OUT_OF_MASU                       -1
#define MASU_Y_MAX_EXCEPT_iPhone5         7

#pragma mark -
#pragma mark ---------- button ----------
// button
#define BUTTON_HEIGHT                     50.0f
#define BUTTON_WIDTH                      150.0f
#define BUTTONS_TOP_POSI                  240
#define BUTTONS_SPACE                     20
#define BUTTON_CORNER_ROUND               5.0f
#define ADJUST_BUTTON_HIGHT               10 // Score Viewのボタン（restart & score）のための補正項

// menu button
#define MENU_BASE_POSI_X                  10 //button base positon
#define MENU_BASE_POSI_Y                  2 //button base positon
#define MENU_width                        146//150 //button size
#define MENU_height                       40 //45 //button size
#define MENU_LINE_BASE                    9.0 //menu under lineの位置
#define ADJUST_POSI_X                     4 // 位置補正項
#define ITEM_BASE_LINE                    15
#define MENU_BUTTON_FONT_SIZE

//menu button の表示項目
#define ITEM_BASE_X                       10
#define ITEM_SUBJECT_width                40
#define ITEM_SUBJECT_heigh                20
#define ITEM_NUMBER_width                 80
#define ITEM_NUMBER_height                20
#define ADJUST_NUMBER_POSI                15

#pragma mark -
#pragma mark ---------- menu animation ----------

// menu animation class use
//game start
#define TAG_Start                         111
#define TAG_ShowResults                   121
//game end
#define TAG_ReStart                       131
#define TAG_GiveUp                        141
#define TAG_Exit                          151

//menu animation
#define ANIME_SHOW_DURATION               0.3f
#define ANIME_SHOW_DELAY                  0.05f
#define ANIME_OVERGOING_DISTANCE          10
#define ANIME_BACKTO_POSITION_DURATION    0.2
#define ANIME_MENU_ITEM_NUMBERS           2

// give up and cancel menu
#define POSITION_OFFSET                   50 //Y中心からどれくらいずらして表示するか

#pragma mark -
#pragma mark ---------- game balance ----------

//<GAME Balance>
#define CARD_SET_NUMBER_DEFAULT           2 //2組みのカードを使う
// yaku
#warning Game Balance Check!
#define LOYALSTRAIGHTFLASH                2000 //3 x 2000 = 6000
#define STRAIGHTFLASH                     1000 //3 x 1000 = 3000
#define FOUR                              700  //4 x 700  = 2800
#define FLASHPAIR                         500  //2 x 500  = 1000
#define STRAIGHT                          100  //3 x 100  = 300
#define PAIR                              50   //3 x 50   = 150
#define FLASH                             5

#pragma mark -
#pragma mark ---------- etc ----------
//touch event
#define TOUCH_EVENT_INTERVAL              0.1

// field
#define MARGIN_X                          10

//give-up indicator
#define INTERVAL_GIVE_UP_TIMER            0.1f
#define NO_ACTION_TIME_LIMIT              7.0f
#define PURU_PURU_INTERVAL                2.0f
#define GIVE_UP_INDICATOR_X_POSI          50
#define GIVE_UP_INDICATOR_Y_POSI          6
#define GIVE_UP_INDICATOR_width           100
#define GIVE_UP_INDICATOR_height          10
#define GIVE_UP_INDICATOR_FONT_SIZE 12

//device direction
typedef NS_ENUM (NSInteger, deviceDirection) {
    HOMEButton_Top,
    HOMEButton_Down,
    HOMEButton_Left,
    HOMEButton_Right
};

typedef struct {
    NSInteger    x;
    NSInteger    y;
} MasuPoint;

// card color
#define _RED_    @"r"
#define _GREEN_  @"g"
#define _BLUE_   @"b"
#define _YELLOW_ @"y"
#define _BLACK_  @"black"


//game mode
typedef NS_ENUM(NSUInteger, kGameMode){
    easyMode,
    normalMode,
    longMode,
    veryLongMode
};
#define kGAME_MODE_ARRAY @"easy",@"normal",@"long",@"verylong",nil


//ending view
#define ENDING_VIEW_TAG 1111

#endif
