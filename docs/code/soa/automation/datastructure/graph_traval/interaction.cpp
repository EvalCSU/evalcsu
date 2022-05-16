#include"interaction.h"
#include<iostream>
#include<stdio.h>
#include<conio.h> 
using namespace std;
#define backColor 7
#define textColor 1
int Get_int()
{
	int num = 0, i = 0;
	char ch[11] = { 0 };
label1:
	num = 0;
	scanf_s("%s", ch, 10);
	i = 0;
	if (ch[0] == 45 || ch[0] == 43)
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

void Initialize()
{
	system("cls");
	//设置背景颜色
	char command[9] = "color 07";		//默认颜色	
	command[6] = '0' + backColor;		//将backColor变量改为字符型(背景颜色设置为7，为白色） 
	command[7] = '0' + textColor;		//将textColor变量改为字符型 （背景颜色设置为1，为蓝色）
	system(command);				    //调用系统函数 
	printf("                        ***********交通网的深度遍历和广度遍历***********\n");
	printf("                        |    \t0. 退出                               |\n");
	printf("                        |    \t1. 直接通过文件读入地图               |\n");
	printf("                        |    \t2. 手动输入地图信息                   |\n");
	printf("                        ***********************************************\n");
}

int Intercommand()
{
	cout << "请输入您的选择:";
	int input;
	while (1)
	{
		int n = Get_int();
		if (n >= 0 && n < 3)
		{
			input = n;
			break;
		}

		cout << "输入错误，请重输：";
	}

	return input;
}

void Is_refresh()
{
	printf("\n");
	cout << "----------------------------------------------------" << endl;
	cout << "输入任意字符完成查看，回到菜单页面:" << endl;
	_getch();
}