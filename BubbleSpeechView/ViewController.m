//
//  ViewController.m
//  BubbleSpeechView
//
//  Created by  on 12/29/16.
//  Copyright © 2016 thanhnv. All rights reserved.
//

#import "ViewController.h"
#import "DynamicBubble.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DynamicBubble *_bb = [[DynamicBubble alloc] initWithFrame:self.view.bounds];
    _bb.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.f];
    _bb.bubbleTextView.maxWidth = 120;
    
    [self.view addSubview:_bb];
    [_bb setTranslatesAutoresizingMaskIntoConstraints:NO];
    // align _bb from the left and right
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bb]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bb)]];
    // align _bb from the top and bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bb]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bb)]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
