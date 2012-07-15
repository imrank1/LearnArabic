
#import "LetterManager.h"

@implementation LetterManager
-(id) init {
    if((self = [super init])){
        NSString *letterFile  = 
        [[NSBundle mainBundle] pathForResource:@"Letters" ofType:@"plist"];
        
        letterData  = [[NSDictionary dictionaryWithContentsOfFile:letterFile]retain];
        letters = (NSArray *) [letterData objectForKey:@"Scenes"];
        currentLetterIndex = 0 ;
        currentLetter = [letters objectAtIndex:currentLetterIndex];
    }
    return self;
}



-(void)nextLetter{
    currentLetterIndex++;
    if(currentLetterIndex >= letters.count){
        currentLetterIndex=0;
    }
    currentLetter = [letters objectAtIndex:currentLetterIndex];
}

-(void)previousLetter{
    currentLetterIndex--;
    if(currentLetterIndex <= 0 ){
        currentLetterIndex = 0;
    }
    currentLetter = [letters objectAtIndex:currentLetterIndex];
}


-(NSString *) stringForProp:(NSString *)property{
    return [currentLetter objectForKey:property];
}


-(NSNumber *) numberForProp:(NSString *)property {
    return [currentLetter objectForKey:property];
}




@end
