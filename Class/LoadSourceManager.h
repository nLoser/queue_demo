//
//  LoadSourceManager.h
//  QueueDonwload
//
//  Created by LV on 2018/3/1.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#if DEBUG
#define NSLog(format, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#endif

@interface LoadSourceManager : NSObject

- (id)createRuntimeClass;

@end
