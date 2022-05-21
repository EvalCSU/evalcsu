#include<iostream>
#include<string.h>
#include<stdio.h>
#include<conio.h>
#include"Huffman.h"
#include"Interaction.h"
#include"file.h"
using namespace std;

#define N 50		/*叶子结点数*/
#define M 2*N-1		/*树中结点总数*/

int n = 27;
int main() {
	int choose ; //选择变量
	HTNode ht[M];
	HCode hcd[N];//定义哈夫曼树结点和哈夫曼编码

	load_weightdata_file(ht);
	CreateHT(ht, n);
	CreateHCode(ht, hcd, n);

	char s[100] = { 0 };
	char input_code[300] = { 0 };
	int y_or_n = 0;
	while (1)
	{
		Initialize();
		choose = Intercommand();
		switch (choose)
		{
		case 0:
			exit(0);
		case 1:
			/*进行权重输出*/
			Print_weightdata(ht);
		    //进行编码输出
			DispHCode(ht, hcd, n);
			//检测用户是否查看完毕并进行页面的刷新
			Is_refresh();
			break;
		case 2:
			/*文件导入或者手动输入字符串*/
			cout << "请问您要手动输入字符串还是通过文件导入需要编码的字符串,文件输入请按y，手动输入请按n:";
			fflush(stdin);
			getchar();
			y_or_n = Get_choose();
			if (y_or_n == 0)
			{
				/*
				cout << "请输入字符串：" << endl; //待处理点：编码中出现了非大写字母或空格
				fflush(stdin);*/
				cout << "请输入字符串：" << endl;
				fflush(stdin); 
				strcpy_s(s, Get_Capital_letter());
				//gets_s(s);
				Encode(s, ht, hcd, n);
			}
			else if (y_or_n == 1)
			{
				strcpy_s(s, load_text());
				Encode(s, ht, hcd, n);
			}
			/*检测用户是否查看完毕并进行页面的刷新*/
			Is_refresh();
			break;

		case 3:
			/*文件导入或手动输入编码*/
			cout << "请问您要手动输入编码还是通过文件导入需要译码的编码,文件输入请按y，手动输入请按n:";
			fflush(stdin);
			getchar();
			y_or_n = Get_choose();
			if (y_or_n == 0)
			{
				/*
				cout << "请输入编码:";      //待处理点：编码中出现了非0非1
				fflush(stdin);
				getchar();
				gets_s(input_code);
				*/
				cout << "请输入编码：" << endl;
				fflush(stdin);
				strcpy_s(input_code, Get_01());
				DeCode(input_code, n, ht);
			}
			else if (y_or_n == 1)
			{
				strcpy_s(input_code, load_code());
				DeCode(input_code, n,ht);
			}
			/*检测用户是否查看完毕并进行页面的刷新*/
			Is_refresh();
			break;
		}
	}

	return 0;
}
