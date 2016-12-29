//
//  BubbleTextView.m
//  BubbleSpeechView
//
//  Created by  on 12/29/13.
//  Copyright © 2013 thanhnv. All rights reserved.
//

#import "BubbleTextView.h"
#import "MoveableView.h"

@interface BubbleTextView () <UITextViewDelegate, MoveableViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) MoveableView *foregroundView;
@property (nonatomic) CGFloat padding_x_scale;
@property (nonatomic) CGFloat padding_y_scale;

@end

@implementation BubbleTextView

#pragma mark - movableViewDelegate

- (void)movableViewDidBeginMove:(MoveableView *)movableView {
    [self.textView resignFirstResponder];
}

- (void)movableView:(MoveableView *)movable deltaX:(float)deltaX deltaY:(float)deltaY {
    self.transform = CGAffineTransformTranslate(self.transform, deltaX, deltaY);
    if ([self.delegate respondsToSelector:@selector(bubbleTextViewDidmoved:)]) {
        [self.delegate bubbleTextViewDidmoved:self];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
   
    
    CGSize currentSize = textView.frame.size;
    CGSize textViewTosize = [textView sizeThatFits:CGSizeMake(self.maxWidth, MAXFLOAT)];
    
      
    NSLog(@"%@", NSStringFromCGSize(textViewTosize));
    float deltaWidth = textViewTosize.width - currentSize.width;
    float deltaHeight = textViewTosize.height - currentSize.height;
    
    // bubble update frame
    CGSize currentBubbleSize = self.frame.size;
    CGSize bubbleToSize = CGSizeMake(currentBubbleSize.width+deltaWidth, currentBubbleSize.height+deltaHeight);
    self.frame = (CGRect){.origin=self.frame.origin, .size=bubbleToSize};
    
    // textview update frame
    // set min width
    if (textViewTosize.width < 20) {
        textViewTosize = CGSizeMake(20, textViewTosize.height);
    }
    textView.bounds = (CGRect){.origin=CGPointZero, .size=textViewTosize};
    textView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // foreground view
    self.foregroundView.frame = (CGRect){.origin=CGPointZero, .size=bubbleToSize};
    [self setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(bubbleTextViewDidChanged:)]) {
        [self.delegate bubbleTextViewDidChanged:self];
    }
}

#pragma mark - Handle Action

- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    } else {
        [self.textView becomeFirstResponder];
    }
}

#pragma mark - override

- (CGFloat)x_scale {
    return (self.frame.size.width)/75;
}

- (CGFloat)y_scale {
    return (self.frame.size.height)/50;
}

- (CGFloat)padding_x_scale {
    return (self.frame.size.width-self.rectPadding*2)/75;
}

- (CGFloat)padding_y_scale {
    return (self.frame.size.height-self.rectPadding*2)/50;
}

- (NSInteger)rectPadding {
    return 2;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITextView *textView = [[UITextView alloc] init];
        textView.frame = CGRectMake(0, 0, 20, 30);
        textView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        textView.delegate = self;
        textView.backgroundColor = [UIColor clearColor];
        textView.scrollEnabled = NO;
        textView.textAlignment = NSTextAlignmentCenter;
        textView.font = [UIFont systemFontOfSize:15];
        [self addSubview:textView];
        self.textView = textView;
        
        // foreground view
        MoveableView *foregroundView = [[MoveableView alloc] initWithFrame:(CGRect){.origin=CGPointZero, .size=self.frame.size}];
        foregroundView.delegate = self;
        foregroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:foregroundView];
        self.foregroundView = foregroundView;
        
        // tap action
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.foregroundView addGestureRecognizer:tapGestureRecognizer];
        
        
#ifdef DEBUG
        textView.text = @" Don't let anything drown out your inner voice.";
        self.maxWidth = 120;
        [self textViewDidChange:textView];
#endif
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    CGContextSetLineWidth(context, 1.0);
    UIColor *aColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGRect paddedRect = CGRectMake(rect.origin.x+self.rectPadding, rect.origin.y+self.rectPadding, rect.size.width-self.rectPadding*2, rect.size.height-self.rectPadding*2);
   
            // front
            CGContextAddEllipseInRect(context, paddedRect);
            CGContextDrawPath(context, kCGPathFillStroke);
    
}


@end
