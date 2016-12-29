//
//  MoveableView.h
//  BubbleSpeechView
//
//  Created by  on 12/29/13.
//  Copyright © 2013 thanhnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoveableView;

@protocol MoveableViewDelegate <NSObject>

@optional
- (void)movableViewDidBeginMove:(MoveableView *)movableView;
- (void)movableView:(MoveableView *)movableView deltaX:(float)deltaX deltaY:(float)deltaY;

@end

@interface MoveableView : UIView

@property (weak, nonatomic) id<MoveableViewDelegate> delegate;

@end
