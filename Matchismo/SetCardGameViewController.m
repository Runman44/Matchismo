//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    
    return [[SetCardDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfStartingCards = 12;
}




@end
