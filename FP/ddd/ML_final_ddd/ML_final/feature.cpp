
#include "tool.h"

using namespace std;
using namespace cv;

void feature_extract(char *name)
{
	fstream train;
	train.open(name, ios::in);
	if(train.fail())
		return;
	int cnt = 0;
	while(!train.eof()){
		if(cnt % 20 == 0)
			cout << cnt << "processing" << endl;
		cnt++;
		string feature;
		getline(train, feature);
		stringstream ss;
		ss << feature;
		string label;
		ss >> label;
		struct trainData temp;
		cv::Mat pic(122, 105, CV_64FC1);
		pic.setTo(0.0);
		while(!ss.eof())
		{
			string pixel;
			ss >> pixel;
			pixel[pixel.find(":")]=' ';
			stringstream tmp;
			tmp << pixel;
			int location;
			double intensity;
			tmp >> location;
			tmp >> intensity;
			if(intensity > 0.01)
			{
				pic.at<double>((location-1)/105, (location-1)%105) = intensity;				
				//pic.at<double>((location-1)/105, (location-1)%105) = 255;				
			}
		}
		pic.convertTo(pic,CV_8UC1,255.0,0);
		//Mat picErosion;
		//picErosion=imgErosion(pic);
		//pic=imgDilation(picErosion);

		int top = 122, bot = 0, left = 105, right = 0;
		cv::Rect roi;
		int edge=5;
		for (int i = edge; i < pic.rows-edge; i++)
		{
			for (int j = edge; j < pic.cols-edge; j++)
			{
				if ((int)pic.at<char>(i,j)>10)
				{
					if( i < top ) 
						top = i;
					if( i > bot ) 
						bot = i;
					if( j < left ) 
						left = j;
					if( j > right ) 
						right = j;
				}
			}
		}
		roi.x = left;
		roi.y = top;
		roi.width = right-left;
		roi.height = bot-top;
		if(roi.width > 5 && roi.height > 5)
		{
			cv::Mat cutPic = pic(roi);
			temp.data = fitTo(cutPic, 120, 120);
			//temp.data.convertTo(temp.data,CV_8UC1,255,0);
			temp.label = label;
		}
		else
		{
			cv::Mat black(120, 120, pic.type());
			black.setTo(0.0);
			temp.data = black;
			//temp.data.convertTo(temp.data,CV_8UC1,255,0);
			temp.label = label;
		}

		Mat tempDilation;
		tempDilation=imgDilation(temp.data);
		temp.data=tempDilation;

		applyFeature(temp);
	}
}

void writeImg(trainData indata, char* name, int id){
	string filename = name;
	char buffer[30];
	_itoa(id, buffer, 10);
	filename = "trainImg\\"+ indata.label + "\\" + filename + "_" + buffer + "_" + indata.label + ".bmp";
	cv::Mat temp;
	indata.data.convertTo(temp, CV_16UC1, 256.0);
	cv::imwrite(filename, temp);
}

void writeFile(trainData indata, char* name){
	ofstream out;
	out.open(name, ios::out|ios::app);
	out << indata.label;
	for(int i = 0; i < indata.data.rows; i++){
		for(int j = 0; j < indata.data.cols; j++){
			if(indata.data.at<double>(i,j) != 0.0)
				out << " " << j * indata.data.cols + j + 1 << ":" << indata.data.at<double>(i,j) << " ";
		}
	}
	out << endl;
	out.close();
}

void applyFeature(trainData oriData){
	//vector<int> uniMap = buildUniMap();
	//lbp(oriData, uniMap, "LBP");
	//yokoi(oriData, "YOKOI");

	hog(oriData, "HOG_");
}
