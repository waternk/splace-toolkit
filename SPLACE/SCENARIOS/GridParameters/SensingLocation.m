%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or � as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with the Licence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function varargout = SensingLocation(varargin)
% SENSINGLOCATION MATLAB code for SensingLocation.fig
%      SENSINGLOCATION, by itself, creates a new SENSINGLOCATION or raises the existing
%      singleton*.
%
%      H = SENSINGLOCATION returns the handle to a new SENSINGLOCATION or the handle to
%      the existing singleton*.
%
%      SENSINGLOCATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENSINGLOCATION.M with the given input arguments.
%
%      SENSINGLOCATION('Property','Value',...) creates a new SENSINGLOCATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SensingLocation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SensingLocation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SensingLocation

% Last Modified by GUIDE v2.5 30-May-2013 16:56:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SensingLocation_OpeningFcn, ...
                   'gui_OutputFcn',  @SensingLocation_OutputFcn, ...
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


% --- Executes just before SensingLocation is made visible.
function SensingLocation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SensingLocation (see VARARGIN)

    % Choose default command line output for SensingLocation
    handles.output = hObject;
    if ~isempty(varargin)
        handles.sensing = varargin{2};
    end
    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes SensingLocation wait for user response (see UIRESUME)
    % uiwait(handles.figure1);

    set(handles.figure1,'name','Sensing Location');
    % set(handles.figure1,'Position',[75 15 124.6 33.54]);

    SomeDataShared=get(0,'userdata');


    for i=1:length(SomeDataShared)
        data{i,1} = SomeDataShared{i,1};
        if SomeDataShared{i,2}
            data{i,2}= true;
            check(i) = data{i,2};
        else
            data{i,2}= false;
            check(i) = data{i,2};
        end
    end

    set(handles.uitable1, 'Data', data);

    if sum(check)==length(check)
        set(handles.selectAll,'Value',1);
    end

    if ~isempty(varargin)
        handles.B = varargin{1};
    end
    % Update handles structure
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SensingLocation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    data=get(handles.uitable1, 'Data');

    a=data(:,2);
    for i=1:size(a,1)
        b(i)=a{i};
    end
    b=sum(b);
    if b==0
        msgbox('           Select at list one');
        return
    end
    set(0,'userdata',data);


    set(handles.figure1,'visible','off');
    close;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.figure1,'visible','off');
close;

% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
% hObject    handle to selectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectAll
    set(handles.NonZero,'Value',0);

    check=get(handles.selectAll,'Value');

    if check
        handles.release(1:handles.B.CountNodes)={true};
    else
        handles.release(1:handles.B.CountNodes)={false};
    end

    for i=1:handles.B.CountNodes
        data{i,1} = handles.B.NodeNameID{i};
        data{i,2}= handles.release{i};
    end
    set(handles.uitable1, 'data', data);
    handles.data=data;
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in SelectNone.
function SelectNone_Callback(hObject, eventdata, handles)
% hObject    handle to SelectNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectNone


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    delete(hObject);


% --- Executes on button press in NonZero.
function NonZero_Callback(hObject, eventdata, handles)
% hObject    handle to NonZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NonZero
    set(handles.selectAll,'Value',0);
    
    bd=find(handles.B.NodeBaseDemands);
    
    check=get(handles.NonZero,'Value');
    if check
        for i=1:handles.B.CountNodes
            data{i,1} = handles.B.NodeNameID{i};
            if sum(find(bd==i)) 
                data{i,2}= true;
            else
                data{i,2}= false;
            end
        end
        set(handles.uitable1, 'data', data);
    else
        for i=1:handles.B.CountNodes
            data{i,1} = handles.B.NodeNameID{i};
            data{i,2}= false;
        end
        set(handles.uitable1, 'data', data);
    end
