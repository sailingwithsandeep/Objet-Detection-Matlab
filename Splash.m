function varargout = Splash(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Splash_OpeningFcn, ...
                   'gui_OutputFcn',  @Splash_OutputFcn, ...
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


function Splash_OpeningFcn(hObject, eventdata, handles, varargin)
im = imread('sp.png');
axes(handles.axes1);
imshow(im);
e = '';
fpu = fopen('signup_dt.txt','r');
fpi = fopen('signin_dt.txt','r');

sigin = fscanf(fpi,'%s');
sigup = fscanf(fpu,'%s');
if strcmp(e,sigin) && strcmp(e,sigup)
    open SignIn.fig;
   
else
    open Hologram_Analysis.fig;
end

handles.output = hObject;

guidata(hObject, handles);

function varargout = Splash_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
