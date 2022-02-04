#ifndef MYQUENE_H
#define MYQUENE_H

typedef struct QENode
{
    int data;
    struct QENode* next;
}QENode;                  //队列结点 
typedef struct
{
    QENode* rear;
    QENode* front;
}LinkQueue;               //队列 

void InitQueue(LinkQueue* Q);           //初始化队列
void QueueAppend(LinkQueue* Q, int v);  //增加队列元素
void QueueDelete(LinkQueue* Q, int* v); //减少队列元素

#endif
