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
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        backgroundImage = [CCSprite spriteWithFile:@"cork.jpg"];
        titleLabel = [CCLabelBMFont labelWithString:@"Arabic!" fntFile:@"sketchit.fnt" ];
        CGSize size = [[CCDirector sharedDirector] winSize];
        backgroundImage.position = ccp(size.width/2,size.height/2);
        [self addChild:backgroundImage z:0];
        titleLabel.visible = YES;
		titleLabel.position =  ccp( size.width/2 , size.height/2 );        
		[self addChild: titleLabel z:1];
        
        CCLabelBMFont *startLetterLabel = [CCLabelBMFont labelWithString:@"Letters" fntFile:@"sketchit.fnt"];
		CCMenuItemLabel *menuItem = [CCMenuItemLabel itemWithLabel:startLetterLabel target:self selector:@selector(startLetters:)];
        CCMenu *menu = [CCMenu menuWithItems: menuItem, nil];
        menu.position = ccp(size.width/2,size.height/2-200);
		[menu alignItemsVertically];
        [self addChild:menu];   
	}   
	return self;
}

-(void) startLetters:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[LetterLayer scene]];
}
@end
