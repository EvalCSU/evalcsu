#ifndef HUFFMAN_H
#define HUFFMAN_H

#include<string>
#define N 50		/*叶子结点数*/
#define M 2*N-1		/*树中结点总数*/
using namespace std;

/*实现思路：
一.先由存入文件中的各字符的频率计算出各字符的哈夫曼树编码，由此得到哈夫曼结点
哈弗曼结点包含了下列信息：1.该结点对应的编码（存入到HCode中的cd中） 2.权重（就是频率）
						  3.父母结点，左子结点，右子结点
二.输入字符串，由于已经计算了每个字符对应的编码，故直接把每个字符翻译出来就好了*/

typedef struct {
	char data;           //定义结点值,此处为ABCD.....
	unsigned int weight; //定义每个节点的权重
	unsigned int parent, lchild, rchild;
}HTNode,*HuffmanTree;

typedef struct {
	char cd[N];
	int start;
}HCode; //定义
void Print_weightdata(HTNode hnode[],int n=27);     //输出权值
void CreateHT(HTNode ht[], int n);		           //创建哈夫曼树,将树结点数组转换为树
void CreateHCode(HTNode ht[], HCode hcd[], int n); //创建哈夫曼树编码
void DispHCode(HTNode ht[], HCode hcd[], int n);    //打印字符集编码
void Encode(char* s, HTNode ht[], HCode hcd[], int n);//实现编码并打印
void DeCode(string s, int n, HTNode h[]);//实现译码并打印


#endif // !HUFFMAN_H

