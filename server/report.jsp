<%@ page import="java.io.*" %>
<html>
<head>
<title>Query from hadoop</title>
</head>
<body>
<% 
String lati=(String)request.getParameter("lati");
String lon=(String)request.getParameter("long");
String phone=request.getParameter("phone");
String type=request.getParameter("type");

double d_lati=100000.0*Float.parseFloat(lati);
double d_lon=100000.0*Float.parseFloat(lon);

int i_lati=(int)d_lati;
int i_lon=(int)d_lon;

lati=Integer.toString(i_lati);
lon=Integer.toString(i_lon);

String str=lati+" "+lon+"\n";

RandomAccessFile rf=new RandomAccessFile("/usr/local/hadoop/build/webapps/task/data.txt","rw");
rf.seek(rf.length());
rf.write(str.getBytes());
rf.close();

%>
<RES>OK</RES>
</body>
</html>
