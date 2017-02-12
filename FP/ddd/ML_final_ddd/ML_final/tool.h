#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include <iostream>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;
using namespace cv;

struct trainData{
	string label;
	cv::Mat data;
};

void feature_extract(char *name);
void writeFile(trainData data, char* name);
void writeImg(trainData data, char* name, int id);
cv::Mat fitTo(cv::Mat oriImg, int width, int height);
void applyFeature(trainData data);
cv::Mat binary(cv::Mat img, int threshold);

Mat imgErosion(Mat oriData);
Mat imgDilation(Mat oriData);

void hog(trainData oriData, char* fileName);