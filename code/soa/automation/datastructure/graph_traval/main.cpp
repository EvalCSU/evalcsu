#include<stdio.h>
#include<malloc.h>
#include<iostream>
#include"graph.h"
#include"myquene.h"
#include"interaction.h"
using namespace std;

int main()
{
    int v1, v2;  //定义两个顶点
    Graph graph; //定义了一个图
    int choose;
    
    while (1)
    {
        Initialize();
        fflush(stdin);
        choose = Intercommand();
        switch (choose)
        {
        case 0:
            exit(0);
        case 2:
            Initilized(&graph);
            CreateGraph(&graph);
            printf("\n输入深度广度遍历的起始点：\n");
            v2 = Get_int();
            v1 = v2;
            printf("\n深度遍历序列:\n顶点序列：\n");
            SetMark(&graph);
            DFS(&graph, v2);
            printf("\n广度遍历序列:\n顶点序列：\n");
            SetMark(&graph);
            BFS(&graph, v1);
            Is_refresh();
        case 1:
            Initilized(&graph);
            CreateGraph_by_file(&graph);
            fflush(stdin);
            printf("\n输入深度广度遍历的起始点：\n");
            v2 = Get_int();
            v1 = v2;
            printf("\n深度遍历序列:\n");
            SetMark(&graph);
            DFS(&graph, v2);
            printf("\n广度遍历序列:\n");
            SetMark(&graph);
            BFS(&graph, v1);
            Is_refresh();
        }
    }
    
    return 0;
}