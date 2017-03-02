//
//  GameView.h
//  DoodleJump
//
//  Created by xumeng on 17/2/17.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"


@class GameView;
@protocol GameViewDelegate <NSObject>

@optional
-(void)updatescores;
-(void)gameover;
@end

@interface GameView : UIImageView{
    
}

@property (nonatomic, strong,readwrite) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;
@property (nonatomic, weak) id <GameViewDelegate> delegate;
@property (nonatomic)int scores;
-(void)arrange:(CADisplayLink *)sender;

@end
