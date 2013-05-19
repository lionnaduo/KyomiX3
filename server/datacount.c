#include <stdio.h>

#define DEFAULT_RATIO 100000
int main(){
  int lat_new=0;
	int lon_new=0;
	int lat_last=0;
	int lon_last=0;
	float lat=0.0;
	float lon=0.0;
	int step=0;
	int count=0;

	FILE *sfp,*dfp;

	if((sfp=fopen("/usr/local/hadoop/bin/part-r-00000","r"))==NULL){
		printf("source file can't be opened!\n");
		return(-1);
	}
	if((dfp=fopen("/usr/local/hadoop/bin/output.html","w"))==NULL){
		printf("dest file can't be opened!\n");
		return(-1);
	}
	if(!feof(sfp)){
		fscanf(sfp,"%d\t%d",&lat_last,&lon_last);
		step=1;
		count=1;
	}
	while(!feof(sfp)){
		fscanf(sfp,"%d\t%d",&lat_new,&lon_new);
		if((lat_new==lat_last)&&(lon_new==lon_last)){
			count++;
		}
		else{
			lat=(float)lat_last/DEFAULT_RATIO;
			lon=(float)lon_last/DEFAULT_RATIO;
			if(step!=1)
				fprintf(dfp,",\n");
			fprintf(dfp,"[\'D%d\',%f,%f,\'%d\',%d]",step,lat,lon,step,count);
			lat_last=lat_new;
			lon_last=lon_new;
			lat_new=lon_new=0;
			count=1;
			step++;
		}
		lat_new=lon_new=0;
	}
	if((count!=0)&&(lat_last!=0)&&(lon_last!=0)){
		//step++;
		lat=(float)lat_last/DEFAULT_RATIO;
		lon=(float)lon_last/DEFAULT_RATIO;
		fprintf(dfp,",\n[\'D%d\',%f,%f,\'%d\',%d]",step,lat,lon,step,count);
	}
	return 0;
}
