//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
- (Deck *)createDeck; //abstract
    
@end
