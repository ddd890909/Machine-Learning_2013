#include "tool.h"

#define blockSize 20

void lbp(trainData oriData, vector<int> uniMap, char* fileName);
int getPatternDouble(cv::Mat patch, int x, int y);
int getPatternUchar(cv::Mat patch, int x, int y);
vector<int> buildUniMap();
int findMap(int p, vector<int> uniMap);
void normalizeHist(double *hist);

