// NSPropertyDescription+Groot.m
//
// Copyright (c) 2014-2016 Guillermo Gonzalez
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSPropertyDescription+Groot.h"

@implementation NSPropertyDescription (Groot)

- (nullable NSString *)grt_JSONKeyPath {
    
    if (self.userInfo[@"JSONKeyPath"]) {
        return self.userInfo[@"JSONKeyPath"];
    }
    
    return [self name];
}

- (BOOL)grt_JSONSerializable {
    return [self grt_JSONKeyPath] != nil;
}

- (nullable id)grt_rawValueInJSONDictionary:(NSDictionary * __nonnull)dictionary {
    NSString *keyPath = [self grt_JSONKeyPath];
    
    if (keyPath != nil) {
        //Try to split key path with '.'
        NSArray *splitKeyPathWithDot = [keyPath componentsSeparatedByString:@"."];
        //If only one item then that is our key
        if ([splitKeyPathWithDot count] == 1) {
            return [dictionary valueForKeyPath:keyPath];
        } else {
            //We have item similar to "links.users"
            id object;
            NSDictionary *tempDict;
            //Iterate through each key in array
            for (NSString *key in splitKeyPathWithDot) {
                //if dictionary exists lets keep for next iteration
                if ([dictionary[key] isKindOfClass:[NSDictionary class]]) {
                    tempDict = dictionary[key];
                }
                //Try to get the object if it exists
                object = tempDict ? tempDict[key] : nil;                
            }            
            return object;
        }
        
    }
    
    return nil;
}

@end