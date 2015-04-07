//
//  CSVFileOutput.h
//  ProccesTest
//
//  Created by 西村顕 on 2015/03/31.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSVFileOutput : NSObject {
    NSString *FilePath;
}

/**
 *  exportCSVFile(CSVファイルを出力)
 *
 *  @param FilePath ファイルのパス
 *
 *  @return 正常に書き込めたかどうか
 */
+ (BOOL)exportCSVFile:(NSString *)FilePath;

/**
 *  新しいCSVファイルを生成
 *
 *  @param FilePath 生成場所
 *
 *  @return 正常に書き込めたかどうか
 */
+ (BOOL)newCSVFileExport:(NSString *)FilePath;

@end
