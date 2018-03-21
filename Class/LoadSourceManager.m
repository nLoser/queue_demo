//
//  LoadSourceManager.m
//  QueueDonwload
//
//  Created by LV on 2018/3/1 - 2014/10/1.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "LoadSourceManager.h"

@implementation LoadSourceManager

- (id)createRuntimeClass {
    Class newClass = objc_allocateClassPair([NSObject class], "LVObject", 0);
    class_addMethod(newClass, @selector(report), (IMP)RepotFuncation, "v@:");
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] init];
    return instance;
}

void RepotFuncation(id self, SEL _cmd) {
    NSLog(@"Class is: %@, Super is: %@",[self class], [self superclass]);
    NSLog(@"This object is: %p", self);
    
    Class currentClass = [self class];
    
    for (int i = 1; i < 10; i ++) {
        NSLog(@"Isa pointer: %d times gives: %p %@", i, currentClass , [NSString stringWithUTF8String:object_getClassName(currentClass)]);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is: %p", [NSObject class]);
    NSLog(@"NSObject's meta class is: %p", object_getClass([NSObject class]));
}

@end
