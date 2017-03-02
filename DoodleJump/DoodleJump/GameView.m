//
//  GameView.m
//  DoodleJump
//
//  Created by xumeng on 17/2/17.
//  Copyright © 2017年 xumeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GameView.h"

@implementation GameView
@synthesize bricks,jumper;
@synthesize tilt;
@synthesize scores;
float record;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        scores=0;
        CGRect bound=[self bounds];
        record=bound.size.height;
        jumper = [[Jumper alloc] initWithFrame:CGRectMake(bound.size.width*.5, bound.size.height-10, 30, 30)];
        jumper.image = [UIImage imageNamed:@"doodleR.png"];
        [jumper setDx:0];
        [jumper setDy:10];
        
        [self addSubview:jumper];
        //[self makeBricks];

        [self makeBricks:nil];

    }
    return self;
}

-(IBAction)makeBricks:(id)sender
//-(void)makeBricks
{
    CGRect bounds = [self bounds];
   // NSLog(@"bounds height:%f, width:%f",bounds.size.height,bounds.size.width);

    float width = bounds.size.width * .2;
    float height = 20;
    //NSLog(@"width:%.2f",bounds.size.width);
   // NSLog(@"height:%.2f",bounds.size.height);
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
//            brick.isBad=false;
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    Brick *bb = [[Brick alloc] initWithFrame:CGRectMake(bounds.size.width*.4, bounds.size.height-20, bounds.size.width*.2,20 )];
    bb.image=[UIImage imageNamed:@"block.png"];
    [self addSubview:bb];
    [bricks addObject:bb];
    float bWidth=bounds.size.width;
    float bHeight=bounds.size.height;
    
    CGFloat ytmp=0.0;
    
    for (int i = 0; i < 30; ++i)
    {
        CGFloat x=rand()%(int)(bWidth*.8);
        CGFloat y=rand()%(int) (bHeight*.05)+ytmp+20;
        if(y>bHeight*.9) break;

        //NSLog(@"x%i:%.2f",i,x);
        //NSLog(@"y%i:%.2f",i,y);
        
        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(30, 30, width, height)];
        b.image=[UIImage imageNamed:@"block.png"];
        b.isBad=false;
        [b setCenter:CGPointMake(x, y)];
        [self addSubview:b];
        
        [bricks addObject:b];
        ytmp=y;
    }
    
}

-(void) rearrange:(float)iy{
    CGRect bounds=[self bounds];
    float height = bounds.size.height;
    float width = bounds.size.width;
    int i = 0;
    int random=arc4random_uniform(10);
    
    for (Brick *brick in bricks)
    {
        brick.hidden=false;
        CGPoint p = [brick center];
        if(p.y+iy >= height ){
            //location x,y of brick
            int x=rand()%(int)(width*.8);
            int y=rand()%(int)((height*.05)+i+20);
            int yy=p.y+iy-height;
            if(random<3){
                brick.image=[UIImage imageNamed:@"badBlock.png"];
                brick.isBad=true;
            }else {
                brick.image=[UIImage imageNamed:@"block.png"];
                brick.isBad=false;
            }

            [brick setCenter:CGPointMake(x,yy)];
            i=y;
            
        }else {
            p.y+=iy;
            brick.isBad=false;
            [brick setCenter:CGPointMake(p.x, p.y)];
           
        }
    }
}


-(void)arrange:(CADisplayLink *)sender
{
    //NSLog(@"call gameview arrage()! ");
    //CFTimeInterval: to control animation pause or start
    CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];

    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .5];
//    NSLog(@"jumper height:%f",[jumper dy]);

    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    [jumper setDx:[jumper dx] + tilt];
    if ([jumper dx] > 5)
        [jumper setDx:5];
    if ([jumper dx] < -5)
        [jumper setDx:-5];
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
   // NSLog(@"jumper p.x:%f, p.y:%f\n",p.x,p.y);

    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    if(record > p.y){
        scores++;
        record = p.y;
    }
    [self.delegate updatescores];
    
    // If the jumper has fallen below the bottom of the screen,fail
    if (p.y > bounds.size.height)
    {
       // [self initWithCoder:nil];
        [_delegate gameover];

       [jumper setDy:10];
        p.y = bounds.size.height;
        // return;
        
    }
    //If we've gone past the top of the screen, generate more bricks from top
    float tmph=bounds.size.height;
    if(p.y<tmph*.5){
        [self rearrange:tmph*.5-p.y];
        [jumper setDy: 0];
        scores++;
        record = tmph*.3;
        [self.delegate updatescores];
    }
    
    /*
     professor's method
     // If we've gone past the top of the screen, wrap around
     if (p.y < 0)
     p.y += bounds.size.height;
    
    */
    
   
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
                if (CGRectContainsPoint(b, p))
                {
                    if(brick.isBad) brick.hidden=true;
                    else{
                        [jumper setDy:10];
                        //brick.image=[UIImage imageNamed:@"badBlock.png"];
                        //brick.isBad=true;
                        // Yay!  Bounce!
                        //NSLog(@"score:%i",scores);
                        //NSLog(@"Bounce!");
                    }
                    
                   
                }
            
            
        }
    }
    
    [jumper setCenter:p];
//     NSLog(@"Timestamp %f", ts);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
