//
//  SJSearchBookCell.h
//  tBook
//
//  Created by 陈少杰 on 15/2/9.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJBook.h"
#import <EGOImageView.h>

@interface SJSearchBookCell : SJCell
@property(nonatomic,readonly)EGOImageView *bookCoverImageView;
@property(nonatomic,readonly)UILabel *bookTitleLabel;
@property(nonatomic,readonly)UILabel *bookAuthorLabel;
@property(nonatomic,readonly)UILabel *bookLastUpdateDateLabel;
@property(nonatomic,readonly)UILabel *bookDescLabel;
@property(nonatomic,readonly)UIView *lineView;


-(void)loadBook:(SJBook*)book;

+(CGFloat)cellHeightWithBook:(SJBook*)book;
@end
