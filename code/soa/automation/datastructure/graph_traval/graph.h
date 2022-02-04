#ifndef GRAPH_H
#define GRAPH_H
#include <string>
using namespace std;

#define MAX 30
//边结点
typedef struct ENode
{
    int ivex, jvex;            //该边依附的两个顶点在数组中的序号
    struct ENode* ilink;       //指向下一条依附于顶点ivex的边
    struct ENode* jlink;       //指向下一条依附于顶点jvex的边
}ENode;
//顶点结点
typedef struct VNode
{
    int mark;                //标记
    string data;             //顶点信息
    int number;              //顶点编号
    ENode* firstedge;
}VNode;
//图
typedef struct
{
    VNode AMlist[MAX];      //结点信息
    int v_num;              //顶点数
    int e_num;              //边数
}Graph;                    

void Initilized(Graph* graph);  //初始化图
void CreateGraph(Graph* graph); //创建图
void SetMark(Graph* graph);     //设置标记
void DFS(Graph* graph, int v);  //深度遍历
void BFS(Graph* graph, int u);  //广度遍历
void CreateGraph_by_file(Graph* graph);//通过文件创建图

#endif // !GRAPH_H

