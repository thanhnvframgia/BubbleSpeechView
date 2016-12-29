//
//  DynamicBubble.m
//  BubbleSpeechView
//
//  Created by  on 12/29/13.
//  Copyright © 2013 thanhnv. All rights reserved.
//

#import "DynamicBubble.h"

@interface DynamicBubble()<BubbleTextViewDelegate>
@property (nonatomic) CGPoint targetPoint;
@property (nonatomic) CGPoint textBubbleViewCenterPoint;

@end

@implementation DynamicBubble

#pragma mark - bubbleTextView

- (void)bubbleTextViewDidmoved:(BubbleTextView *)textBubbleView {
    self.textBubbleViewCenterPoint = CGPointMake(CGRectGetMidX(textBubbleView.frame), CGRectGetMidY(textBubbleView.frame));
    [self setNeedsDisplay];
    
    
#ifdef DEBUG
    NSLog(@"textBubbleViewCenterPoint %@", NSStringFromCGPoint(self.textBubbleViewCenterPoint));
#endif
}

- (void)bubbleTextViewDidChanged:(BubbleTextView *)textBubbleView {
    self.textBubbleViewCenterPoint = CGPointMake(CGRectGetMidX(textBubbleView.frame), CGRectGetMidY(textBubbleView.frame));
    [self setNeedsDisplay];
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        BubbleTextView *bubbleTextView = [[BubbleTextView alloc] initWithFrame:CGRectMake(0, 0, 85, 60)];
        bubbleTextView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        bubbleTextView.backgroundColor = [UIColor clearColor];
        bubbleTextView.maxWidth = 100;
        bubbleTextView.delegate = self;
        [self addSubview:bubbleTextView];
        self.bubbleTextView = bubbleTextView;
        
        self.textBubbleViewCenterPoint = self.bubbleTextView.center;
        self.targetPoint = self.center;
        self.backgroundColor = [UIColor clearColor];
        
    

    }
    return self;
}

#pragma mark - override

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *tmpView = [super hitTest:point withEvent:event];
    if (tmpView == self) {
        return nil;
    }
    return tmpView;
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [self.bubbleTextView setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
    float x1 = self.targetPoint.x;
    float y1 = self.targetPoint.y;
    float x2 = self.textBubbleViewCenterPoint.x;
    float y2 = self.textBubbleViewCenterPoint.y;
    float k, b;
    if ((x2-x1)==0) {
        k=0;
        b=x1;
    } else {
        k = (y2-y1)/(x2-x1);
        b = y1-(y2-y1)*x1/(x2-x1);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,0,0,0,1.0);
    CGContextSetLineWidth(context, 2.0);
    UIColor *aColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    if (_isBoderDashed) {
        CGFloat ra[] = {4,2};
        CGContextSetLineDash(context, 0.0, ra, 2);
    }
    
    
    CGContextAddEllipseInRect(context, self.bubbleTextView.frame);
    CGContextDrawPath(context, kCGPathFillStroke);

    int c = 10;
    float x3, x4, y3, y4;
    float _k = sqrt(pow((x1-x2), 2) + pow((y1-y2), 2));
    
    if ((x1-x2)*(y1-y2)>0) {
        x3 = MIN((x2+c*(y2-y1)/_k), (x2-c*(y2-y1)/_k));
        x4 = MAX((x2+c*(y2-y1)/_k), (x2-c*(y2-y1)/_k));
        y3 = MAX((y2+c*(x2-x1)/_k), (y2-c*(x2-x1)/_k));
        y4 = MIN((y2+c*(x2-x1)/_k), (y2-c*(x2-x1)/_k));
    } else if ((x1-x2)*(y1-y2) < 0) {
        x3 = MAX((x2+c*(y2-y1)/_k), (x2-c*(y2-y1)/_k));
        x4 = MIN((x2+c*(y2-y1)/_k), (x2-c*(y2-y1)/_k));
        y3 = MAX((y2+c*(x2-x1)/_k), (y2-c*(x2-x1)/_k));
        y4 = MIN((y2+c*(x2-x1)/_k), (y2-c*(x2-x1)/_k));
    } else {
        x3 = x2-c;
        x4 = x2+c;
        y3 = y2;
        y4 = y2;
    }
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x1, y1);
    CGContextAddLineToPoint(context, x3, y3);
    CGContextAddLineToPoint(context, x4, y4);
    CGContextAddLineToPoint(context, x1, y1);
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end






