#include "tool.h"

#define blockSize 20
#define bins 59

void lbp(trainData oriData, vector<int> uniMap, char* fileName);
int getPatternfloat(cv::Mat patch, int x, int y);
int getPatternUchar(cv::Mat patch, int x, int y);
vector<int> buildUniMap();
int findMap(int p, vector<int> uniMap);
void normalizeHist(float *hist);
bool verify(cv::Mat oriImg);