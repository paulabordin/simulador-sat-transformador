function varargout = curvasaturacao(varargin)
% CURVASATURACAO MATLAB code for curvasaturacao.fig
%      CURVASATURACAO, by itself, creates a new CURVASATURACAO or raises the existing
%      singleton*.
%
%      H = CURVASATURACAO returns the handle to a new CURVASATURACAO or the handle to
%      the existing singleton*.
%
%      CURVASATURACAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CURVASATURACAO.M with the given input arguments.
%
%      CURVASATURACAO('Property','Value',...) creates a new CURVASATURACAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before curvasaturacao_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to curvasaturacao_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help curvasaturacao

% Last Modified by GUIDE v2.5 08-Apr-2017 23:31:11

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @curvasaturacao_OpeningFcn, ...
                   'gui_OutputFcn',  @curvasaturacao_OutputFcn, ...
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


% --- Executes just before curvasaturacao is made visible.
function curvasaturacao_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to curvasaturacao (see VARARGIN)

% Choose default command line output for curvasaturacao
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes curvasaturacao wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = curvasaturacao_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, ~, ~)
% hObject    handle to uitable3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
data = get(hObject,'data');

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(~, ~, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% Curva de saturação obtida através do ensaio do TC
fh=figure(1)
data=get(handles.uitable3,'data');                  %Dados inseridos na tabela (I x V)
radiobutton1 = get(handles.radiobutton1, 'Value');  
radiobutton2 = get(handles.radiobutton2, 'Value');

save('curvasaturacao','data','radiobutton1','radiobutton2');

tab_data=str2double(data);
iensaio=tab_data(:,1);
vensaio=tab_data(:,2);

Vtc=str2double(get(handles.edit1,'String')); %Vtc --> tensão do transformador de corrente

%Cálculo da Curva de saturação estimada através do método do joelho
i1=2.5/Vtc;
v1=Vtc/13;
i2=25/Vtc;
v2=Vtc;
i3=25000/Vtc;
v3=1.5*Vtc;

iestimada=[i1 i2 i3];
vestimada=[v1 v2 v3];

dados_curva_saturacao = getappdata(0,'tab_data');
usar_ensaio = dados_curva_saturacao;

h = axes;
if usar_ensaio==0
    loglog(h,1000*iestimada,yvestimada,'Color','b','LineWidth',3);
    hold(h,'on');
    loglog(h,iensaio,vensaio,'Color',[.5 .5 .5],'Marker','+','MarkerSize',10,'LineStyle','-','LineWidth',3);
    legend(h,['Estimado 10B' num2str(Vtc)],'Curva do Ensaio', 'Location','southeast');
else
    loglog(h,iensaio,vensaio,'Color','b','Marker','+','MarkerSize',10,'LineWidth',3);
    hold(h,'on');
    loglog(h,1000*iestimada,vestimada,'Color',[.5 .5 .5],'LineStyle','-','LineWidth',3);
    legend(h,'Curva do Ensaio',['Estimado 10B' num2str(Vtc)], 'Location','southeast');
end

xlabel(h,'mili-Amperes'); ylabel(h,'Volts'); title(h,'Curva de Saturação');
grid(h,'on');
set(h,'Color',[.98 .98 .95],'XColor',.1*[1 1 1],'YColor',.1*[1 1 1]);
set(h,'GridLineStyle','-','MinorGridLineStyle','-');
hold on

   
% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(~, ~, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

% Gráfico da curva de saturação estimada pelo método do joelho (3 pontos)

fh=figure(1);

data=get(handles.uitable3,'data');                 
tab_data=str2double(data);                  %Dados inseridos na tabela (I x V)
radiobutton1 = get(handles.radiobutton1, 'Value');
radiobutton2 = get(handles.radiobutton2, 'Value');

save('curvasaturacao','data','radiobutton1','radiobutton2');

iensaio=tab_data(:,1);
vensaio=tab_data(:,2);

Vtc=str2double(get(handles.edit1,'String'));    %Vtc --> tensão do transformador de corrente

%Cálculo da Curva de saturação estimada através do método do joelho
i1=2.5/Vtc;
v1=Vtc/13;
i2=25/Vtc;
v2=Vtc;
i3=25000/Vtc;
v3=1.5*Vtc;

iestimada=[i1 i2 i3];
vestimada=[v1 v2 v3];

dados_curva_saturacao = getappdata(0,'tab_data');
usar_ensaio = dados_curva_saturacao;

h = axes;
if usar_ensaio==0
    loglog(h,1000*iestimada,vestimada,'Color','b','LineWidth',3);
    hold(h,'on');
    loglog(h,iensaio,vensaio,'Color',[.5 .5 .5],'Marker','+','MarkerSize',10,'LineStyle','-','LineWidth',3);
    legend(h,['Estimado 10B' num2str(Vtc)],'Curva do Ensaio', 'Location','southeast');
else
    loglog(h,iensaio,vensaio,'Color','b','Marker','+','MarkerSize',10,'LineWidth',3);
    hold(h,'on');
    loglog(h,1000*iestimada,vestimada,'Color',[.5 .5 .5],'LineStyle','-','LineWidth',3);
    legend(h,'Curva do Ensaio',['Estimado 10B' num2str(Vtc)], 'Location','southeast');
end

xlabel(h,'mili-Amperes'); ylabel(h,'Volts'); title(h,'Curva de Saturação');
grid(h,'on');
set(h,'Color',[.98 .98 .95],'XColor',.1*[1 1 1],'YColor',.1*[1 1 1]);
set(h,'GridLineStyle','-','MinorGridLineStyle','-');
hold on
grid on

clear all
function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
