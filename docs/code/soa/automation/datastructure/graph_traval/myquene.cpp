#include"myquene.h"
#include"graph.h"
#include<iostream>
#include<stdlib.h>
using namespace std;

void InitQueue(LinkQueue* Q)  //队列的初始化 
{
    Q->front = Q->rear = (QENode*)malloc(sizeof(QENode));
    Q->front->next = NULL;
}

void QueueAppend(LinkQueue* Q, int v)//入队列 
{
    QENode* p;
    p = (QENode*)malloc(sizeof(QENode));
    p->data = v;
    p->next = NULL;
    Q->rear->next = p;
    Q->rear = p;
}

void QueueDelete(LinkQueue* Q, int* v)//出队列 
{
    QENode* p;
    if (Q->front == Q->rear)
        return;
    p = Q->front->next;
    *v = p->data;
    Q->front->next = p->next;
    if (Q->rear == p)
        Q->rear = Q->front;
    free(p);
}