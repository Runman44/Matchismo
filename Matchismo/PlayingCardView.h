//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Dennis Anderson on 3/22/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceup;

@end
