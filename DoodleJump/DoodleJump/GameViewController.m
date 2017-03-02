//
//  GameViewController.m
//  DoodleJump
//
//  Created by xumeng on 17/2/24.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"
#import "Jumper.h"

@interface GameViewController ()<GameViewDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;
@end
static CGPoint start;
CGPoint stop;
@implementation GameViewController
@synthesize makebrick,exit;
@synthesize exitView,gameoverview,finalscore;
@synthesize lose,updatescore,scoreLabel;
@synthesize slider;
@synthesize scores;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [_displayLink setPreferredFramesPerSecond:30];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [updatescore setText:[NSString stringWithFormat:@"%i", [_gameView scores]]];
    self.gameView.delegate=self;
//   UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesture:)];
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [_gameView setUserInteractionEnabled:YES];
//   [_gameView addGestureRecognizer:tap];
    [_gameView addGestureRecognizer:pan];
}

-(void)panGesture:(UITapGestureRecognizer*)sender{
    NSLog(@"pan test");
    if (sender.state == UIGestureRecognizerStateBegan) {
        start = [sender locationInView:self.gameView];
    }
    else if(sender.state == UIGestureRecognizerStateEnded) {
        stop = [sender locationInView:self.gameView];
        CGFloat dx = stop.x - start.x;
        CGRect bounds = [_gameView bounds];
        [_gameView setTilt:dx/bounds.size.width];
    }
}
//-(IBAction)tapGesture:(UITapGestureRecognizer*)sender{
 //   NSLog(@"tap test");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)speedChange:(id)sender
{    
    UISlider *s = (UISlider *)sender;
    NSLog(@"tilt %f", (float)[s value]);
    [_gameView setTilt:(float)[s value]];
}


-(void)updatescores{
    [updatescore setText:[NSString stringWithFormat:@"%i",[_gameView scores]]];
}

-(IBAction)exitButton:(id)sender{
    _gameView.hidden=true;
    makebrick.hidden=true;
   // slider.hidden=true;
    gameoverview.hidden=true;
    lose.hidden=true;
    exit.hidden=true;
    exitView.hidden=true;
    
}

-(void)gameover{
    [_displayLink invalidate];
    gameoverview.hidden=false;
    lose.hidden=false;
    finalscore.hidden=false;
    [lose setText:[NSString stringWithFormat:@"%i",[_gameView scores]]];
    exit.hidden=false;
    exitView.hidden=false;
   // slider.hidden=true;
    updatescore.hidden=true;
    scoreLabel.hidden=true;
}



@end
