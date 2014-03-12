//
//  SetCard.h
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSString *suit;

+ (NSArray *)validSuits;

@end
