//
//  KSCardViewController.m
//  DeckOfCards
//
//  Created by Madison Kaori Shino on 7/2/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import "KSCardViewController.h"
#import "KSCardController.h"
#import "KSCard.h"

@interface KSCardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardSuitLabel;

@end

@implementation KSCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViews
{
    [KSCardController.sharedController drawANewCard:^(NSArray *cards) {
        if (cards)
        {
            KSCard *card = cards[0];
            [KSCardController.sharedController fetchImageFromCard:card completion:^(UIImage *cardImage) {
                if (cardImage)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.cardSuitLabel.text = card.suit;
                        self.cardImageView.image = cardImage;
                    });
                }
            }];
        }
    }];
}

- (IBAction)buttonTapped:(id)sender {
    [self updateViews];
}


@end
