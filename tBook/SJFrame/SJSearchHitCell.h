//
//  SJSearchHitCell.h
//  tBook
//
//  Created by 陈少杰 on 15/9/19.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "SJCell.h"
#import "SJBook.h"

@interface SJSearchHitCell : SJCell
@property(nonatomic,readonly)UILabel *bookNameLabel;
@property(nonatomic,readonly)UIView *lineView;
+(CGFloat)cellHeight;
-(void)loadBook:(SJBook *)book;
@end
