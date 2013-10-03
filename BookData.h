//
//  BookData.h
//  worknow
//
//  Created by MGM on 9/23/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookData : NSObject

@property (nonatomic) int thePageNumber;
@property (nonatomic) int theSentenceNumber;

@property (strong, nonatomic) NSString* theSentence;
@property (strong, nonatomic) NSString* theImageName;

@end
