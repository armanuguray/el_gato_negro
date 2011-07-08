//
//  WCGameView.h
//  WhiteCat
//
//  Created by Arman  Uguray on 7/6/11.
//  Copyright 2011 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

/* =============================== GameGraphNode =============================== */

@class WCGameViewCell;

typedef struct GameGraphNode {
    BOOL blocked_;
    WCGameViewCell *gameCell_;
    union {
        struct GameGraphNode *nw, *ne, *ee, *se, *sw, *ww;
        struct GameGraphNode *nodes[6];
    };
} GameGraphNode;

/* =============================== WCGameView =============================== */

@interface WCGameView : UIView

@property (nonatomic, readonly) GameGraphNode *gameGraph;

@end

/* =============================== WCGameViewCell =============================== */

@interface WCGameViewCell : UIView {
@private
    GameGraphNode *cellNode_;
}

- (id)initWithFrame:(CGRect)frame andNode:(GameGraphNode *)cellNode;

@end
