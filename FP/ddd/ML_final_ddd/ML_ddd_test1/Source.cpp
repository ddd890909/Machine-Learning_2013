#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <fstream>
#include <iostream>
#include <string>
#include "tool.h"

using namespace std;
using namespace cv;

//string name = "ml2013final_train.dat"; 
//string name = "ml2013final_test1.nolabel.dat"; 

int main(int argc, char *argv[])
{

	feature_extract(argv[1]);

	return 0;
}