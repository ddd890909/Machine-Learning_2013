
#include <iostream>
#include <opencv2\opencv.hpp>
#include "tool.h"

using namespace cv;
using namespace std;

struct Kernel
{
    int kCols; //结构元素的行宽
    int kRows; //列高
    int anchorX; //结构原点位置水平坐标
    int anchorY; //结构原点位置垂直坐标
	Mat values;
	Kernel(int cols, int rows, int ancx, int ancy, Mat val)
		:kCols(cols), kRows(rows), anchorX(ancx), anchorY(ancy), values(val.clone())
	{
	}
};

void grayPixelDil( const Mat src, Mat dst, const Kernel ker, int sI, int sJ )
{
	double grayMax=src.at<double>(sI,sJ);
	for (int kI = 0; kI < ker.kRows; kI++)
	{
		for (int kJ = 0; kJ < ker.kCols; kJ++)
		{
			int sX=sI-(kI-ker.anchorX);
			int sY=sJ-(kJ-ker.anchorY);
			if (sX>=0 && sX<=src.rows-1 &&
				sY>=0 && sY<=src.cols-1)
			{
				if (ker.values.at<double>(kI,kJ)==1)
				{
					grayMax=(double)max( (double)grayMax, (double)src.at<double>(sX,sY) );
					dst.at<double>(sI,sJ)=grayMax;
				}
			}			
		}
	}
}

void grayDilation( const Mat src, Mat dst, const Kernel ker )
{
	if(ker.values.empty())
	{
		printf("error");
		return;
	}

	for (int sI = 0; sI < src.rows; sI++)
	{
		for (int sJ = 0; sJ < src.cols; sJ++)
		{
			//dilation
			grayPixelDil(src, dst, ker, sI, sJ);		
		}
	}
}

struct trainData imgDilation(trainData oriData)
{
	Mat img = oriData.data; 
	if(img.empty())
	{
		cout<<"error"<<endl;
	}
	//namedWindow("img",1); //創建窗口
	//imshow("img", img); //顯示圖

	
	double kValArr[]={0,1,1,1,0,
					 1,1,1,1,1,
					 1,1,1,1,1,
					 1,1,1,1,1,
					 0,1,1,1,0 };
	
	Mat kVal=Mat(5,5,CV_64FC1,kValArr).clone();
	Kernel ker(5, 5, 2, 2, kVal);

	Mat imgGrayDilation( img.cols, img.rows, CV_64FC1, Scalar(0) );
	grayDilation( img, imgGrayDilation, ker );

	struct trainData result;
	result.label=oriData.label;
	result.data=imgGrayDilation;
	
	//namedWindow("dilation",1);
	//imshow("dilation", imgGrayDilation);
	//imwrite("D:\\course\\CV\\HW\\hw5\\imgGrayDilation.bmp",imgGrayDilation);
	//waitKey();

	return result;
}