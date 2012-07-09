//
//  MainScreen.h
//  LearnArabic
//
//  Created by Imran Khawaja on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MainScreen : CCLayer{
    CCSprite    *backgroundImage;
//    CCLabelBMFont *titleLabel;
    CCLabelTTF *titleLabel;
}
+(CCScene *) scene;

@end
