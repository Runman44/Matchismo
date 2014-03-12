//
//  SetCard.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents
{
    return nil;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits{
    return @[@"▲",@"◼︎",@"●"];
}

- (void)setSuit:(NSString *)suit{
    if ([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableSet *setSuit = [[NSMutableSet alloc]initWithObjects:self.suit, nil];

    
    for (SetCard *otherCard in otherCards){
        [setSuit addObject:otherCard.suit];
    }
    if ([setSuit count] != [otherCards count] +1){
        score = 1;
    }

    return score;
}


@end
