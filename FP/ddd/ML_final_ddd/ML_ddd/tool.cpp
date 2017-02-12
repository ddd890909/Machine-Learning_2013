
#include "tool.h"

using namespace std;
using namespace cv;

void fileToImg(char *name)
{
	fstream train;
	train.open(name, ios::in);
	if(train.fail())
		return;
	int cnt = 0;
	while(!train.eof())
	{
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
		temp.label = label;
		Mat pic(122, 105, CV_64FC1);
		pic.setTo(0.0);
		
		int top = 122, bot = 0, left = 105, right = 0;
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
				//pic.at<double>((location-1)/105, (location-1)%105) = intensity;
				pic.at<double>((location-1)/105, (location-1)%105) = 255;

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

		//**all in one**
		//string picName;
		//picName = "D:\\course\\Machine Learning\\FP\\ddd\\ML_final_ddd\\ML_ddd\\data\\trainImg\\";
		//char buffer[30];
	    //_itoa(cnt, buffer, 10);
		//picName += "train_"; 
		//picName += buffer ;
		//picName += "_" + label + ".jpg";
		//imwrite(picName,pic);

		//int r;
		//r=imgTo4(pic);

		Rect roi;
		roi.x = left;
		roi.y = top;
		roi.width = right-left;
		roi.height = bot-top;
		if(roi.width > 0 && roi.height > 0)
		{
			Mat cutPic = pic(roi);
			temp.data = fitTo(cutPic, 120, 120);
			temp.label = label;
		}
		else
		{
			Mat black(120, 120, pic.type());
			black.setTo(0.0);
			temp.data = black;
		}

		string picName;
		picName = "D:\\course\\Machine Learning\\FP\\ddd\\ML_final_ddd\\ML_ddd\\data\\test1ImgN";
		char buffer[30];
	    //_itoa_s(r, buffer, 10);
		//picName += buffer;
		picName += "\\train_"; 
		_itoa_s(cnt, buffer, 10);
		picName += buffer;
		picName += "#"+ label + ".jpg";
		imwrite(picName,temp.data);

	}	
}

int imgTo4(Mat pic)
{
	if(pic.empty())
	{
		cout<< "error" <<endl;
	}

	int top[4],bot[4],left[4],right[4];
	top[0]=0;top[1]=0;top[2]=62;top[3]=62;
	bot[0]=60;bot[1]=60;bot[2]=121;bot[3]=121;
	left[0]=0;left[1]=53;left[2]=0;left[3]=53;
	right[0]=51;right[1]=104;right[2]=51;right[3]=104;

	int r[]={0,0,0,0};	
	for (int reg = 0; reg < 4; reg++)
	{
		for (int i = top[reg]; i < bot[reg]; i++)
		{
			for (int j = left[reg]; j < right[reg]; j++)
			{
				if( pic.at<double>(i, j) != 0 )
				{
					r[reg]=1;
				}
			}
		}
	}	

	if (r[0]==0 && r[1]==1 && r[2]==1 && r[3]==1)
	{
		return 0;
	}
	else if (r[0]==1 && r[1]==0 && r[2]==1 && r[3]==1)
	{
		return 1;
	}
	else if (r[0]==1 && r[1]==1 && r[2]==0 && r[3]==1)
	{
		return 2;
	}
	else if (r[0]==1 && r[1]==1 && r[2]==1 && r[3]==0)
	{
		return 3;
	}
	else
	{
		return 4;
	}	
	
}

Mat fitTo(Mat oriImg, int width, int height){
	int finWidth, finHeight;
	double oriRatio = double(oriImg.rows) / oriImg.cols;
	double finRatio = double(height) / width;
	if(oriRatio > finRatio){
		finHeight = height;
		finWidth =  finHeight * oriImg.cols / oriImg.rows;
	}
	else{
		finWidth = width;
		finHeight = finWidth * oriImg.rows / oriImg.cols;
	}
	cv::Mat result(finHeight, finWidth, oriImg.type());
	cv::resize(oriImg, result, result.size());
	if(result.rows < height){
		int upH = (height-result.rows)/2;
		int downH = height - result.rows - upH;
		cv::Mat upM(upH, width, result.type());
		upM.setTo(0);
		cv::Mat downM(downH, width, result.type());
		downM.setTo(0);
		if(upH != 0) 
			cv::vconcat(upM, result, result);
		if(downH != 0)
			cv::vconcat(result, downM, result);
	}	
	if(result.cols < width){
		int leftW = (width-result.cols)/2;
		int rightW = width - result.cols - leftW;
		cv::Mat leftM(height, leftW, result.type());
		leftM.setTo(0);
		cv::Mat rightM(height, rightW, result.type());
		rightM.setTo(0);
		if(leftW != 0)
			cv::hconcat(leftM, result, result);
		if(rightW != 0)
			cv::hconcat(result, rightM, result);
	}
	return result;
}

void imgToFile(string folderName)
{
	char filename[150];
	string folder = folderName+"\\*.jpg";
	string folderwithout = folderName+"\\";

	size_t origsize = folder.size() + 1;
    const size_t newsize = 100;
    size_t convertedChars = 0;
    wchar_t wcstring[newsize];
    mbstowcs_s(&convertedChars, wcstring, origsize, folder.c_str(), _TRUNCATE);

    WIN32_FIND_DATA FindFileData;
    HANDLE FileHandle;
	FileHandle = FindFirstFile(wcstring, &FindFileData);
    WideCharToMultiByte( CP_ACP, 0, FindFileData.cFileName, -1,filename, sizeof(filename), NULL, NULL ); 
	SetLastError(0);
	while(GetLastError()!=ERROR_NO_MORE_FILES)
	{	
		string dir = folderwithout+filename; 		
		struct trainData temp;
		temp.data=imread(dir);
		dir[dir.find("#")]=' ';
		dir[dir.find(".")]=' ';
		stringstream ss;
		ss<<dir;
		string number;
		ss>>number;
		ss>>number;
		ss>>temp.label;

		applyFeature(temp);

		FindNextFile(FileHandle,&FindFileData);
		WideCharToMultiByte( CP_ACP, 0, FindFileData.cFileName, -1,filename, sizeof(filename), NULL, NULL );
	}
	return;
}

void applyFeature(trainData oriData)
{
	//vector<int> uniMap = buildUniMap();
	//lbp(oriData, uniMap, "LBP");

	hog(oriData,"HOG");
}

