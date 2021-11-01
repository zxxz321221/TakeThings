//
//  NSArray+beyond.m
//  TakeThings-iOS
//
//  Created by 桂在明 on 2019/9/29.
//  Copyright © 2019 GUIZM. All rights reserved.
//

#import "NSArray+beyond.h"

@implementation NSArray (beyond)

+ (void)load{

    [super load];

    //  替换不可变数组中的方法

    Method oldObjectAtIndex =class_getInstanceMethod(objc_getClass("__NSArrayI"),@selector(objectAtIndex:));

    Method newObjectAtIndex =class_getInstanceMethod(objc_getClass("__NSArrayI"),@selector(__nickyTsui__objectAtIndex:));

    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);

    //  替换可变数组中的方法

    Method oldMutableObjectAtIndex =class_getInstanceMethod(objc_getClass("__NSArrayM"),@selector(objectAtIndex:));

    Method newMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"),@selector(mutableObjectAtIndex:));

    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
}
- (id)__nickyTsui__objectAtIndex:(NSUInteger)index{

    if (index >self.count -1 || !self.count){

        @try {

            return [self __nickyTsui__objectAtIndex:index];

        } @catch (NSException *exception) {

            //__throwOutException  抛出异常

            NSLog(@"数组越界...");

            return nil;

        } @finally {

        }

    }else{

        return [self __nickyTsui__objectAtIndex:index];

    }
    
}



- (id)mutableObjectAtIndex:(NSUInteger)index{

    if (index >self.count -1 || !self.count){

        @try {

            return [self mutableObjectAtIndex:index];

        } @catch (NSException *exception) {

            //__throwOutException  抛出异常

            NSLog(@"数组越界...");

            return nil;

        } @finally {

        
        }

    }else{

        return [self mutableObjectAtIndex:index];

    }
    
}
@end
