//
//  DrawItalicizeFontView.m
//  DrawItalicizeFontDemo
//
//  Created by 李佳 on 15/12/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "DrawItalicizeFontView.h"
#import <CoreText/CoreText.h>

/*------------------------------
  -------            -------
 |       |          /      /
 |       |------>  /      /
  -------          -------
 ------------------------------*/

@implementation DrawItalicizeFontView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //随机一下字体，所以有时候可能画出不是正常的字符
    NSArray* fontArr = [UIFont familyNames];
    NSUInteger fontIndex = arc4random() % (fontArr.count - 1);
    NSString* fontName = fontArr[fontIndex];
    
    CTFontRef fontZero = CTFontCreateUIFontForLanguage(kCTFontUIFontUser, 10, NULL);
    CTFontRef ctFont = CTFontCreateCopyWithFamily(fontZero, 24.0, NULL, (CFStringRef)fontName);
    NSDictionary* dic = @{(id)kCTFontAttributeName :(__bridge id)ctFont};
    CFRelease(fontZero);
    CFRelease(ctFont);
    
    //正常
    NSString* text = @"Hello Timereader 佳";
    [text drawAtPoint:CGPointMake(100, 100) withAttributes:dic];
    
    //斜体坐标系。
    CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    float radiansX = M_PI / 180 * (20);
    float d = 1, c = 0, a = 1, b = 0;
    d = cosf(radiansX);
    c = -sinf(radiansX);
    
    //-d的缘由是TextMatrix的坐标系问题，所以本来应该是顺时针的20°。结果变成了-20°。（镜像）
    CGAffineTransform transformItalic = CGAffineTransformMake(a, b ,c, -d ,0, 0);
    CGAffineTransformConcat(transform, transformItalic);
    CGContextSetTextMatrix(context, transformItalic);
    
    CGPoint position = CGPointMake(100, 200);
    CGContextSetTextPosition(context, position.x, position.y);
    
    CFAttributedStringRef attrStr = CFAttributedStringCreate(kCFAllocatorDefault, (CFStringRef)text, (CFDictionaryRef)dic);
    CTLineRef line = CTLineCreateWithAttributedString(attrStr);
    CTLineDraw(line, context);
    CFRelease(attrStr);
    CFRelease(line);
    
    //CoreGraphic设置世界坐标系也可以的。
    transformItalic = CGAffineTransformMake(a, b ,c, d ,0, 0);
    CGContextConcatCTM(context, transformItalic);
    //说明一下。。这个方法不会考虑TextMatrix。
    [text drawAtPoint:CGPointMake(200, 300) withAttributes:dic];
}


@end
