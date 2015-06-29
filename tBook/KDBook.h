

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
typedef void(^KDSuccessBlock)(void);

@protocol KDBookDelegate

- (void)firstPage:(NSString *)pageString;
//遍历完文档后
- (void)bookDidRead:(NSUInteger)size;
@end


@interface KDBook : NSObject {
	CGSize     pageSize; //页面大小（与分页有关）
	UIFont    *textFont; //字体大小（与分页有关）
    NSInteger bookIndex;
    NSInteger bookPageIndex;
    NSString  *bookName; //需要把所有文件合并在一起
//	NSMutableArray   *_pageIndexArray; //保存每页的下标（文件的偏移量-分页）
	NSThread  *thread;
	
	unsigned long long bookSize;
    
    KDSuccessBlock _success;
}

@property (nonatomic) NSString *bookChapterName;
@property (nonatomic) NSString  *bookPath;
@property (nonatomic) UIFont    *textFont;
@property (nonatomic) CGSize     pageSize;
@property (nonatomic) NSMutableArray *pageIndexArray;
@property (nonatomic,weak) id<KDBookDelegate>  delegate;
@property (nonatomic, readonly) unsigned long long bookSize;
@property (nonatomic,readonly)NSUInteger pageTotal;
@property(nonatomic)BOOL isLoading;

//返回指定页的字符串；
- (NSString *)stringWithPage:(NSUInteger)pageIndex;
- (unsigned long long)offsetWithPage:(NSUInteger)pageIndex;
- (id)initWithBook:(NSString*) bookPath successBlock:(KDSuccessBlock)successBlock;
- (void) createBook;

@end
