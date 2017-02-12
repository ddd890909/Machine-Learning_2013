
#include <afx.h>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>


using namespace std;
using namespace cv;

struct trainData{
	string label;
	cv::Mat data;
};

void feature_extract(char *name);
void fileToImg(char *name);
int imgTo4(Mat pic);
Mat fitTo(cv::Mat oriImg, int width, int height);
void imgToFile(string folderName);
void applyFeature(trainData data);


//lbp
#define blockSize 20

void lbp(trainData oriData, vector<int> uniMap, char* fileName);
int getPatternDouble(cv::Mat patch, int x, int y);
int getPatternUchar(cv::Mat patch, int x, int y);
vector<int> buildUniMap();
int findMap(int p, vector<int> uniMap);
void normalizeHist(double *hist);

void hog(trainData oriData, char* fileName);