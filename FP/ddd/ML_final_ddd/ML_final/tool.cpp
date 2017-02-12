
#include "tool.h"

cv::Mat binary(cv::Mat img, int threshold){
	cv::Mat result(img.rows, img.cols, img.type());

	for (int j = 0; j < result.rows; j++) {
		uchar *ori = img.data + j*img.step;
		uchar *rslt = result.data + j*result.step;
		for (int i = 0; i < result.cols; i++) {
			if((ori + i)[0] < threshold) (rslt + i)[0] = 0;
			else (rslt + i)[0] = 255;
		}
	}

	return result;
}

cv::Mat fitTo(cv::Mat oriImg, int width, int height)
{
	int finWidth, finHeight;
	double oriRatio = double(oriImg.rows) / oriImg.cols;
	double finRatio = double(height) / width;
	if(oriRatio > finRatio)
	{
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

