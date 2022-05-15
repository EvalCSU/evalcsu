# encoding=utf-8
import yaml
import os

with open('mkdocs.yml',"r") as config:
    configDict = yaml.safe_load(config)

# configDict = yaml.loads(configStr)
print(configDict)

navList = configDict.get('nav')
print(navList)

navMap = {
    'evaluation':'评教',
    'cse':'计算机学院',
    'soa':'自动化学院',
    'bigdata':'大数据',
    'iot':'物联网',
    'science':'计算机科学与技术',
    'security':'信息安全',
    'software':'软件工程',
    'faculty':'笔记',
    'automation':'自动化',
    'electronic':'电子工程及其自动化',
    'electronic_information':'电子信息工程',
    'intelligence':'智能科学与技术',
    'observe_and_control':'测控',
    'communication':'通信工程'
}

def popFirst(path:str) -> str:
    return os.path.join(*str.split(path,'/')[1:])

def parse(path:str) -> list:
    rlt = []
    for i in os.listdir(path):
        if i == 'code' or i == 'img':
            continue
        tempPath = os.path.join(path, i)
        _list = tempPath.split('/')
        if i == 'README.md':
            i = _list[-2]
            if i == 'soa' or i == 'cse':
                continue
            if _list[1] == 'evaluation':
                rlt.append(popFirst(tempPath))
                continue
        if os.path.isdir(tempPath):
            if str(i) in navMap.keys():
                rlt += [{navMap[str(i)]:parse(tempPath)}]
            else:
                rlt += [{str(i):parse(tempPath)}]
        else:
            if str.split(i,'.')[-1] == 'md':
                i = str.split(i,'.')[0]
            if str(i) in navMap.keys():
                rlt += [{navMap[str(i)]:popFirst(tempPath)}]
            else:
                rlt +=[{str(i):popFirst(tempPath)}]
    return rlt

temp = [{'简介':[{'Getting Start':'README.md'}]}]
temp += parse('docs')[:-1]
newNav = {'nav':temp}
configDict.update(newNav)
with open('mkdocs.yml','w+') as f:
    yaml.safe_dump(configDict,f,allow_unicode=True)