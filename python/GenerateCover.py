# -*- coding: UTF-8 -*-
import os
##
# 注:
# range中的第一个数字为起始期数,第二个为终止期数,可自行修改
# font请自行查询.不同系统下名称可能不同(指令:magick -list font)
# 指令需要安装ImageMagick
# 会覆盖重名文件
# 正常运行情况下不会有任何回显
# by WakelessSloth56
# 2020-01-13T11:20+08:00
# 2020-02-03T22:20+39:00
for num in range(100, 201):
    os.system("magick convert -fill #ff8aae -font \"方正胖头鱼简体\" -pointsize 83.33 -gravity NorthWest -draw \"text 997,532 '第" +
              str(num)+"期'\" input.png "+str(num)+".png")
