#include"Interaction.h"
#include<iostream>
#include<stdio.h>
#include<conio.h> 
#include<math.h>
#include<string>
using namespace std;
#define backColor 7
#define textColor 1

enum Color
{
	black, blue, green, lakeBlue, red, purple, yellow, white, gray
};

void Initialize()
{
	system("cls");
	//设置背景颜色
	char command[9] = "color 07";		//默认颜色	
	command[6] = '0' + backColor;		//将backColor变量改为字符型(背景颜色设置为7，为白色） 
	command[7] = '0' + textColor;		//将textColor变量改为字符型 （背景颜色设置为1，为蓝色）
	system(command);				    //调用系统函数 
	//设置菜单
	printf("                        **************哈夫曼树编码器与译码器***********\n");
	printf("                        |    \t0. 退出                               |\n");
	printf("                        |    \t1. 打印字符集的权值以及字符集的编码   |\n");
	printf("                        |    \t2. 将字符串翻译为编码                 |\n");
	printf("                        |    \t3. 将编码翻译为字符串                 |\n");
	printf("                        ***********************************************\n");
	
}

int Intercommand()
{
	cout << "请输入您的选择:";
	int input;
	while (1)
	{
		int n = Get_int();
		if (n >= 0 && n < 4)
		{
			input = n;
			break;
		}
			
		cout<<"输入错误，请重输：";
	}
	
	return input;
}

int Get_choose()
{
	char ch[21] = { 0 };
	int flag;
	int i = 0;
	while (1)
	{
		fflush(stdin);
		scanf_s("%s", ch, 20);
		if (ch[i] == 'y' || ch[i] == 'Y')
		{
			flag = 1;
			break;
		}
		else if (ch[i] == 'n' || ch[i] == 'N')
		{
			flag = 0;
			break;
		}
		else {
			cout << "输入错误，请重新输入" << endl;
		}
	}
	return flag;
}

char* Get_Capital_letter()
{
	char s[100] ;
	int i ;
	cin.get();
label2:
	i = 0;
	fflush(stdin);
	gets_s(s);
	while (s[i])
	{
		if (s[i] >= 65 && s[i] <= 90)
			i++;
		else if (s[i] == 32)
		{
			s[i++] = 32;
		}
		else if(s[i]==13){
			break;
		}
		else {
			cout << "您输入非大写字母的字符，无法进行翻译,请重新输入：" << endl;
			goto label2;
		}
		
	}
	s[i] = '\0';
	return s;
}

char* Get_01()
{
	char s[300] = { 0 };
	int i;
label3:
	i = 0;
	fflush(stdin);
	scanf_s("%s", s, 300);
	while (s[i])
	{
		if (s[i] =='0'||s[i]=='1')
			i++;
		else if (s[i] == 13) {
			break;
		}
		else {
			cout << "您输入非01的字符，无法进行翻译,请重新输入：" << endl;
			goto label3;
		}

	}
	s[i] = '\0';
	return s;
}

void Is_refresh()
{
	printf("\n");
	cout << "----------------------------------------------------"<<endl;
	cout << "输入任意字符完成查看，回到菜单页面:" << endl;
	_getch();
}

int Get_int()
{
	int num = 0,i=0;     //int
	char ch[11] = { 0 }; 
label1:
	num = 0;
	scanf_s("%s", ch,10);
	i = 0;
	if (ch[0] == 45 || ch[0] == 43)  //"+""-"
	{
		i++;
	}
	while (ch[i])
	{
		if (ch[i] < '0' || ch[i]>'9')
		{
			cout << "输入错误，请输入数字:" << endl;
			goto label1;
		}
		else {
			num = num * 10 + (int)ch[i] - 48;
		}
		i++;

	}
	if (ch[0] == 45)
	{
		return -num;
	}
	else
	{
		return num;
	}
}