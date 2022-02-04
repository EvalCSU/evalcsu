#include"graph.h"
#include"myquene.h"
#include<iostream>
#include"interaction.h"
#include<fstream>
#include<string>
using namespace std;

void Initilized(Graph* graph)//图的初始化
{
    graph = (Graph*)malloc(sizeof(Graph));
    graph->v_num = 0;
    graph->e_num = 0;
}
int graph_flag = 0;
void CreateGraph(Graph* graph)//图的创建图
{
    ENode* p, * q, * e;
    e = NULL;
    int i,input_flag=0;
    printf("请输入连通无向图的顶点数 ：");
    graph->v_num = Get_int();
    do{
        if (input_flag++ > 1)
            printf("输入错误，请重新输入\n");
        printf("请输入连通无向图的边数 ：");
        graph->e_num = Get_int();
    } while (graph->e_num < graph->v_num - 1);
    

    for (i = 1; i <= graph->v_num; i++)
    {
        printf("请输入第%d个顶点的信息：\n", i);
        cin >> graph->AMlist[i].data;
        graph->AMlist[i].number = i;
        graph->AMlist[i].firstedge = NULL;
        graph->AMlist[i].mark = 0;
    }     
    //输入每个点的信息
    for (i = 1; i <= graph->e_num; i++)
    {
        p = (ENode*)malloc(sizeof(ENode));
        printf("请输入第%d条边的首尾两个点（编号小的在前 （例如1 3回车））\n",i);
        while (1)
        {
            p->ivex = Get_int();
            p->jvex = Get_int();
            if (p->ivex<p->jvex && p->ivex>0 && p->jvex <= graph->v_num && p->ivex!=p->jvex)
                break;
            else {
                cout << "您输入错误，请重新输入" << endl;
            }
        }
        p->ilink = p->jlink = NULL;                    //边信息填入完毕
        /*将边连在一起*/
        if (graph->AMlist[p->ivex].firstedge == NULL)
            graph->AMlist[p->ivex].firstedge = p;      //邻接多重表的顶点首指针指向p
        else
        {
            q = graph->AMlist[p->ivex].firstedge;     //记录首边
            while (q != NULL)
            {
                e = q;
                if (q->ivex == p->ivex)    
                    q = q->ilink;
                else
                    q = q->jlink;
            }
            if (e->ivex == p->ivex)
                e->ilink = p;
            else
                e->jlink = p;
        }
        if (graph->AMlist[p->jvex].firstedge == NULL)
            graph->AMlist[p->jvex].firstedge = p;
        else
        {
            q = graph->AMlist[p->jvex].firstedge;
            while (q != NULL)
            {
                e = q;
                if (q->ivex == p->ivex)
                    q = q->ilink;
                else
                    q = q->jlink;
            }
            if (e->ivex == p->ivex)
                e->ilink = p;
            else
                e->jlink = p;
        }
    }
}

void SetMark(Graph* graph)//设置访问标记
{
    int i;
    for (i = 1; i <= graph->v_num; i++)
        graph->AMlist[i].mark = 0;
}

void DFS(Graph* graph, int v)//深度遍历
{
    ENode* p;
    cout << graph->AMlist[v].data <<"        "; graph_flag++;
    graph->AMlist[v].mark = 1;
    p = graph->AMlist[v].firstedge;
    while (p != NULL)
    {
        if (p->ivex == v)
        {
            if (graph->AMlist[p->jvex].mark == 0)
            {
                cout << "<" << p->ivex << "," << p->jvex << ">" << endl;
                DFS(graph, p->jvex);
            }
                
            p = p->ilink;
        }
        else
        {
            if (graph->AMlist[p->ivex].mark == 0)
            {
                cout << "<" << p->jvex << "," << p->ivex << ">" << endl;
                DFS(graph, p->ivex);
                
            }
                
            p = p->jlink;
        }
    }
}

void BFS(Graph* graph, int u)//广度遍历
{
    LinkQueue Q;
    ENode* p;
    InitQueue(&Q);
    cout << graph->AMlist[u].data << endl;
    graph->AMlist[u].mark = 1;
    QueueAppend(&Q, u);
    while (Q.front != Q.rear)
    {
        QueueDelete(&Q, &u);
        p = graph->AMlist[u].firstedge;
        while (p != NULL)
        {
            if (p->ivex == u)
            {
                if (graph->AMlist[p->jvex].mark == 0)
                {
                    QueueAppend(&Q, p->jvex);
                    graph->AMlist[p->jvex].mark = 1;
                    cout << graph->AMlist[p->jvex].data << endl;
                }
                p = p->ilink;
            }
            else
            {
                if (graph->AMlist[p->ivex].mark == 0)
                {
                    QueueAppend(&Q, p->ivex);
                    graph->AMlist[p->ivex].mark = 1;
                    cout << graph->AMlist[p->ivex].data << endl;
                }
                p = p->jlink;
            }
        }
    }
}

void CreateGraph_by_file(Graph* graph)
{
    fstream fp;
    fp.open("graph_info.txt", ios::in);
    fp >> graph->v_num; //cout << graph->v_num;
    fp.seekg(1, ios::cur);
    fp >> graph->e_num; //cout << graph->e_num;
    fp.seekg(2, ios::cur);
    //cout << graph->v_num << " " << graph->e_num << endl;
   
    char v_info[10]; 
    int i = 0;
    while (++i <= graph->v_num &&  fp.getline(v_info, 100,'\n') ) // line中不包括每行的换行符  
    {
        graph->AMlist[i].number = i;
        graph->AMlist[i].firstedge = NULL;
        graph->AMlist[i].mark = 0;
        graph->AMlist[i].data=v_info;
        //cout << graph->AMlist[i].data<<endl;
    }
    ENode* p, * q, * e;
    e = (ENode*)malloc(sizeof(ENode));
    q = (ENode*)malloc(sizeof(ENode));
    for (i = 1; i <= graph->e_num; i++)
    {
        p = (ENode*)malloc(sizeof(ENode));
        fp >> p->ivex; //cout << p->ivex<<endl;
        fp.seekg(1, ios::cur);
        fp >> p->jvex; //cout << p->jvex<<endl;
        fp.seekg(2, ios::cur);
        p->ilink = p->jlink = NULL;                    //边信息填入完毕
        /*将边连在一起*/
        if (graph->AMlist[p->ivex].firstedge == NULL)
            graph->AMlist[p->ivex].firstedge = p;      //邻接多重表的顶点首指针指向p
        else
        {
            q = graph->AMlist[p->ivex].firstedge;     //记录首边
            while (q != NULL)
            {
                e = q;
                if (q->ivex == p->ivex)
                    q = q->ilink;
                else
                    q = q->jlink;
            }
            if (e->ivex == p->ivex)
                e->ilink = p;
            else
                e->jlink = p;
        }
        if (graph->AMlist[p->jvex].firstedge == NULL)
            graph->AMlist[p->jvex].firstedge = p;
        else
        {
            q = graph->AMlist[p->jvex].firstedge;
            while (q != NULL)
            {
                e = q;
                if (q->ivex == p->ivex)
                    q = q->ilink;
                else
                    q = q->jlink;
            }
            if (e->ivex == p->ivex)
                e->ilink = p;
            else
                e->jlink = p;
        }
    }
    fp.close();
    
    
}