function varargout = SignIn(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignIn_OpeningFcn, ...
                   'gui_OutputFcn',  @SignIn_OutputFcn, ...
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


function SignIn_OpeningFcn(hObject, eventdata, handles, varargin)
global u
fp = fopen('Signin_dt.txt','w');
fprintf(fp,'%s',u);
fclose(fp);
handles.output = hObject;

guidata(hObject, handles);

function varargout = SignIn_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function btn_confirm_Callback(hObject, eventdata, handles)
global u  
    u = get(handles.uname,'String');
    p = get(handles.pwd,'String');
 
    handles.fig = figure(SignIn);
    
    javaaddpath('E:\HP_IMP\mysql-connector.jar')
    jdbcString = ['jdbc:mysql://localhost:3306/' 'hologram_analysis'];
    jdbcDriver = 'com.mysql.jdbc.Driver';
    conn = database('hologram_analysis', 'root' ,'', jdbcDriver, jdbcString); 
    if isconnection(conn)
        dt = exec(conn,'select username,password from hg_user');
        dt = fetch(dt);
        data = dt.Data;
        
        validUser = false;
        for i=1:length(data)
            us = data{i,1};
            pw = data{i,2};
            if strcmp(us,u) && strcmp(pw,p)
                validUser = true;
             break;
            end
        end
        if validUser
            open Hologram_Analysis.fig;
            close(handles.fig);
        else
            msgbox('Invalid Password');
        end
      else
          display('MySql Connection Error');
      end
        close(conn);
 

function btn_cancel_Callback(hObject, eventdata, handles)

function uname_Callback(hObject, eventdata, handles)

function uname_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Signup_ButtonDownFcn(hObject, eventdata, handles)
handles.fig = figure(SignIn);
open SignUp.fig
close(handles.fig);
