//
//  KSCardController.h
//  DeckOfCards
//
//  Created by Madison Kaori Shino on 7/2/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KSCard;

@interface KSCardController : NSObject

+ (KSCardController *)sharedController;

- (void)drawANewCard:(void (^)(NSArray *))completion;

- (void)fetchImageFromCard:(KSCard *)card completion:(void (^) (UIImage *))completion;

@end

