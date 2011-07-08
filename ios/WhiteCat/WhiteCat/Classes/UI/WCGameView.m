//
//  WCGameView.m
//  WhiteCat
//
//  Created by Arman  Uguray on 7/6/11.
//  Copyright 2011 Brown University. All rights reserved.
//

#import "WCGameView.h"
#import <QuartzCore/QuartzCore.h>

/* =============================== WCGameView =============================== */

#define BOARD_DIMENSION 11

@implementation WCGameView

@synthesize gameGraph = gameGraph_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // set background color
        [self setBackgroundColor:[UIColor whiteColor]];
        // disable multiple touches
        self.multipleTouchEnabled = NO;
        
        const CGFloat x_padding = frame.size.width / 50.f;
        const CGFloat cell_dim = (frame.size.width - 7.f * x_padding)/ ((CGFloat)BOARD_DIMENSION + 0.5);
        const CGFloat y_0 = (frame.size.height - cell_dim * BOARD_DIMENSION) / 2.f;
        CGFloat x, y;

        // setup the game board graph
        gameGraph_ = (GameGraphNode *)malloc(BOARD_DIMENSION * BOARD_DIMENSION * sizeof(GameGraphNode));
        int index = 0;
        GameGraphNode *node;
        y = y_0;
        for (int i = 0; i < BOARD_DIMENSION; i++) {
            if (i % 2 == 0) x = x_padding;
            else x = x_padding + cell_dim / 2.f + x_padding / 4.f;
            for (int j = 0; j < BOARD_DIMENSION; j++) {
                node = &gameGraph_[index++];
                node->blocked_ = NO;
                // if even numbered row
                if (i % 2 == 0) {
                    /* set nw and ne */
                    // if top row
                    if (i == 0) {
                        node->nw = node->ne = NULL;
                    } else {
                        node->ne = &gameGraph_[index - BOARD_DIMENSION];
                        // if left column
                        if (j == 0) node->nw = NULL;
                        else node->nw = &gameGraph_[index - BOARD_DIMENSION - 1];
                    }
                    
                    /* set sw and se */
                    // if bottom row
                    if (i == BOARD_DIMENSION - 1) {
                        node->sw = node->se = NULL;
                    } else {
                        node->se = &gameGraph_[index + BOARD_DIMENSION];
                        // if left column
                        if (j == 0) node->sw = NULL;
                        else node->sw = &gameGraph_[index + BOARD_DIMENSION - 1];
                    }
                    
                    /* set ww */
                    // if left column
                    if (j == 0) node->ww = NULL;
                    else node->ww = &gameGraph_[index - 1];
                    
                    /* set ee */
                    // if right column
                    if (j == BOARD_DIMENSION - 1) node->ee = NULL;
                    else node->ee = &gameGraph_[index + 1];
                }
                // if odd numbered row
                else {
                    /* set nw and ne */
                    node->nw = &gameGraph_[index - BOARD_DIMENSION];
                    // if right column
                    if (j == BOARD_DIMENSION - 1) node->ne = NULL;
                    else node->ne = &gameGraph_[index - BOARD_DIMENSION + 1];
                    
                    /* set sw and se */
                    // if bottom row
                    if (i == BOARD_DIMENSION - 1) node->sw = node->se = NULL;
                    else {
                        node->sw = &gameGraph_[index + BOARD_DIMENSION];
                        // if right column
                        if (j == BOARD_DIMENSION - 1) node->se = NULL;
                        else node->se = &gameGraph_[index + BOARD_DIMENSION + 1];
                    }

                    /* set ww */
                    // if left column
                    if (j == 0) node->ww = NULL;
                    else node->ww = &gameGraph_[index - 1];

                    /* set ee */
                    // if right column
                    if (j == BOARD_DIMENSION - 1) node->ee = NULL;
                    else node->ee = &gameGraph_[index + 1];
                }
                [self addSubview:[[[WCGameViewCell alloc] initWithFrame:CGRectMake(x, y, cell_dim, cell_dim)
                                                                andNode:node] autorelease]];
                x += cell_dim + 0.5f * x_padding;
            }
            y += cell_dim;
        }
    }
    return self;
}

- (void)dealloc
{
    free(gameGraph_);
    [super dealloc];
}

@end

/* =============================== WCGameViewCell =============================== */

@implementation WCGameViewCell

- (id)initWithFrame:(CGRect)frame andNode:(GameGraphNode *)cellNode 
{
    if ((self = [super initWithFrame:frame])) {
        cellNode_ = cellNode;
        cellNode_->gameCell_ = self;
        
        // set background color to white
        [self setBackgroundColor:[UIColor whiteColor]];
        
        // start listening for single tap gestures
        UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                         action:@selector(cellTapped:)];
        [self addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer release];
    }
    return self;
}

- (void)cellTapped:(UITapGestureRecognizer *)recognizer 
{
    cellNode_->blocked_ = YES;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect 
{
    UIColor *cellColor; 
    if (cellNode_->blocked_) cellColor = [UIColor colorWithRed:0.447f green:0.522f blue:0.004f alpha:1.f];
    else cellColor = [UIColor colorWithRed:0.8f green:1.f blue:0.f alpha:1.f];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, cellColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
}

@end
