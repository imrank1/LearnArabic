//
//  LetterManager.h
//  LearnArabic
//
//  Created by Imran Khawaja on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LetterManager : NSObject{
    int currentLetterIndex;
    NSDictionary *letterData;
    NSArray *letters;
    NSDictionary *currentLetter;
}
@property int currentLetterIndex;
@property NSDictionary *currentLetter;
-(void)nextLetter;
-(void)previousLetter;
-(NSString *) stringForProp:(NSString *)property;
-(NSNumber *) numberForProp:(NSString *)property;
-(BOOL)hasProp:(NSString *)prop;
@end
