function varargout = download(varargin)
% DOWNLOAD MATLAB code for download.fig
%      DOWNLOAD, by itself, creates a new DOWNLOAD or raises the existing
%      singleton*.
%
%      H = DOWNLOAD returns the handle to a new DOWNLOAD or the handle to
%      the existing singleton*.
%
%      DOWNLOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOWNLOAD.M with the given input arguments.
%
%      DOWNLOAD('Property','Value',...) creates a new DOWNLOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before download_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to download_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help download

% Last Modified by GUIDE v2.5 26-Mar-2012 16:55:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @download_OpeningFcn, ...
                   'gui_OutputFcn',  @download_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before download is madeperiod_str visible.
function download_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to download (see VARARGIN)

% Choose default command line output for download
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes download wait for user response (see UIRESUME)
% uiwait(handles.figure1);period_str


% --- Outputs from this function are returned to the command line.
function varargout = download_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in downloadBtn.
function downloadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to downloadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  symbols = regexp(get(handles.symbol, 'String'), ',', 'split');
  start_date = get(handles.fromTxt, 'String');
  end_date = get(handles.toTxt, 'String');
  period_str = {'d', 'w', 'm'};
  period = period_str{get(handles.periodOpt, 'Value')};
  plot_data = fetchData(symbols, start_date, end_date, period);
  
  plot(plot_data);
  legend(symbols);
  
function symbol_Callback(hObject, eventdata, handles)
% hObject    handle to symbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of symbol as text
%        str2double(get(hObject,'String')) returns contents of symbol as a double


% --- Executes during object creation, after setting all properties.
function symbol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to symbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fromTxt_Callback(hObject, eventdata, handles)
% hObject    handle to fromTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromTxt as text
%        str2double(get(hObject,'String')) returns contents of fromTxt as a double


% --- Executes during object creation, after setting all properties.
function fromTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function toTxt_Callback(hObject, eventdata, handles)
% hObject    handle to toTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toTxt as text
%        str2double(get(hObject,'String')) returns contents of toTxt as a double


% --- Executes during object creation, after setting all properties.
function toTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in periodOpt.
function periodOpt_Callback(hObject, eventdata, handles)
% hObject    handle to periodOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns periodOpt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from periodOpt


% --- Executes during object creation, after setting all properties.
function periodOpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
