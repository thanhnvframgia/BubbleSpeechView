//
//  BubbleTextView.h
//  BubbleSpeechView
//
//  Created by  on 12/29/13.
//  Copyright © 2013 thanhnv. All rights reserved.
//

#import <UIKit/UIKit.h>



@class BubbleTextView;

@protocol BubbleTextViewDelegate <NSObject>

- (void)bubbleTextViewDidmoved:(BubbleTextView *)textBubbleView;
- (void)bubbleTextViewDidChanged:(BubbleTextView *)textBubbleView;

@end


@interface BubbleTextView : UIView

@property (nonatomic) CGFloat maxWidth;
@property (nonatomic, weak) id<BubbleTextViewDelegate> delegate;

@property (nonatomic) CGFloat x_scale;
@property (nonatomic) CGFloat y_scale;
@property (nonatomic) NSInteger rectPadding;


@end



