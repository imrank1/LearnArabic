
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
    NSLog(@"letters count is %d",letters.count);
    NSLog(@"next letter");
    currentLetterIndex++;
    if(currentLetterIndex >= letters.count){
        currentLetterIndex=0;
    }
    currentLetter = [letters objectAtIndex:currentLetterIndex];
    NSLog(@"Current letter is %@",[currentLetter objectForKey:@"letter"]);
}

-(void)previousLetter{
    NSLog(@"previous letter");
    currentLetterIndex--;
    if(currentLetterIndex <= 0 ){
        currentLetterIndex = 0;
    }
    currentLetter = [letters objectAtIndex:currentLetterIndex];
    NSLog(@"Current letter is %@",[currentLetter objectForKey:@"letter"]);
}


-(NSString *) stringForProp:(NSString *)property{
    return [currentLetter objectForKey:@"letter"];
}





@end
