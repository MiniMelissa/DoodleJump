//
//  GameViewController.h
//  DoodleJump
//
//  Created by xumeng on 17/2/24.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface GameViewController : UIViewController <GameViewDelegate>{
    UILabel *updatescore;
}
@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic,strong) IBOutlet UIButton *makebrick,*exit;
@property (nonatomic,strong) IBOutlet UIImageView *exitView,*gameoverview,*finalscore;
@property (nonatomic,strong) IBOutlet UILabel *lose,*updatescore,*scoreLabel;
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property(nonatomic)int scores;

@end
