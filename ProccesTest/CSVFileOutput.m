//
//  CSVFileOutput.m
//  ProccesTest
//
//  Created by 西村顕 on 2015/03/31.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import "CSVFileOutput.h"

@implementation CSVFileOutput

+ (BOOL)exportCSVFile:(NSString *)FilePath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // ファイルが既に存在するか確認
    if(![fileManager fileExistsAtPath:FilePath]) {
        //ないのであれば...ファイルを生成
        [self newCSVFileExport:FilePath];
    } else {
        //存在するのであれば...ファイルに追記
        
    }
    
    return 0;
}

+ (BOOL)newCSVFileExport:(NSString *)FilePath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // 空のファイルが正常に作成されたのか確認
    if (![fileManager createFileAtPath:FilePath contents:[NSData data] attributes:nil]) {
        DLog(@"ファイルの作成に失敗");
        return false;
    } else {
        // ファイルに書き込むデータを作成
        NSString *writeLine = [NSString stringWithFormat:@"\"Date\",\"Time\",\"Battery[%%]\",\"MemoryUse[MB]\",\"MemoryFree[MB]\",\"CPU User[sec]\",\"CPUSystem[sec]\",\"SetBrightnes\"\n"];
        // エンコード変換(UTF-8へ)
        NSData *data = [NSData dataWithBytes:writeLine.UTF8String length:writeLine.length];
        
        [self writeCSVFile2Line:FilePath LineData:data];
        
        return true;
    }
}

+ (BOOL)writeCSVFile2Line:(NSString *)FilePath LineData:(NSData *)data {
    // ファイルハンドルを作成する
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:FilePath];
    if (!fileHandle) {
        NSLog(@"ファイルハンドルの作成に失敗");
        return false;
    }
    
    // ファイルに書き込む
    [fileHandle writeData:data];
    
    // 効率化のためにすぐにファイルに書き込まれずキャッシュされることがある．
    // 「synchronizeFile」メソッドを使用することで
    // キャッシュされた情報を即座に書き込むことが可能．
    [fileHandle synchronizeFile];
    
    // ファイルを閉じる
    [fileHandle closeFile];
    
    return true;
}

@end
