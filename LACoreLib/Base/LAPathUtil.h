//
//  LAPathUtil.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/8.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAPathUtil : NSObject

+ (NSString *)mainBundleDirPath;

+ (NSString *)filePathInMainBundle:(NSString *)fileName;

+ (BOOL)createDirIfNotExists:(NSString *)dirPath;



+ (NSString *)documentDirPath;

+ (NSString *)dirPathInDocument:(NSString *)dirName
              createIfNotExists:(BOOL)create;

+ (NSString *)filePathInDocument:(NSString *)fileName;



+ (NSString *)libraryDirPath;

+ (NSString *)dirPathInLibrary:(NSString *)dirName
             createIfNotExists:(BOOL)create;

+ (NSString *)filePathInLibrary:(NSString *)fileName;



+ (NSString *)cacheDirPath;

+ (NSString *)dirPathInCache:(NSString *)dirName
           createIfNotExists:(BOOL)create;

+ (NSString *)filePathInCache:(NSString *)fileName;



+ (NSString *)tempDirPath;

+ (NSString *)dirPathInTemp:(NSString *)dirName
          createIfNotExists:(BOOL)create;

+ (NSString *)filePathInTemp:(NSString *)fileName;

+ (NSString *)uniqueTempFilePath;

@end
