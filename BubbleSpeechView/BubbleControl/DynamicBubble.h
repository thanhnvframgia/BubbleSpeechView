//
//  DynamicBubble.h
//  BubbleSpeechView
//
//  Created by  on 12/29/13.
//  Copyright © 2013 thanhnv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleTextView.h"

@interface DynamicBubble : UIView

@property (nonatomic, setter=setBoderDash:) BOOL isBoderDashed;
@property (nonatomic, strong) BubbleTextView *bubbleTextView;

@end
