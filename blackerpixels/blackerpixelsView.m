//
//  blackerpixelsView.m
//  blackerpixels
//
//  Created by phill on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "blackerpixelsView.h"

@implementation blackerpixelsView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        if (! isPreview) {
            NSLog(@"blackerpixels");
            //[self dimDisplayNow];
            [self turnOffDisplayNow];
        }
    }
    return self;
}

- (int) turnOffDisplayNow {
    int kMaxDisplays = 16;
    float brightness = 0.0f;
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

                err = IODisplaySetFloatParameter(service, kNilOptions, kDisplayBrightness,
                                                 brightness);
                if (err != kIOReturnSuccess) {
                    //do something
                    NSLog(@"blackerpixels - error on setting");
                }
    }
    return err;
}

- (int) dimDisplayNow {
    io_registry_entry_t reg = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
    if (reg) {
        IORegistryEntrySetCFProperty(reg, CFSTR("IORequestIdle"), kCFBooleanTrue);
        IOObjectRelease(reg);
    } else {
        return 1;
    }
    return 0;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
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
