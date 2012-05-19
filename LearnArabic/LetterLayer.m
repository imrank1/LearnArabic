//
//  LetterLayer.m
//  LearnArabic
//
//  Created by Imran Khawaja on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LetterLayer.h"

@implementation LetterLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LetterLayer *layer = [LetterLayer node];
	layer.isTouchEnabled = TRUE;
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		letterManager = [[LetterManager alloc]init];
		// create and initialize a Label
        //		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Let's Learn!" fontName:@"Marker Felt" fontSize:64];
        letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"testFont.fnt" ];
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		letterLabel.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: letterLabel];
	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    touchBeganX = location.x;
    touchBeganY = location.y;
    NSLog(@"Touch Began");

}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    touchEndX = location.x;
    touchEndY = location.y;
    int diffX = touchEndX - touchBeganX;
    NSLog(@"Touch Ended start x %d, end x %d, diff is %d",touchBeganX,touchEndX,diffX);

    int diffY = touchEndY - touchBeganY;
        
    if (diffX > 5)
        {
            NSLog(@"swipe right");
            [letterManager nextLetter];
            // do something here
        }
        else if (diffX < -5)
        {
            NSLog(@"swipe left");
            [letterManager previousLetter];
            // do something else here
        }
[self updateLetter];
}


-(void)updateLetter{
    [self removeChild:letterLabel cleanup:NO];
    letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"testFont.fnt" ];
    CGSize size = [[CCDirector sharedDirector] winSize];
    letterLabel.position =  ccp( size.width /2 , size.height/2 );
    [self addChild:letterLabel];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
