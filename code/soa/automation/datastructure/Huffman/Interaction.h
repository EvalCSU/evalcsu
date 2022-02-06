#ifndef INTERACTION_H
#define INTERACTION_H

void Initialize();             //初始化
int Intercommand();            //输入选择模式
int Get_choose();              //得到y or n
void Is_refresh();            //检查页面是否更新
int Get_int();                //我编写的判断 输入是否为整形的函数，
char* Get_Capital_letter();   //得到大写字母
char* Get_01();               //得到01码

#endif // !INTERACTION_H

