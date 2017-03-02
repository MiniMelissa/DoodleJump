//
//  ViewController.m
//  DoodleJump
//
//  Created by xumeng on 17/2/14.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController
@synthesize play;
@synthesize playView,beginBackground;
@synthesize logo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
//    [_displayLink setPreferredFramesPerSecond:30];
//    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    self.gameView.delegate=self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"Performing segue with ID %@, so we can set things up.", identifier);
}

-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    NSLog(@"Backing out of the other view controller.");
   // [counterLabel setText:[NSString stringWithFormat:@"Counter: %d", [[Universe sharedInstance] counter]]];
    
}

-(IBAction)playButton:(id)sender{
  //  _gameView = [[GameView alloc]init];
//    play.hidden=true;
//    playView.hidden=true;
//    beginBackground.hidden=true;
//    logo.hidden=true;
//    GameViewController *game=[[GameViewController alloc]init];

}




@end
