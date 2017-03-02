//
//  ViewController.h
//  DoodleJump
//
//  Created by xumeng on 17/2/14.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"
#import "GameViewController.h"

@interface ViewController : UIViewController
//@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic,strong) IBOutlet UIButton *play;
@property (nonatomic,strong) IBOutlet UIImageView *beginBackground,*playView;
@property (nonatomic,strong) IBOutlet UILabel *logo;


@end

