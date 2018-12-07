# -*- coding: UTF-8 -*-

import os
import json
import hashlib

import comFun
#读取路径下的所有资源文件分类后写入到文件中
filepath = "./res"
# filepath = "D:/Python_FileDispose/res"

class gameres:
    file = open("files.txt" , "w+")
    file.close()
    fileList = []
    comFun.initPathFiles(filepath , fileList)

    filedict = {}   #资源目录下的资源字典，有多少中类型资源，每种类型有多少个
    def initFileDict(self):
        def fillDict(typedict , filepath):
            pathdict = {}
            typedict[filepath] = pathdict
            pathdict["md5"] = comFun.getFileMd5(filepath)
            # pathdict["md5"] = self.getFileMd5(filepath)
            pathdict["size"] = os.path.getsize(filepath)
            #len(dict)   #返回dict元素个数

        for pathbylist in self.fileList:
            abspath = pathbylist
            if not os.path.isabs(abspath):
                abspath = os.path.abspath(pathbylist)
            singlepath , filetype = os.path.splitext(abspath)   # 分离文件名和后缀
            if filetype in self.filedict:
                typedict = self.filedict.get(filetype)
                fillDict(typedict , abspath)
            else:
                typedict = {}
                self.filedict[filetype] = typedict
                fillDict(typedict, abspath)
        # print(json.dumps(self.filedict, ensure_ascii=False, encoding="utf -8", indent=4))