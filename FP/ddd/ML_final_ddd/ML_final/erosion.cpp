
#include <iostream>
#include <opencv2\opencv.hpp>
#include "tool.h"

using namespace cv;
using namespace std;

struct Kernel
{
    int kCols;
    int kRows; 
    int anchorX;
    int anchorY; 
	Mat values;
	Kernel(int cols, int rows, int ancx, int ancy, Mat val)
		:kCols(cols), kRows(rows), anchorX(ancx), anchorY(ancy), values(val.clone())
	{
	}
};

void grayPixelEro( const Mat src, Mat dst, const Kernel ker, int sI, int sJ )
{
	uchar grayMin=src.at<uchar>(sI,sJ);
	for (int kI = 0; kI < ker.kRows; kI++)
	{
		for (int kJ = 0; kJ < ker.kCols; kJ++)
		{
			int sX=sI+(kI-ker.anchorX);
			int sY=sJ+(kJ-ker.anchorY);
			if (sX>=0 && sX<=src.rows-1 &&
				sY>=0 && sY<=src.cols-1)
			{
				if (ker.values.at<uchar>(kI,kJ)==255)
				{
					grayMin=(uchar)min((int)grayMin,(int)src.at<uchar>(sX,sY));
					dst.at<uchar>(sI,sJ)=grayMin;
				}
			}			
		}
	}
}

void grayErosion( const Mat src, Mat dst, const Kernel ker )
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
			//erosion
			grayPixelEro(src, dst, ker, sI, sJ);
		}
	}
}

Mat imgErosion(Mat oriData)
{
	Mat img = oriData;
	if(img.empty())
	{
		cout<<"error"<<endl;
	}

	uchar kValArr[]={0,  255,0,
					 255,255,255,
					 0,  255,0  };
	
	Mat kVal=Mat(3,3,CV_8UC1,kValArr).clone();
	Kernel ker(3, 3, 1, 1, kVal);

	Mat imgGrayErosion( img.rows,img.cols, CV_8UC1, Scalar(0) );
	grayErosion( img, imgGrayErosion, ker );

	Mat result;
	result=imgGrayErosion;

	return result;
}