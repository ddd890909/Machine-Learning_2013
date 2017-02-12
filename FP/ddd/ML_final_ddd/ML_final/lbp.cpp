#include "lbp.h"


void lbp(trainData oriData, vector<int> uniMap, char* fileName){
	int dim = 1;
	uniMap = buildUniMap();
	ofstream outFile;
	outFile.open(fileName, ios::app);
	outFile << oriData.label;
	for(int i = 0; i < oriData.data.rows; i+=blockSize){
		for(int j = 0; j < oriData.data.cols; j+=blockSize){
			double hist[59];
			memset(hist, 0.0, 59 * sizeof(double));
			cv::Mat patch = oriData.data(cv::Rect(j, i, blockSize, blockSize));
			for(int y = 1; y < patch.rows-1; y++){
				for(int x = 1; x < patch.cols-1; x++){
					int index;
					int p = getPatternDouble(patch, x, y);
					index = findMap(p, uniMap);
					if(index >= 0) hist[index]++;
				}
			}
			//normalizeHist(hist);
			for(int hi = 0; hi<59; hi++){
				outFile << " " << dim << ":" << hist[hi];
				dim++;
			}
		}
	}
	outFile << endl;
	outFile.close();
}

vector<int> buildUniMap(){
	vector<int> map;
	for(int j = 0; j<256; j++){
		int count = 0;
		int num = j;
		int flag;
		flag = num%2;
		num /= 2;
		for(int i = 0; i<7; i++){
			if(num%2 != flag) count++;
			flag = num%2;
			num /= 2;
		}
		if(flag != j%2) count++;
		if(count <= 2) map.push_back(j);
		count = 0;
	}
	return map;
}

int getPatternDouble(cv::Mat patch, int x, int y){
	int i = y, j = x;
	int temp = 0;
	int flag;
	int map[256];
	double origin = patch.at<double>(i,j);
	if(patch.at<double>(i-1, j-1) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i-1, j) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i-1, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i+1, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i+1, j) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i+1, j-1) > origin) temp++;
	temp << 1;
	if(patch.at<double>(i, j-1) > origin) temp++;
	return temp;
}

int getPatternUchar(cv::Mat patch, int x, int y){
	int i = y, j = x;
	int temp = 0;
	int flag;
	int map[256];
	uchar origin = patch.at<uchar>(i,j);
	if(patch.at<uchar>(i-1, j-1) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i-1, j) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i-1, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i+1, j+1) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i+1, j) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i+1, j-1) > origin) temp++;
	temp << 1;
	if(patch.at<uchar>(i, j-1) > origin) temp++;
	return temp;
}

int findMap(int p, vector<int> uniMap){
	for(int i=0; i<uniMap.size(); i++)
		if(p == uniMap[i]) return i;
	return 59;
}

void normalizeHist(double *hist){
	double max = 0;
	for(int i = 0; i < 58; i++)
		if(hist[i] > max) max = hist[i];
	for(int i = 0; i < 58; i++)
		hist[i] /= max;
}