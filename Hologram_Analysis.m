function varargout = Hologram_Analysis(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hologram_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @Hologram_Analysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function Hologram_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Hologram_Analysis_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function fetching_Callback(hObject, eventdata, handles)

function webcamera_Callback(hObject, eventdata, handles)
global vid
vid = videoinput('winvideo',1);
axes(handles.axes1);
himg = image(zeros(180,200,3),'Parent',handles.axes1);
preview(vid,himg);


function apply_filter_Callback(hObject, eventdata, handles)


function obj_view_Callback(hObject, eventdata, handles)
global img
global mx
global f
global count
s = imsharpen(rgb2gray(img));
bw = im2bw(s);
f = imfill(bw,'holes');

label = bwlabel(f);
mx = max(max(label));

for j=1:mx
  [row,col] = find(label==j)
   len = max(row)-min(row)+2;
   breadth = max(col)-min(col)+2;
   target=uint8(zeros([len breadth]));
   sy = min(col)-1;
   sx = min(row)-1;
 
   for i=1:size(row,1)
        x = row(i,1)-sx;
        y = col(i,1)-sy;
        target(x,y)=s(row(i,1),col(i,1));
   end
end
count = 1;
img = (label == count);
img = uint8(img*255);
imshow(img);

function nxt_obj_Callback(hObject, eventdata, handles)
global mx
global f
global count
label = bwlabel(f);
count = count + 1; 
if mx >= 1
    img = (label == count)
end

img = uint8(255*img);
imshow(img);


function prev_obj_Callback(hObject, eventdata, handles)
global mx
global f
global count
label = bwlabel(f);
count = count - 1; 
if mx >= 1 
    img = (label == count)
end
img = uint8(255*img);
imshow(img);


function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);


function capture_Callback(hObject, eventdata, handles)
global vid
global img
img = getsnapshot(vid);
imshow(img);


function file_system_Callback(hObject, eventdata, handles)
global img
[filename,filepath]=uigetfile({'*.jpg'},'Select and image');
img = imread(strcat(filepath, filename));
imshow(img);


function save_image_Callback(hObject, eventdata, handles)
f= getframe(handles.axes1);
im = frame2im(f);
imwrite(im,'Image.jpg');
javaaddpath('E:\HP_IMP\mysql-connector.jar');
    jdbcString = ['jdbc:mysql://localhost:3306/' 'hologram_analysis'];
    jdbcDriver = 'com.mysql.jdbc.Driver';
    conn = database('hologram_analysis', 'root' ,'', jdbcDriver, jdbcString); 
    qry = exec(conn,'select USER_ID from hg_user');
    qry = fetch(qry);
    qry = qry.Data;
    result = qry{4,1}; 
    
    if isconnection(conn)
        cln_name = {'USER_ID','Image'};
          data = {result im};
          datainsert(conn,'hg_image',cln_name,data);
    end
    close(conn);
 
function cfilt(a)
    global img    
    imshow(rgb2gray(img),colormap(a));
   


function color_map_Callback(hObject, eventdata, handles)

function bw_Callback(hObject, eventdata, handles)
x = getimage(handles.axes1);
imshow(imbinarize(rgb2gray(x)));


function cwinter_Callback(hObject, eventdata, handles)
cfilt(winter);


function cbone_Callback(hObject, eventdata, handles)
cfilt(bone);


function cparula_Callback(hObject, eventdata, handles)
cfilt(parula);


function cjet_Callback(hObject, eventdata, handles)
cfilt(jet);


function chsv_Callback(hObject, eventdata, handles)
cfilt(hsv);


function chot_Callback(hObject, eventdata, handles)
cfilt(hot);


function ccool_Callback(hObject, eventdata, handles)
cfilt(cool);


function cspring_Callback(hObject, eventdata, handles)
cfilt(spring);


function csummer_Callback(hObject, eventdata, handles)
cfilt(summer);


function cautumn_Callback(hObject, eventdata, handles)
cfilt(autumn);


function cgray_Callback(hObject, eventdata, handles)
cfilt(gray);


function ccopper_Callback(hObject, eventdata, handles)
cfilt(copper);


function cprism_Callback(hObject, eventdata, handles)
cfilt(prism);


function cflag_Callback(hObject, eventdata, handles)
cfilt(flag);


function nfilter_Callback(hObject, eventdata, handles)
x = getimage(handles.axes1);
imshow(imnoise(x,'gaussian'));


function nrfilter_Callback(hObject, eventdata, handles)
imshow(medfilt3(getimage(handles.axes1)));


function clraxes_Callback(hObject, eventdata, handles)
cla(handles.axes1,'reset');


function contfilter_Callback(hObject, eventdata, handles)
g = rgb2gray(getimage(handles.axes1));
s = imsharpen(g);
imshow(imadjust(s));


function sfilter_Callback(hObject, eventdata, handles)
imshow(imsharpen(getimage(handles.axes1)));


function brfilter_Callback(hObject, eventdata, handles)

function lbrfilter_Callback(hObject, eventdata, handles)
i = getimage(handles.axes1);
imshow(i+50);


function hbrfilter_Callback(hObject, eventdata, handles)
i = getimage(handles.axes1);
imshow(i-50);


function blurfilter_Callback(hObject, eventdata, handles)
im = rgb2gray(getimage(handles.axes1));
x = fspecial('average',10);
i = filter2(x,im,'same');
imshow(i/255);

function convt_image_Callback(hObject, eventdata, handles)


function edgedect_Callback(hObject, eventdata, handles)
global img
s = getimage(handles.axes1);
i = edge(s,'canny');
imshow(uint8(i*255));

function capture3(handles)
global vid
global img1
global img2
himg1 = image(zeros(180,200,3),'Parent',handles.axes1);
preview(vid,himg1);
pause(2);
img1 = getsnapshot(vid);
imshow(img1);
pause(2);

himg2 = image(zeros(180,200,3),'Parent',handles.axes1);
preview(vid,himg2);
pause(2);
img2 = getsnapshot(vid);
imshow(img2);
pause(2);


function D3Convert_Callback(hObject, eventdata, handles)
capture3(handles);
global img
global img1
global img2

i1 = rgb2gray(img1);
i2 = rgb2gray(img2);
i3 = rgb2gray(img);

result = cat(3,i1,i3,i2);
imshow(result);
