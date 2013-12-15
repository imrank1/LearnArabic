//
//  AppDelegate.m
//  LearnArabic
//
//  Created by Imran Khawaja on 5/19/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "LetterLayer.h"
#import "MainScreen.h"
#import "RootViewController.h"
//#import "SimpleAudioEngine.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"
#import "Mixpanel.h"

#define MIXPANEL_TOKEN @"4539f7ca183378b3f116f129f2330019"

@implementation AppDelegate

@synthesize window;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
    
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
     Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel identify:mixpanel.distinctId];
    [mixpanel track:@"Opened App Event"];
    [mixpanel.people increment:@"App Opens" by:[NSNumber numberWithInt:1]];
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
    [window setRootViewController:viewController];

	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
    [self preloadSounds];
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [MainScreen scene]];
}


-(void) preloadSounds { 
    //preload letters
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"ain.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"alif.caf"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"alif.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"baa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"characters"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"daad.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"daal.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"dzaal.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"faahOrTha.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"giin.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"haa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"haaa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"jiim.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"kaaf.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"khaa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"laam.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"miim.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"nuun.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"qaaf.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"raa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"saad.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"shiin.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"siin.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"soundgen.rb"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"ta.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"taa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"thaa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"vow.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"yaa.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"za.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"ziin.mp3"];
    
    //characters
    //[[SimpleAudioEngine sharedEngine] preloadEffect:"ana-oneThousand.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"baab-door.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"Dalu-pucket.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"duvdah-frogy.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"ein-eyes.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"film.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"giom-clouds.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"hamaam-pigeon.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"hilal-moon.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"jamal.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"ka-cave.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"khareef-automnTree.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"laimon-lemon.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"miriam.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"nahir-river.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"qadi-judge.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"raeb-thunder.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"sab-hard.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"shaban-calendar.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"sin-tooth.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"soundgen.rb"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"taha-boy.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"thieb-wolf.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"thill-shadow.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"thulut-fox.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"tuut-berries.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"walad-baby.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"yasmeen.mp3"];
//    [[SimpleAudioEngine sharedEngine] preloadEffect:"zarafa-giraffe.mp3"];

}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
