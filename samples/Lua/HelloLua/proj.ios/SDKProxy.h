//
//  SDKProxy.h
//  HelloLua
//
//  Created by madgenic on 2017/6/23.
//
//

#import <Foundation/Foundation.h>

//定义定位的距离范围（可以手动修改）
#define DISTANCE_RANGE 100

typedef int (^BlockResult) (BOOL);
typedef int (^BlockLocation) (float,float);
@interface SDKProxy : NSObject
{
    NSString*lati;//精度
    NSString*longit;//维度
}

/*
 回调是否在100米范围内结果
 */
@property(nonatomic,copy)BlockResult blockResult;
/*
 回调经纬度
 */
@property(nonatomic,copy)BlockLocation blockLocation;
/*
 单例获取对象方法
 */
+(instancetype) sharedInstance;
/*
 开始定位
 */
-(void)startLocation;
@end
