#/bin/bash
#
#  AMLocalizedStringBuilder
#
#  Created by Mellong on 16/3/28.
#  Copyright © 2016年 tendencystudio. All rights reserved.

PROJECT_DIR=$1
STRING_FILE=$2

H_FILE="${PROJECT_DIR}/temple.h"
M_FILE="${PROJECT_DIR}/temple.m"
RESULT_H_FILE="${PROJECT_DIR}/AMLocalizedString.h"
RESULT_M_FILE="${PROJECT_DIR}/AMLocalizedString.m"

#STRING_FILE=`find $PROJECT_DIR -name "*.strings" -print | grep -E ".*en.lproj.*"`
#
#if [ "$STRING_FILE" == "" ]; then
#STRING_FILE=`find $PROJECT_DIR -name "*.strings" -print`
#echo $STRING_FILE
#    if [ "$STRING_FILE" == "" ]; then
#    echo $STRING_FILE
#    exit
#    fi
#fi




#h file
cat $STRING_FILE | grep -E "\".*?\"\s*=\s*\".*?\"\s*;" | perl -n -e'/\"(.*?)\"\s*=\s*\"(.*?)\"\s*;/ && print "/**\n *  $2\n */\n\@property (nonatomic, copy, readonly) NSString *am_$1;\n\n"' > $H_FILE;
# echo `cat $H_FILE` 
cat $H_FILE | sed '1 i\
\
 //\
//  AMLocalizedString.h\
//  AMLocalizedString\
//\
//  Created by Mellong on 16/03/01.\
//  Copyright © 2016年 tendencystudio. All rights reserved.\
//\
\
#import <Foundation/Foundation.h>\
\
#define R_String [AMLocalizedString shareInstance]\
\
 @interface AMLocalizedString : NSObject\
 \
 ' | sed '$ a\ 
+ (instancetype)shareInstance;\
\
\
@end\
 ' > $RESULT_H_FILE;



#m file
cat $STRING_FILE | grep -E "\".*?\"\s*=\s*\".*?\"\s*;" | perl -n -e'/\"(.*?)\"\s*=\s*\"(.*?)\"\s*;/ && print "\n/**\n *  $2\n */\n- (NSString *)am_$1\n{\n    return NSLocalizedString(@\"$1\" ,nil);\n}\n"' > $M_FILE;

cat $M_FILE | sed '1 i\
\
 //\
//  AMLocalizedString.m\
//  AMLocalizedString\
//\
//  Created by Mellong on 16/03/01.\
//  Copyright © 2016年 tendencystudio. All rights reserved.\
//\
\
\
#import "AMLocalizedString.h"\
\
\
 @implementation AMLocalizedString\
 \
 + (instancetype)shareInstance\
{\
\  \  static id instance = nil;\
\  \  static dispatch_once_t onceToken;\
\  \  dispatch_once(&onceToken, ^{\
\  \  \  \  instance = [[self alloc] init];\
\  \  });\
\  \  return instance;\
}\
\
' | sed '$ a\
\
@end' > $RESULT_M_FILE;

rm $H_FILE
rm $M_FILE