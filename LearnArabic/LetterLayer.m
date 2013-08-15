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
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"arabicLetters.caf"];
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {

		letterManager = [[LetterManager alloc]init];
        letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"fullArabicLeters.fnt" ];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         @"arabicApp_default.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode 
                                          batchNodeWithFile:@"arabicApp_default.png"];
        [self addChild:spriteSheet];
        backgroundImage = [CCSprite spriteWithFile:[letterManager stringForProp:@"backgroundImage"]];
        CGSize size = [[CCDirector sharedDirector] winSize];
        backgroundImage.position = ccp(size.width/2,size.height/2);
        picture =  [CCSprite spriteWithSpriteFrameName:[letterManager stringForProp:@"picture"]];
        picture.position = ccp(size.width/2,size.height/2 + 150 );
		letterLabel.position =  ccp( size.width /2 , size.height/2  + [letterManager numberForProp:@"letterOffset"].intValue);        
        [self addChild:backgroundImage z:0];
        [self addChild:picture];
		[self addChild: letterLabel];
        [self animateTransliteration];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:[letterManager stringForProp:@"sound"]];
        [[SimpleAudioEngine sharedEngine] playEffect:[letterManager stringForProp:@"sound"]];
        currentCharacterSound = [letterManager stringForProp:@"soundFile"];

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
    CGSize size = [[CCDirector sharedDirector] winSize];

    if (location.y > size.height/2 ) {
        id scaleout=[CCScaleBy actionWithDuration:.5f scale:2.0f ];
        id scalein= [CCScaleBy actionWithDuration:.5f scale:.5f ];
        id scalceActions = [CCSequence actions:scaleout,scalein, nil];
        [[SimpleAudioEngine sharedEngine] playEffect:currentCharacterSound];
		[picture runAction:scalceActions];
    }else{
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
}


-(void)updateLetter{
    [self removeChild:backgroundImage cleanup:YES];
    [self removeChild:letterLabel cleanup:YES];
    [self removeChild:translationLabel cleanup:YES];
    [self removeChild:picture cleanup:YES];
    letterLabel = [CCLabelBMFont labelWithString:[letterManager stringForProp:@"letter"] fntFile:@"fullArabicLeters.fnt" ];
    backgroundImage = [CCSprite spriteWithFile:[letterManager stringForProp:@"backgroundImage"]];
    picture =  [CCSprite spriteWithSpriteFrameName:[letterManager stringForProp:@"picture"]];

    CGSize size = [[CCDirector sharedDirector] winSize];
    backgroundImage.position = ccp(size.width/2,size.height/2);

    letterLabel.position =  ccp( size.width /2 , size.height/2  + [letterManager numberForProp:@"letterOffset"].intValue );
    picture.position = ccp(size.width/2,size.height/2 + 150 );

    [self addChild:backgroundImage z:0];
    [self addChild:letterLabel];
    [self animateTransliteration];
    [self addChild:picture];
    currentCharacterSound = [letterManager stringForProp:@"soundFile"];

    [[SimpleAudioEngine sharedEngine] playEffect:[letterManager stringForProp:@"sound"]];
}



-(void)animateTransliteration{
    //clear out and remove any letters
    [self removeChildByTag:1 cleanup:YES];

                                        
    //reset the array
    transliterationLettersLabelArray = nil;
    transliterationLettersLabelArray = [NSMutableArray array];

    //get the next transliteration letter and fade it in after the previous
    NSString *transliterationLetters = [letterManager stringForProp:@"transliteration"];
    CGSize size = [[CCDirector sharedDirector] winSize];
    int xPosition = ((size.width/2 )-30) + [letterManager numberForProp:@"transliterationPosOffsetX"].intValue;
    for (int index = 0 ;index < [transliterationLetters length];index++){
        unichar c = [transliterationLetters characterAtIndex:index];
        NSString *currentCharString = [NSString stringWithFormat: @"%C", c];
        CCLabelBMFont *currentLetter = [CCLabelBMFont labelWithString:currentCharString fntFile:@"sketchit.fnt" ];        
        currentLetter.position = ccp(xPosition,(size.height/2)-250);
        [currentLetter setTag:1];
        [self addChild:currentLetter];
        currentLetter.opacity = 0;
        float timeDelay = .5*index;
        id fadein = [CCFadeIn actionWithDuration:0.5];
        id delayTime = [CCDelayTime actionWithDuration:timeDelay];
        [currentLetter runAction:[CCSequence actions:delayTime,fadein,nil]];
        [transliterationLettersLabelArray addObject:currentLetter];
        xPosition +=75;
    }

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}

@end
