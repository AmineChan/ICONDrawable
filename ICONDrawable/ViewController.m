//
//  ViewController.m
//  ICONDrawable
//
//  Created by czm on 2017/1/6.
//  Copyright © 2017年 taide. All rights reserved.
//

#import "ViewController.h"
#import "Drawable4iOSViewController.h"
#import "Drawable4AndroidViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)onIOSBtnClick:(id)sender {
    Drawable4iOSViewController *vc = [[Drawable4iOSViewController alloc] initWithNibName:@"Drawable4iOSViewController" bundle:nil];
    [self presentViewControllerAsModalWindow:vc];
}

- (IBAction)onAndroidBtnClick:(id)sender {
    Drawable4AndroidViewController *vc = [[Drawable4AndroidViewController alloc] initWithNibName:@"Drawable4AndroidViewController" bundle:nil];
    [self presentViewControllerAsModalWindow:vc];
}

@end
