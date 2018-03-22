//
//  KSMenuView.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/29.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSMenuView.h"
#import "deff.h"

@interface KSMenuView () <GLKViewDelegate>

@property (nonatomic, strong) CIContext    *myContext;
@property (nonatomic)     CGSize           imageSizeInPixels;

@end

@implementation KSMenuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        
        [self initFile];
        
    }
    
    return self;
}

- (void)initFile {
    // EAGLDelegateの設定
    self.delegate = self;
    
    // コンテキスト生成
    self.context   = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.myContext = [CIContext contextWithEAGLContext:self.context];
    
    // ピクセル単位でのサイズ
    CGFloat    scale = [[UIScreen mainScreen] scale];
    _imageSizeInPixels = CGSizeMake(self.bounds.size.width * scale,
                                    self.bounds.size.height * scale);
}


-(KSMenuView*) GiveAndCancelMenu{
    
    CGRect rect = CGRectMake(SCREEN_SIZE.width,
                             0,
                             SCREEN_SIZE.width,
                             SCREEN_SIZE.height);

    KSMenuView *menu = [[KSMenuView alloc] initWithFrame:rect];
    return menu;
}

#pragma mark -------------------------------------------------------------------
#pragma mark GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    rect.size = _imageSizeInPixels;
    
    // フィルタを生成
   
    CIFilter    *filter = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    // 出力画像のCIImageオブジェクトを取得
    CIImage    *image = [filter valueForKey:kCIOutputImageKey];
    
    // CIImageを描画
    [self.myContext drawImage:image
                       inRect:rect
                     fromRect:rect];
}

@end
