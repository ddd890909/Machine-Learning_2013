#include "lbp.h"
//#include "yokoi.h"
#include "voronoi.h"
//#define training
using namespace std;

void feature_extract(char *name){
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
		cv::Mat pic(122, 105, CV_32FC1);
		pic.setTo(0.0);
		int top = 122, bot = 0, left = 105, right = 0;
		cv::Rect roi;
		while(!ss.eof()){
			string pixel;
			ss >> pixel;
			pixel[pixel.find(":")]=' ';
			stringstream tmp;
			tmp << pixel;
			int location;
			float intensity;
			tmp >> location;
			tmp >> intensity;
			if(intensity > 0.01){
				pic.at<float>((location-1)/105, (location-1)%105) = intensity;
				if(((location-1) /105) < top) 
					top = (location-1) /105;
				if(((location-1) /105) > bot) 
					bot = (location-1) /105;
				if(((location-1) %105) < left) 
					left = (location-1) %105;
				if(((location-1) %105) > right) 
					right = (location-1) %105;
			}
		}
#ifdef training
		if(!verify(pic)) continue;
#endif
		roi.x = left;
		roi.y = top;
		roi.width = right-left;
		roi.height = bot-top;
		if(roi.width > 0 && roi.height > 0){
			cv::Mat cutPic = pic(roi);
			//cutPic.convertTo(cutPic,CV_8UC1, 256.0);
			//cutPic = binary(cutPic, 128);
			//VoronoiSkeleton skel;
			//skel.thin(cutPic,"zhang_suen_fast",false);
			//cutPic = skel.get_skeleton().clone();
			temp.data = fitTo(cutPic, 120, 120);
			temp.label = label;
			//writeFile(temp, "feature");
			//writeImg(temp, "train", cnt);
		}
		else{
#ifdef training
			continue;
#endif
			cv::Mat black(120, 120, pic.type());
			black.setTo(0);
			temp.data = black;
			temp.label = "0";
		}
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
			if(indata.data.at<float>(i,j) != 0.0)
				out << " " << j * indata.data.cols + j + 1 << ":" << indata.data.at<float>(i,j) << " ";
		}
	}
	out << endl;
	out.close();
}

void applyFeature(trainData oriData){
	vector<int> uniMap = buildUniMap();
	lbp(oriData, uniMap, "LBP");
	//yokoi(oriData, "YOKOI");
}