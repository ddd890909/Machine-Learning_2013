

#include <fstream>
#include <iostream>
#include <string>
#include <stdlib.h>

using namespace std;

int main()
{
	string FolderName="D:\\course\\Machine Learning\\FP\\ddd\\ML_final_ddd\\ML_ddd_test1\\data\\test1Img4";
	
	fstream outResult;
	outResult.open(FolderName+"\\ddd.out", ios::out);
	//string aa;
	//getline(outResult,aa);
	//cout<<aa<<endl;
	//aa="3";
	//outResult<<aa<<endl;

	ifstream out;
	out.open(FolderName+"\\aaaaaaaaaaaaa.out",ios::in);
	ifstream outOrder;
	outOrder.open(FolderName+"\\bbbbbbbbbbbbbbb",ios::in);

	while (!out.eof())
	{
		string label;
		getline(out,label);

		string order;
		getline(outOrder,order);
		int t;
		t=atoi(order.c_str());

		string change;
		for (int i = 0; i < t; i++)
		{		
			getline(outResult,change);
		}
		change=label;
		outResult<<change<<endl;
	}
	out.close();
	outOrder.close();

	outResult.close();
	
	return 0;
}

