//
//  KDBook.m
//  Gether
//
//  Created by lucky on 12-8-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "KDBook.h"
#import <EGOCache.h>

@implementation KDBook
@synthesize bookPath=_bookPath;
@synthesize textFont;
@synthesize pageSize;
@synthesize delegate;
@synthesize bookSize;

- (NSString *)filePath:(NSString *)fileName{
	if (fileName == nil) {
		return nil;
	}

	return fileName;
}

- (NSFileHandle *)handleWithFile:(NSString *)fileName {
    if (fileName == nil) {
		//  print : wrong file name;
		return nil;
	}
	NSString *path = [self filePath:fileName];
	if (path == nil) {
		//  print : can not find the file
		return nil;
	}
	return [NSFileHandle fileHandleForReadingAtPath:path];	
}

- (unsigned long long)fileLengthWithFile:(NSString *)fileName{
	if (fileName == nil) {
		return (0);
	}
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self filePath:fileName];
	NSError *error;
	NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:&error];
	if (!fileAttributes) {
		NSLog(@"%@",error);
		return (0);
	}
	return [[fileAttributes objectForKey:NSFileSize] unsignedLongLongValue];
}


//偏移量调整（防止英文字符 一个单词被分开）
- (unsigned long long)fixOffserWith:(NSFileHandle *)handle{
	unsigned long long offset = [handle offsetInFile];
	if (offset == 0) {
		return (0);
	}
	NSData *oData = [handle readDataOfLength:1];
	if (oData) {
		NSString *jStr = [[NSString alloc]initWithData:oData encoding:NSUTF8StringEncoding];
		if (jStr) {
			char *oCh = (char *)[oData bytes];
			while  ((*oCh >= 65 && *oCh <= 90) || (*oCh >= 97 && *oCh <= 122)) {								
				[handle seekToFileOffset:--offset];									
				NSData *jData = [handle readDataOfLength:1];
				NSString *kStr = [[NSString alloc]initWithData:jData encoding:NSUTF8StringEncoding];
				if (kStr == nil || offset == 0) {
					break;
				}
				oCh = (char *)[jData bytes];								
			}
			offset++;								
		}
	}
	return offset;
}

- (void)showFirstPage{
	if (delegate && [(NSObject *)delegate respondsToSelector:@selector(firstPage:)]) {
		NSFileHandle *handle = [self handleWithFile:self.bookPath];
		NSData *data = [handle readDataOfLength:[[_pageIndexArray objectAtIndex:0] unsignedLongLongValue]];
		NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		if (string) {
			[delegate firstPage:string];
		}	
	}
}

- (void)bookDidRead:(NSUInteger)size{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLoading=NO;
        
        if (delegate && [(NSObject *)delegate respondsToSelector:@selector(bookDidRead:)]) {
            [delegate bookDidRead:size];
        }
        
        if (_success) {
            _success();
            _success=nil;
        }
    });
}

-(NSUInteger)pageTotal{
    return [_pageIndexArray count];
}

- (unsigned long long)indexOfPage:(NSFileHandle *)handle textFont:(UIFont *)font{
	unsigned long long offset = [handle offsetInFile];
	unsigned long long fileSize = bookSize;
	NSUInteger MaxWidth = pageSize.width, MaxHeigth = pageSize.height;
	
	BOOL isEndOfFile = NO;
	NSUInteger length = 400;
	NSMutableString *labelStr = [[NSMutableString alloc] init];	
	do{		
        for (int j=0; j<3; j++) {
            if ((offset+length+j) > fileSize&&offset<fileSize) {
                length=(NSUInteger)(fileSize-offset+j);
            }else if ((offset+length+j) > fileSize) {
				offset = fileSize;
				isEndOfFile = YES;
				break ;
			}
			[handle seekToFileOffset:offset];
			NSData *data = [handle readDataOfLength:j+length];
			if (data) {
				NSString *iStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
				if (iStr ) {					
					NSString *oStr = [NSString stringWithFormat:@"%@%@",labelStr,iStr];
					
					CGSize labelSize=[oStr sizeWithFont:font
									  constrainedToSize:CGSizeMake(MaxWidth,1000) 
										  lineBreakMode:NSLineBreakByWordWrapping];
//                    NSLog(@"%f",labelSize.height);
					if (labelSize.height-MaxHeigth > 0 && length != 1) {
//						if (length <= 5) {
//							length = 1;
//						}else {
							length = length/(2);
//						}
					}else if (labelSize.height > MaxHeigth && length == 1) {
						offset = [handle offsetInFile]-length-j;
						[handle seekToFileOffset:offset];						
						offset = [self fixOffserWith:handle];
						isEndOfFile = YES;
					}else if(labelSize.height <= MaxHeigth ) {
						[labelStr appendString:iStr];
						offset = j+length+offset;
					}
					break ;
				}
			}
		}
		if (offset >= fileSize) {
			isEndOfFile = YES;
		}		
	}while (!isEndOfFile);
	//NSLog(@"offset :%d",offset);
	return offset;
}


#pragma mark lll

- (NSString *)stringWithPage:(NSUInteger)pageIndex{
	if (pageIndex > [_pageIndexArray count]) {
		return nil;
	}
	NSFileHandle *handle = [self handleWithFile:self.bookPath];
	unsigned long long offset = 0;
	if (pageIndex > 0) {
		offset = [[_pageIndexArray objectAtIndex:pageIndex-1]unsignedLongLongValue];
	}
	[handle seekToFileOffset:offset];
	unsigned long long length = [[_pageIndexArray objectAtIndex:pageIndex]unsignedLongLongValue]-offset;
	NSData *data  = [handle readDataOfLength:length];
	NSString *labelText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	if (labelText == nil) {
		return nil;
	}
//    NSLog(@"%@",labelText);
    return labelText;
}

- (unsigned long long)offsetWithPage:(NSUInteger)pageIndex
{
    if (pageIndex > [_pageIndexArray count]) {
		return 0;
	}

	unsigned long long offset = 0;
	if (pageIndex > 1) {
		offset = [[_pageIndexArray objectAtIndex:pageIndex-2]unsignedLongLongValue];
	}

    return offset;
}

- (void)bookIndex{
    @autoreleasepool {
        NSString *pageIndexCachePath=[NSString stringWithFormat:@"pic-%@",[self.bookPath md5Encode]];
        
        
            
            NSFileHandle *handle = [self handleWithFile:self.bookPath];
            
            NSUInteger count = [_pageIndexArray count];
            unsigned long long index = [[_pageIndexArray objectAtIndex:count-1] unsignedLongLongValue];
            
            while (index <bookSize) {
                [handle seekToFileOffset:index];
                index = [self indexOfPage:handle textFont:textFont];
                [_pageIndexArray addObject:[NSNumber numberWithUnsignedLongLong:index]];
                //NSLog(@"--index:%d",index);
            }
            
            [[EGOCache globalCache]setObject:_pageIndexArray forKey:pageIndexCachePath];
            
            [self bookDidRead:[_pageIndexArray count]];
    }
}


- (void)pageAr{
	if (![self.bookPath isKindOfClass:[NSString class]]||self.bookPath.length==0) {
		return ;
    }
    NSString *pageIndexCachePath=[NSString stringWithFormat:@"pic-%@",[self.bookPath md5Encode]];
    
	_pageIndexArray = [[NSMutableArray alloc] init];
    
    if ([[EGOCache globalCache]hasCacheForKey:pageIndexCachePath]) {
        [_pageIndexArray addObjectsFromArray:(NSArray*)[[EGOCache globalCache]objectForKey:pageIndexCachePath]];
        [self bookDidRead:[_pageIndexArray count]];
    }else{
        
        bookSize = [self fileLengthWithFile:self.bookPath];
        NSFileHandle *handle = [self handleWithFile:self.bookPath];
        unsigned long long index = 0;
	for (int i=0; i<3; i++)  {
		index = [self indexOfPage:handle textFont:textFont];
		[_pageIndexArray addObject:[NSNumber numberWithUnsignedLongLong:index]];
		[handle seekToFileOffset:index];		
	}
	[self showFirstPage];
	
	//NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	thread = [[NSThread alloc]initWithTarget:self selector:@selector(bookIndex) object:nil];
	[thread start];
	//[pool release];
	//[NSThread detachNewThreadSelector:@selector(bookIndex) toTarget:self withObject:nil];
    }
}

#pragma mark NSObject FUNCTION


- (id)init{
	self = [super init];
	if (self) {
		//add your code here
		_pageIndexArray = nil;
		bookIndex = -1;
        bookPageIndex = 0;
		textFont = [UIFont systemFontOfSize:16];
	    pageSize = CGSizeMake(WIDTH, HEIGHT);
        self.isLoading=YES;
	}
	return self;
}

- (id)initWithBook:(NSString*)bookPath successBlock:(KDSuccessBlock)successBlock{
	self = [self init];
	if (self) {
        _success=successBlock;
		self.bookPath = bookPath;
		[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(pageAr) userInfo:nil repeats:NO];
	}
	
	return self;
}

- (void) createBook
{
    
}

- (void)dealloc{
}

- (void)setDelegate:(id <KDBookDelegate>)dele{
	delegate = dele;
	if (delegate == nil) {
		[thread cancel];		
		thread = nil;
	}
}

@end
