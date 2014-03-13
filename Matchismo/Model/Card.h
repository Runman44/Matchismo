//
//  Card.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic) NSString *contents;
@property(nonatomic, getter = isChosen) BOOL chosen;
@property(nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic) NSUInteger numberOfMatchingCards;

- (int)match:(NSArray *)otherCards;


@end
