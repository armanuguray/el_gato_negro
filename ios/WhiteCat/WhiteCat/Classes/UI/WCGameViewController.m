//
//  WCGameViewController.m
//  WhiteCat
//
//  Created by Arman Uguray on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WCGameViewController.h"

@implementation WCGameViewController

- (id)init {
    if ((self = [super init])) {
        gameView_ = [[WCGameView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self.view addSubview:gameView_];
}

- (void)viewDidUnload 
{
    [gameView_ removeFromSuperview];
    [super viewDidUnload];
}

- (void)dealloc 
{
    [gameView_ release];
    [super dealloc];
}

@end