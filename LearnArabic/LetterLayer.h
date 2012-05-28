//
//  LetterLayer.h
//  LearnArabic
//
//  Created by Imran Khawaja on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "LetterManager.h"

@interface LetterLayer : CCLayer{
    int touchBeganX;
    int touchBeganY;
    int touchEndX, touchEndY;
    LetterManager *letterManager;
    CCLabelBMFont *letterLabel;
    CCLabelBMFont *translationLabel;
    CCSprite    *backgroundImage;
    NSMutableArray *transliterationLettersLabelArray;

}
@property LetterManager *letterManger;
+(CCScene *) scene;
-(void)updateLetter;


@end
