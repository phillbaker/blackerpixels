//
//  blackerpixelsView.m
//  blackerpixels
//
//  Created by phill on 5/2/12.
//  Copyright (c) 2012 Phillip Baker. All rights reserved.
//
//  Released under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//

#import "blackerpixelsView.h"

@implementation blackerpixelsView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        //NSLog(@"blackerpixels");
        if (!isPreview) {
            NSLog(@"blackerpixels - execute");
            origBrightness = [[NSMutableArray alloc] init];
            [self storeBrightness];
            
            NSMutableArray* off = [[NSMutableArray alloc] init];
            for (int i = 0; i < [origBrightness count]; i++) {
                [off addObject:[NSNumber numberWithFloat:0.0f]];
            }
            [self setDisplaysBrightness:off];
            NSLog(@"blackerpixels - turned off");
        }
    }
    return self;
}

- (int) storeBrightness {
    float brightness;
    int kMaxDisplays = 16;
    CFStringRef kDisplayBrightness = CFSTR(kIODisplayBrightnessKey);
    
    CGDirectDisplayID display[kMaxDisplays];
    CGDisplayCount numDisplays;
    CGDisplayErr err;
    err = CGGetActiveDisplayList(kMaxDisplays, display, &numDisplays);
    
    for (CGDisplayCount i = 0; i < numDisplays; ++i) {
        CGDirectDisplayID dspy = display[i];
        CFDictionaryRef originalMode = CGDisplayCurrentMode(dspy);
        if (originalMode == NULL)
            continue;
        io_service_t service = CGDisplayIOServicePort(dspy);
        
        err = IODisplayGetFloatParameter(service, kNilOptions, kDisplayBrightness,
                                         &brightness);
        if (err != kIOReturnSuccess) {
            NSLog(@"blackerpixels - error on getting");
        }
        else {
            NSLog(@"blackerpixels - getting %d at %f", i, brightness);
            [origBrightness addObject:[NSNumber numberWithFloat:brightness]];
        }
    }
    return err;
}

- (int) setDisplaysBrightness:(NSMutableArray*)array {
    int kMaxDisplays = 16;
    //float brightness = 0.0f;
    CFStringRef kDisplayBrightness = CFSTR(kIODisplayBrightnessKey);
    
    CGDirectDisplayID display[kMaxDisplays];
    CGDisplayCount numDisplays;
    CGDisplayErr err;
    err = CGGetActiveDisplayList(kMaxDisplays, display, &numDisplays);
    NSLog(@"blackerpixels - setting");
    for (CGDisplayCount i = 0; i < [array count]; ++i) {
        CGDirectDisplayID dspy = display[i];
        CFDictionaryRef originalMode = CGDisplayCurrentMode(dspy);
        if (originalMode == NULL)
            continue;
        io_service_t service = CGDisplayIOServicePort(dspy);
        float brightness = [[array objectAtIndex:i] floatValue];
        NSLog(@"blackerpixels - setting %d to %f", i, brightness);
        err = IODisplaySetFloatParameter(service, 
                                         kNilOptions, 
                                         kDisplayBrightness, 
                                         brightness);
        if (err != kIOReturnSuccess) {
            //do something
            NSLog(@"blackerpixels - error on setting");
        }
    }
    return err;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
    //reset brightness
    [self setDisplaysBrightness:origBrightness];
    NSLog(@"blackerpixels - turned on");
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
