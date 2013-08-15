//
//  MainScreen.m
//  LearnArabic
//
//  Created by Imran Khawaja on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "LetterLayer.h"

@implementation MainScreen


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScreen *layer = [MainScreen node];
	layer.isTouchEnabled = TRUE;
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{

	if( (self=[super init])) {
        backgroundImage = [CCSprite spriteWithFile:@"arabicAppInitialScreen.png"];
        CGSize size = [[CCDirector sharedDirector] winSize];
        backgroundImage.position = ccp(size.width/2,size.height/2);
        [self addChild:backgroundImage z:0];
        titleLabel.visible = YES;
		titleLabel.position =  ccp( size.width/2 , size.height/2 );        

	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[[CCDirector sharedDirector] replaceScene:[LetterLayer scene]];

}

@end
