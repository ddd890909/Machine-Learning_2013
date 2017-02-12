#include "hog.h"

void hog(trainData oriData, char* fileName){
	/// HOG
	//cv::imshow("data", oriData.data);
	//cv::waitKey(0);
	cv::HOGDescriptor *hog=new cv::HOGDescriptor(cvSize(120,120),cvSize(30,30),cvSize(15,15),cvSize(15,15),9); 
	vector<float> des;  
	hog->compute(oriData.data, des, cv::Size(1,1), cv::Size(0,0));
	ofstream outFile;
	outFile.open(fileName, ios::app);
	outFile << oriData.label;
	bool zero = true;
	//cout << des.size() << endl;
	for(int i=0; i<des.size();i++){
		if(des[i]!=0){
			zero = false;
			outFile << " " << i+1 << ":" << des[i];
		}
	}
	if(zero == true)
		outFile << " 1:0" << endl;
	else
		outFile << endl;
	outFile.close();
}