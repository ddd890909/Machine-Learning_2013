#include "yokoi.h"
//�����@�~�HopenCV��I/O���u��

//yokoi connectivity��f funtion
//5: interior  else: connected component number
int f(int a1, int a2, int a3, int a4){
	if(a1==2 && a2==2 && a3==2 && a4==2) return 5;
	else {
		int count=0;
		if(a1==1) count++;
		if(a2==1) count++;
		if(a3==1) count++;
		if(a4==1) count++;
		return count;
	}
}

//yokoi connectivity��h function
//1: transition  2: no transition  3: nothing
int h(uchar b, uchar c, uchar d, uchar e){
	if(b==c && (b!=d || b!=e)) return 1;
	else if(b==c && (b==d && b==e)) return 2;
	else return 3;
}

//yokoi connectivity���B�z
void yokoi(trainData oriData, char* fileName){
	int dim = 1;
	ofstream file;
	file.open (fileName, ios::out|ios::app);
	file << oriData.label;
	for(int m = 0; m < oriData.data.rows; m+=blockSize){
		for(int n = 0; n < oriData.data.cols; n+=blockSize){
			int hist[6];
			memset(hist, 0, 6*sizeof(int));
			cv::Mat patch = oriData.data(cv::Rect(n, m, blockSize, blockSize));
			for (int j = 0; j < patch.rows; j++) {
				uchar *ori = patch.data + j*patch.step;
				for (int i = 0; i < patch.cols; i++) {
					//Ū����I�h�i��B�z
					if((ori + i)[0]==255){
						int a1, a2, a3, a4;
						uchar x0, x1, x2, x3, x4, x5, x6, x7, x8;
						//�̦��N���I�M�P���I�̷өw�qassign��x0~x8
						x0 = (ori+i)[0];
						x1 = (ori+i+1)[0];
						x2 = (ori+i-patch.step)[0];
						x3 = (ori+i-1)[0];
						x4 = (ori+i+patch.step)[0];
						x5 = (ori+i+patch.step+1)[0];
						x6 = (ori+i-patch.step+1)[0];
						x7 = (ori+i-patch.step-1)[0];
						x8 = (ori+i+patch.step-1)[0];
						//�Y�W�X���, �h����0
						if(i == 0){
							x7 = 0;
							x3 = 0;
							x8 = 0;
						}
						if(i == patch.cols-1){
							x6 = 0;
							x1 = 0;
							x5 = 0;
						}
						if(j == 0){
							x7 = 0;
							x2 = 0;
							x6 = 0;
						}
						if(j == patch.rows-1){
							x8 = 0;
							x4 = 0;
							x5 = 0;
						}
						//�p��4-connected��yokoi connectivity number
						a1 = h(x0, x1, x6, x2);
						a2 = h(x0, x2, x7, x3);
						a3 = h(x0, x3, x8, x4);
						a4 = h(x0, x4, x5, x1);
						int y = f(a1, a2, a3, a4);
						//�N���Goutput
						hist[y]++;
					}
					//�Y�����I�h��X�Ů沤�L
				}
				//��U�@�C
			}
			for(int hi = 0; hi<6; hi++){
				file << " " << dim << ":" << hist[hi];
				dim++;
			}
		}
	}
	file << endl;
	file.close();
}