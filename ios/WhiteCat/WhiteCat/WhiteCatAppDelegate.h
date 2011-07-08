//
//  WhiteCatAppDelegate.h
//  WhiteCat
//
//  Created by Arman Uguray on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCGameViewController;

@interface WhiteCatAppDelegate : UIResponder <UIApplicationDelegate> {
    
    WCGameViewController *gameViewController_;
}

@property (strong, nonatomic) UIWindow *window;

@end
