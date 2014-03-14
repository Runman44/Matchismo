//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/13/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)setHistory:(NSArray *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
        NSString *historyText = @"";
        int i = 1;
        for (NSString *line in self.history) {
            historyText = [NSString stringWithFormat:@"%@%2d: %@\n\n", historyText, i++, line];
        }
        self.historyTextView.text = historyText;
}


@end
