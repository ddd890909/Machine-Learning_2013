
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
	uchar grayMax=src.at<uchar>(sI,sJ);
	for (int kI = 0; kI < ker.kRows; kI++)
	{
		for (int kJ = 0; kJ < ker.kCols; kJ++)
		{
			int sX=sI-(kI-ker.anchorX);
			int sY=sJ-(kJ-ker.anchorY);
			if (sX>=0 && sX<=src.rows-1 &&
				sY>=0 && sY<=src.cols-1)
			{
				if (ker.values.at<uchar>(kI,kJ)==255)
				{
					grayMax=(uchar)max( (int)grayMax, (int)src.at<uchar>(sX,sY) );
					dst.at<uchar>(sI,sJ)=grayMax;
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

Mat imgDilation(Mat oriData)
{
	Mat img = oriData; 
	if(img.empty())
	{
		cout<<"error"<<endl;
	}

	
	uchar kValArr[]={0,  255,255,255,0,
					 255,255,255,255,255,
					 255,255,255,255,255,
					 255,255,255,255,255,
					 0,  255,255,255,0  };
	
	Mat kVal=Mat(5,5,CV_8U,kValArr).clone();
	Kernel ker(5, 5, 2, 2, kVal);

	Mat imgGrayDilation( img.rows, img.cols,CV_8U, Scalar(0) );
	grayDilation( img, imgGrayDilation, ker );

	Mat result;
	result=imgGrayDilation;


	return result;
}