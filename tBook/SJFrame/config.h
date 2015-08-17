//
//  config.h
//  Gobang
//
//  Created by 陈少杰 on 14/6/27.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#ifndef Gobang_config_h
#define Gobang_config_h

#define GAME_ICE_TYPE_COUNT 6
#define GAME_ROW_COUNT 9
#define GAME_COL_COUNT 9
#define GAME_BLOCK_WIDTH 35

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define ADS_APPKEY @"e95e1316ddee452ba8de39aa5ec6ca8e"
#define YUNFEI_APPID @"appid=5477dbc5"

struct SJCoordinate{
     int row;
     int col;
};
typedef struct SJCoordinate SJCoordinate;

#define SJCoordinateMake(row,col) (SJCoordinate){row,col}
#define SJCoordinateZero SJCoordinateMake(-1,-1)
#define SJCoordinateIsEquare(A,B) (A.row==B.row&&A.col==B.col)
#define SJCoordinateCanLink(A,B) ((ABS((int)A.row-(int)B.row)<=1)&&(ABS((int)A.col-(int)B.col)<=1))
#define SJCoordinateToPoint(coordinate) CGPointMake(coordinate.row,coordinate.col)
#define CGPointToCoordinate(point) SJCoordinateMake(point.x,point.y)
#define FOREACH_DATA(A) for (int row=0; row<GAME_ROW_COUNT; row++) {for (int col=0; col<GAME_COL_COUNT;col++) {A}};
#endif
