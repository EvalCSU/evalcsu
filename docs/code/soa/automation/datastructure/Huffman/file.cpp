#define _CRT_SECURE_NO_WARNINGS
#include<iostream>
#include <fstream>
#include <string>
#include <vector>
#include <windows.h>
#include"file.h"
#include"Huffman.h"

using namespace std;
#define N  50
int g_flag = 0;

//用该函数读取每个字符对应的权值
void load_weightdata_file(HTNode hnode[])
{
	FILE* fp;
	int i = 0;
	fp = fopen("weightdata.txt", "r");
	if (fp == NULL)
	{
		cout<<"打开文件失败";
	}
	while (!feof(fp))
	{
		fscanf(fp, "%c", &(hnode[i].data));
		fscanf(fp, "%d", &(hnode[i].weight));
		fseek(fp, 2, SEEK_CUR);
		i++;
		if (i == N - 2)
			break;
	}
	g_flag = 1;
	fclose(fp);
}

char* load_code() {
	ifstream in("code.txt");
	char buffer[256];
	if (!in.is_open()) {
		cout << "加载文件错误" << endl;
		return NULL;
	}
	cout << "载入编码文件" << endl;
	in.getline(buffer, 200, ' ');
	return buffer;
}

char* load_text()
{
	ifstream in("text.txt");
	char buffer[256]; 
	if (!in.is_open()) {
		cout << "加载文件错误" << endl;
		return NULL;
	}
	cout << "载入待编码字段" << endl;
	in.getline(buffer, 100);

	return buffer;
}


//用该函数输出各个字符的编码 字符 对应编码
int Print_HuffMan_file()
{
	FILE* fp;
	char data[50], c;
	int d;
	fp = fopen("Huffman.txt", "r");
	if (fp == NULL )
	{
		printf("打开文件哈夫曼编码错误。\n");
		return -1;
	}
	while (1)
	{
		fscanf(fp, "%c%d%s", &c, &d, data);
		if (feof(fp))
			break;
		printf("%c\t%d\t%s\n", c, d, data);
		fseek(fp, 2, SEEK_CUR);
	}
	fclose(fp);
}
