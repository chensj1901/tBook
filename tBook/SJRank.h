//
//  SJRank.h
//  tBook
//
//  Created by 陈少杰 on 15/3/31.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SJQidianType) {
    SJQidianTypeMonthRank=0, /**< 起点月票榜 */
    SJQidianTypeClickRank=2, /**< 起点点击榜 */
    SJQidianTypeRecommendRank=3, /**< 起点推荐榜 */
    SJQidianTypeNewBookMonthRank=50, /**< 起点新书月票榜 */
    SJQidianTypeGirlMonthRank=10, /**< 起点粉红月票榜 */
    SJQidianTypeGirlClickRank=8, /**< 起点女生点击榜 */
    SJQidianTypeGirlRecommendRank=9 /**< 起点女生推荐榜 */
    
};

@interface SJRank : NSObject
@property(nonatomic)NSString *rankName;
@property(nonatomic)SJQidianType rankType;
@property(nonatomic)NSString *rankImageName;

+(SJRank*)rankWithName:(NSString *)rankName type:(SJQidianType)type rankImageName:(NSString *)rankImageName;
@end
