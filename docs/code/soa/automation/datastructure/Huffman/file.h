#ifndef FILE_H
#define FILE_H

#include<fstream>
#include<string>
#include"Huffman.h"

using namespace std;

void load_weightdata_file(HTNode hnode[]);//加载每个字符的权值
char* load_code();  //载入待翻译的代码
char* load_text();  //载入待编码的文本



#endif // !FILE_H

