function varargout = SignUp(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignUp_OpeningFcn, ...
                   'gui_OutputFcn',  @SignUp_OutputFcn, ...
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


function SignUp_OpeningFcn(hObject, eventdata, handles, varargin)
global u
fp = fopen('Signup_dt.txt','w');
fprintf(fp,'%s',u);
fclose(fp);
handles.output = hObject;
guidata(hObject, handles);


function varargout = SignUp_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function btn_confirm_Callback(hObject, eventdata, handles)
global u
    f = get(handles.fname,'String');
    l = get(handles.lname,'String');  
    u = get(handles.uname,'String');
    p = get(handles.pwd,'String');
    e = get(handles.email,'String');
    ci = get(handles.city,'String');
    co = get(handles.country,'String');
    g = get(get(handles.gender,'SelectedObject'),'Tag');
    handles.fig = figure(SignUp);
    javaaddpath('E:\HP_IMP\mysql-connector.jar');
    jdbcString = ['jdbc:mysql://localhost:3306/' 'hologram_analysis'];
    jdbcDriver = 'com.mysql.jdbc.Driver';
    conn = database('hologram_analysis', 'root' ,'', jdbcDriver, jdbcString); 
    if isconnection(conn)
          cln_name = {'username','firstname','lastname','email_id','password','gender','city','country'};
          data = {u f l e p g ci co};
          datainsert(conn,'hg_user',cln_name,data);
          open Hologram_Analysis.fig
          close(handles.fig);
    else
          display('MySql Connection Error');
    end
    
    
function btn_cancel_Callback(hObject, eventdata, handles)

function signin_ButtonDownFcn(hObject, eventdata, handles)
handles.fig = figure(SignUp);
open SignIn.fig
close(handles.fig);