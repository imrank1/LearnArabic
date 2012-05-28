//
//  LetterLayer.m
//  LearnArabic
//
//  Created by Imran Khawaja on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LetterLayer.h"
#import "SimpleAudioEngine.h"



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



-(void)initializeSounds{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"alif.mp3"];
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		letterManager = [[LetterManager alloc]init];
        letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"workingarabicyGlphy.fnt" ];
      //  translationLabel = [CCLabelTTF labelWithString:[letterManager stringForProp:@"transliteration"] //fontName:@"Marker Felt" fontSize:64];
        backgroundImage = [CCSprite spriteWithFile:[letterManager stringForProp:@"backgroundImage"]];
        CGSize size = [[CCDirector sharedDirector] winSize];
        backgroundImage.position = ccp(size.width/2,size.height/2);
        backgroundImage.scale = 2;
		letterLabel.position =  ccp( size.width /2 , size.height/2 );        
        [self addChild:backgroundImage z:0];
		[self addChild: letterLabel];
        [self animateTransliteration];
        [[SimpleAudioEngine sharedEngine] playEffect:[letterManager stringForProp:@"sound"]]; 
	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    touchBeganX = location.x;
    touchBeganY = location.y;
}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    touchEndX = location.x;
    touchEndY = location.y;
    int diffX = touchEndX - touchBeganX;
        
    if (diffX > 5)
    {
        [letterManager nextLetter];
    }
    else if (diffX < -5)
    {
        [letterManager previousLetter];
    }
    [self updateLetter];
}


-(void)updateLetter{
    [self removeChild:backgroundImage cleanup:YES];
    [self removeChild:letterLabel cleanup:YES];
    [self removeChild:translationLabel cleanup:YES];
    letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"workingarabicyGlphy.fnt" ];
//    translationLabel = [CCLabelTTF labelWithString:[letterManager stringForProp:@"transliteration"] fontName://@"Marker Felt" fontSize:64];
    backgroundImage = [CCSprite spriteWithFile:[letterManager stringForProp:@"backgroundImage"]];
    CGSize size = [[CCDirector sharedDirector] winSize];
    backgroundImage.position = ccp(size.width/2,size.height/2);
    backgroundImage.scale = 2;
    letterLabel.position =  ccp( size.width /2 , size.height/2 );
    [self addChild:backgroundImage z:0];
    [self addChild:letterLabel];
    [self animateTransliteration];
    [[SimpleAudioEngine sharedEngine] playEffect:[letterManager stringForProp:@"sound"]]; 
}



-(void)animateTransliteration{
    //clear out and remove any letters
    [self removeChildByTag:1 cleanup:YES];

                                        
    //rest the array
    transliterationLettersLabelArray = nil;
    transliterationLettersLabelArray = [NSMutableArray array];

    //get the next transliteration letter and fade it in after the previous
    NSString *transliterationLetters = [letterManager stringForProp:@"transliteration"];
    CGSize size = [[CCDirector sharedDirector] winSize];
    int xPosition = (size.width/2 )-30;
    for (int index = 0 ;index < [transliterationLetters length];index++){
        unichar c = [transliterationLetters characterAtIndex:index];
        NSString *currentCharString = [NSString stringWithFormat: @"%C", c];
        CCLabelTTF *currentLetter = [CCLabelTTF labelWithString:currentCharString fontName:@"Marker Felt" fontSize:64];
        currentLetter.position = ccp(xPosition,(size.height/2)-50);
        [currentLetter setTag:1];
       [self addChild:currentLetter];
        currentLetter.opacity = 0;
        float timeDelay = .5*index;
        id fadein = [CCFadeIn actionWithDuration:0.5];
        id delayTime = [CCDelayTime actionWithDuration:timeDelay];
        [currentLetter runAction:[CCSequence actions:delayTime,fadein,nil]];
        [transliterationLettersLabelArray addObject:currentLetter];
        xPosition +=20;
    }

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
