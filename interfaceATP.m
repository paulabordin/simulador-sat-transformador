function varargout = interfaceATP(varargin)
%INTERFACEATP M-file for interfaceATP.fig
%      INTERFACEATP, by itself, creates a new INTERFACEATP or raises the existing
%      singleton*.
%
%      H = INTERFACEATP returns the handle to a new INTERFACEATP or the handle to
%      the existing singleton*.
%
%      INTERFACEATP('Property','Value',...) creates a new INTERFACEATP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interfaceATP_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACEATP('CALLBACK') and INTERFACEATP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACEATP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaceATP

% Last Modified by GUIDE v2.5 09-Apr-2017 00:11:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaceATP_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaceATP_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before interfaceATP is made visible.
function interfaceATP_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to guide
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interfaceATP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaceATP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaceATP_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to guide
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(~, ~, ~)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%dlmread('tcsat_certo.m');
% load('TCs.m','-ascii')
% FigHandle = openfig('TCs.m','reuse','visible');


global Isc iprim isec rint rburden xint xburden classe comp_dc Vsc ins_falta ipref RTC

Isc=str2double(get(handles.edit13,'String'));
iprim=str2double(get(handles.Corrente_primario,'String'));
isec=str2double(get(handles.Corrente_secundario,'String'));
rint=str2double(get(handles.Resistencia_interna,'String'));
rburden=str2double(get(handles.edit18,'String'));
xint=str2double(get(handles.Reatancia_interna,'String'));
xburden=str2double(get(handles.edit19,'String'));
classe=str2double(get(handles.Classe,'String'));
comp_dc=str2double(get(handles.edit14,'String'));
Vsc=str2double(get(handles.edit8,'String'));
ins_falta=str2double(get(handles.edit16,'String'));
ipref=str2double(get(handles.edit17,'String'));
RTC=(iprim/isec)*isec;
   
% %==========================================================================
% %                     ESCRITA DO ARQUIVO MODELO ATP
% %==========================================================================

 a = tira_ext(meutccerto);
 a = [a '.atp'];
 fid = fopen('a.atp','w+'); % Abre arquivo .atp onde está o arquivo .m

fprintf(fid,'BEGIN NEW DATA CASE\n');
fprintf(fid,'C --------------------------------------------------------\n');
fprintf(fid,'C Gerado por ATC - UTFPR\n');
fprintf(fid,'C Gerado por Paula Bordin do Prado - Estudante de Engenharia Elétrica. \n');
fprintf(fid,'C TrabalHo de Conclusão de Curso - 2017.\n');
fprintf(fid,'C Escrito em MatLab por Paula Bordin do Prado - 2016/2017.\n');
fprintf(fid,'C --------------------------------------------------------\n');
fprintf(fid,'C  dT  >< Tmax >< Xopt >< Copt >\n');
fprintf(fid,'   1.E-5      .2     60.     60.\n');
fprintf(fid,'      50       1       1       1       1       0       0       1       0\n');
fprintf(fid,'C        1         2         3         4         5         6         7         8\n');
fprintf(fid,'C 345678901234567890123456789012345678901234567890123456789012345678901234567890\n');
fprintf(fid,'/BRANCH\n');
fprintf(fid,'C < n 1>< n 2><ref1><ref2>< R  >< L  >< C  >\n');
fprintf(fid,'C < n 1>< n 2><ref1><ref2>< R  >< A  >< B  ><Leng><><>0\n');
fprintf(fid,'  TRANSFORMER                         TX0001  1.E6                             0\n');

%Determina a classe de exatidão do TC (tensão secundária)
classe=str2double(get(handles.Classe,'String'));

%Gambiarra para converter os valores de tensão para fluxo
i1=(2.5/classe)*1.414;
v1=(classe/13)/266.573;
i2=(25/classe)*1.404;
v2=classe/266.573;
i3=(25000/classe)*1.887;
v3=(1.5*classe)/266.573;
 
iestimada=[i1 i2 i3];
vestimada=[v1 v2 v3];

load('curvasaturacao.mat') %Carrega os arquivos da tabela na interface

data=str2double(data);
iensaio=data(:,1);
vensaio=data(:,2);
tamanho=length(iensaio);

radiobutton1
radiobutton2

if radiobutton1==0      %Condição para curva de saturação estimada
    for k=1:length(iestimada)
           fprintf(fid,'   %#13f   %#13f\n',[iestimada(k) vestimada(k)]);
    end
     fprintf(fid,'            9999\n'); 
    
else 
     for k=1:tamanho    %Condição para curva de saturação usando os dados de ensaio (tabela)
           fprintf(fid,'   %#13f   %#13f\n',[iensaio(k) vensaio(k)]);
     end
     fprintf(fid,'            9999\n');
     
end

% resistencia interna do TC, e espiras do secundario
r = round(10000*rint)/10000;
x = round(10000*xint)/10000;
fprintf(fid,[' 1      XX0002            ' fmt(r,6) fmt(x,6) fmt(iprim,6) '\n']);

% resistencia interna (baixa) e espiras do primario
fprintf(fid,[' 2XX0022XX0016             1.E-8 1.E-5' fmt(isec,6) '\n']);
fprintf(fid,'C prim\n');

% Equivalente do sistema
if(ins_falta == 0)
    ins_falta = 0.0291667;
end

zeq = 1000*Vsc/ sqrt(3)/ Isc
req = round(10000 * cos(atan(comp_dc)) * zeq)/10000
xeq = round(10000 * sin(atan(comp_dc)) * zeq)/10000
fprintf(fid,['  XX0018XX0016            ' fmt(req,6) fmt(xeq,6) '                                         1\n']);

% resistencia de falta (fixada em .001 ohm):
fprintf(fid,'  XX0008                    .001                                               0\n');
fprintf(fid,'C sec\n');

% burden:
r = round(1000*rburden)/1000;
x = round(1000*xburden)/1000;
fprintf(fid,['  XX0002                  ' fmt(r,6) fmt(x,6) '                                         1\n']);
fprintf(fid,'/SWITCH\n');
fprintf(fid,'C < n 1>< n 2>< Tclose ><Top/Tde ><   Ie   ><Vf/CLOP ><  type  >\n');

% instante da falta
t0 = (0.0291667 + ins_falta * 1/60/360);
fprintf(fid,['  XX0022XX0008  ' fmt(t0,8) '        1.                                             0\n']);
fprintf(fid,'/SOURCE\n');

% tensao do sistema
vpico = 1000*Vsc*sqrt(2)/sqrt(3);
fprintf(fid,'C < n 1><>< Ampl.  >< Freq.  ><Phase/T0><   Isc   ><   T1   >< TSTART >< TSTOP  >\n');
fprintf(fid,['14XX0018 0' fmt(vpico,10) '       60.                                     -1.        1.\n']);

% prefalta. multiplicar por raiz de 2 pois as fontes sao em valor de pico.
ipre = 10*ipref*sqrt(2)/10;
fprintf(fid,['14XX0022-1-' fmt(ipre,6) '       60.                                     -1.        1.\n']);
fprintf(fid,'/OUTPUT\n');
fprintf(fid,'  XX0002\n');
fprintf(fid,'BLANK BRANCH\n');
fprintf(fid,'BLANK SWITCH\n');
fprintf(fid,'BLANK SOURCE\n');
fprintf(fid,'BLANK OUTPUT\n');
fprintf(fid,'BLANK PLOT\n');
fprintf(fid,'BEGIN NEW DATA CASE\n');
fprintf(fid,'BLANK\n');


fclose(fid);

% Inserção e cálculo do curto-circuito simétrico
set(handles.text64,'String',Isc);
set(handles.text63,'String',iprim/isec);
set(handles.text66,'String',rint+rburden);
set(handles.text68,'String',xint+xburden);
set(handles.text72,'String',classe);

valor1=((Isc/(iprim/isec))*((rint+rburden)+(xint+xburden)));
set(handles.edit25,'String',valor1);
valor2=classe;

if(valor1<valor2)
    disp('OK');
    set(handles.text50,'String','OK');
    set(handles.text50,'BackgroundColor','green');
else
    disp('FAIL')
    set(handles.text50,'String','FAIL');
    set(handles.text50,'BackgroundColor','red');
end

% Inserção dos valores e cálculo do curto-circuito assimétrico
set(handles.text95,'String',Isc);
set(handles.text96,'String',iprim/isec);
set(handles.text98,'String',rint+rburden);
set(handles.text100,'String',xint+xburden);
set(handles.text104,'String',classe);
set(handles.text106,'String',comp_dc);
valor1=((Isc/(iprim/isec))*((rint+rburden)+(xint+xburden))*(comp_dc+1))
set(handles.edit24,'String',valor1);
valor2=classe;

if(valor1<valor2)
    disp('OK');
    set(handles.text34,'String','OK');
    set(handles.text34,'BackgroundColor','green');
else
    disp('FAIL')
    set(handles.text34,'String','FAIL');
    set(handles.text34,'BackgroundColor','red');
end

rodar_atp(a);
rodar_arquivoatp();


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, ~)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rcabo


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(~, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla
rodar_converter


% %==========================================================================
% %           CARREGAR OS SINAIS DE TENSÃO E CORRENTE PARA ANÁLISE
% %==========================================================================
iprim=str2double(get(handles.Corrente_primario,'String'));
isec=str2double(get(handles.Corrente_secundario,'String'));
RTC=(iprim/isec);
open a.MAT;

filein = 'a.MAT';

%---------------- CARREGA OS DADOS DA SITUAÇÃO FALTOSA -------------------%

dadosin = load(filein);

time = dadosin.t; %dados da matriz do arquivo .pl4
fn = round((1/time(2))/2);% encontra a frequencia de amostragem

global P S
Iprim = (dadosin.iXx0018Xx0016) ;
Isec = (dadosin.iXx0002Terra);
Isecref = Isec*RTC;
x=xlabel('Tempo (s)');
y=ylabel('Corrente (A)');
xlim([0,0.2]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
legend('Iprim','Isec_r_e_f_p_r_i','Location','north','Orientation','horizontal');
ca=0;
cd=6;
set(handles.edit21,'String',ca);
set(handles.edit22,'String',cd);

function edit25_Callback(~, ~, ~)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, ~, ~)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simetrico.
function simetrico_Callback(~, ~, handles)
% hObject    handle to simetrico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Isc iprim isec rint rburden xint xburden classe comp_dc Vsc ins_falta ipref
Isc=str2double(get(handles.edit13,'String')); %curto - Icurto
iprim=str2double(get(handles.Corrente_primario,'String')); % caracteristica do tc - segundo retangulo
isec=str2double(get(handles.Corrente_secundario,'String')); % caracteristica do tc  - terceiro retangulo
rint=str2double(get(handles.Resistencia_interna,'String')) % caracteristica do tc  - quarto retangulo
rburden=str2double(get(handles.edit18,'String')); % Zburden - primeiro retangulo
xint=str2double(get(handles.Reatancia_interna,'String')); % caracteristica do tc - quinto retangulo
xburden=str2double(get(handles.edit19,'String')); % zburden - segundo retangulo
classe=str2double(get(handles.Classe,'String')); % caracteristica do tc - classe
comp_dc=str2double(get(handles.edit14,'String')); % curto - X/R
Vsc=str2double(get(handles.edit8,'String')); % curto - tensão
ins_falta=str2double(get(handles.edit16,'String')); % curto - instante da falta
ipref=str2double(get(handles.edit17,'String')); % curto - I pre-falta

% Inserção e cálculo do curto-circuito simétrico
set(handles.text64,'String',Isc);
set(handles.text63,'String',iprim/isec);
set(handles.text66,'String',rint+rburden);
set(handles.text68,'String',xint+xburden);
set(handles.text72,'String',classe);

valor1=((Isc/(iprim/isec))*((rint+rburden)+(xint+xburden)))
set(handles.edit25,'String',valor1);
valor2=classe;

if(valor1<valor2)
    disp('OK');
    set(handles.text50,'String','OK');
    set(handles.text50,'BackgroundColor','green');
else
    disp('FAIL')
    set(handles.text50,'String','FAIL');
    set(handles.text50,'BackgroundColor','red');
end



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla

% %==========================================================================
% %           CARREGAR OS SINAIS DE TENSÃO E CORRENTE PARA ANÁLISE
% %==========================================================================
% 

open a.MAT;

filein = 'a.MAT';


%---------------- CARREGA OS DADOS DA SITUAÇÃO FALTOSA -------------------%

dadosin = load(filein);

% Replota o gráfico simulado de acordo com o ciclo escolhido pelo usuario
% Ciclo antes e depois da ocorrência da falta

time = dadosin.t; 
fn = round((1/time(2))/2);% encontra a frequencia de amostragem


ca=str2double(get(handles.edit21,'String'));
cd=str2double(get(handles.edit22,'String'));

global P S
Iprim = (dadosin.iXx0018Xx0016);
Isec = (dadosin.iXx0002Terra);
rtc = 120;
Isecref = Isec*rtc;
x=xlabel('Tempo (s)');
y=ylabel('Corrente (A)');


if ca==1 && cd==1
axis([0,0.04,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

% Um ciclo antes e 1,2,3..9 ciclos depois
if ca==1 && cd==1
axis([0,0.04,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==2
axis([0,0.06,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==3
axis([0,0.08,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==4
axis([0,0.1,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==5
axis([0,0.12,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==6
axis([0,0.14,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==7
axis([0,0.16,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==8
axis([0,0.18,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==1 && cd==9
axis([0,0.2,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

% Nenhum ciclo antes e 1,2,3..9 ciclos depois
if ca==0 && cd==1
axis([0.02,0.04,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==2
axis([0.02,0.06,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==3
axis([0.02,0.08,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==4
axis([0.02,0.1,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==5
axis([0.02,0.12,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==6
axis([0.02,0.14,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end
if ca==0 && cd==7
axis([0.02,0.16,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==8
axis([0.02,0.18,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

if ca==0 && cd==9
axis([0.02,0.2,-30000,30000]);
P = plot(time,Iprim,'red');
hold on
S = plot(time,Isecref,'blue');
grid on
end

% if ca==2 && cd==2
% axis([0.04,0.06,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==3
% axis([0.04,0.08,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==4
% axis([0.04,0.1,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==5
% axis([0.04,0.12,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==6
% axis([0.04,0.14,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% if ca==2 && cd==7
% axis([0.04,0.16,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==8
% axis([0.04,0.18,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
% 
% if ca==2 && cd==9
% axis([0.04,0.2,-30000,30000]);
% P = plot(time,Iprim,'red');
% hold on
% S = plot(time,Isecref,'blue');
% grid on
% end
legend('Corrente do primário','Corrente do secundário','Location','southeast');

function edit21_Callback(~, ~, ~)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, ~, ~)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(~, ~, ~)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, ~, ~)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(~, ~, ~)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, ~, ~)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(~, ~, ~)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, ~, ~)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(~, ~, ~)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, ~, ~)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in assimetrico.
function assimetrico_Callback(~, ~, handles)
% hObject    handle to assimetrico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Isc=str2double(get(handles.edit13,'String'));
iprim=str2double(get(handles.Corrente_primario,'String'));
isec=str2double(get(handles.Corrente_secundario,'String'));
rint=str2double(get(handles.Resistencia_interna,'String'));
rburden=str2double(get(handles.edit18,'String'));
xint=str2double(get(handles.Reatancia_interna,'String'));
xburden=str2double(get(handles.edit19,'String'));
classe=str2double(get(handles.Classe,'String'));
comp_dc=str2double(get(handles.edit14,'String'));
Vsc=str2double(get(handles.edit8,'String'));
ins_falta=str2double(get(handles.edit16,'String'));
ipref=str2double(get(handles.edit17,'String'));

% Inserção dos valores e cálculo do curto-circuito assimétrico
set(handles.text95,'String',Isc);
set(handles.text96,'String',iprim/isec);
set(handles.text98,'String',rint+rburden);
set(handles.text100,'String',xint+xburden);
set(handles.text104,'String',classe);
set(handles.text106,'String',comp_dc);
valor1=((Isc/(iprim/isec))*((rint+rburden)+(xint+xburden))*(comp_dc+1))
set(handles.edit24,'String',valor1);
valor2=classe;

if(valor1<valor2)
    disp('OK');
    set(handles.text34,'String','OK');
    set(handles.text34,'BackgroundColor','green');
else
    disp('FAIL')
    set(handles.text34,'String','FAIL');
    set(handles.text34,'BackgroundColor','red');
end



function edit8_Callback(~, ~, ~)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, ~, ~)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(~, ~, ~)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, ~, ~)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(~, ~, ~)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, ~, ~)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(~, ~, ~)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, ~, ~)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(~, ~, ~)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, ~, ~)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Classe_Callback(~, ~, ~)
% hObject    handle to Classe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Classe as text
%        str2double(get(hObject,'String')) returns contents of Classe as a double


% --- Executes during object creation, after setting all properties.
function Classe_CreateFcn(hObject, ~, ~)
% hObject    handle to Classe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Corrente_primario_Callback(~, ~, ~)
% hObject    handle to Corrente_primario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Corrente_primario as text
%        str2double(get(hObject,'String')) returns contents of Corrente_primario as a double


% --- Executes during object creation, after setting all properties.
function Corrente_primario_CreateFcn(hObject, ~, ~)
% hObject    handle to Corrente_primario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Corrente_secundario_Callback(~, ~, ~)
% hObject    handle to Corrente_secundario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Corrente_secundario as text
%        str2double(get(hObject,'String')) returns contents of Corrente_secundario as a double


% --- Executes during object creation, after setting all properties.
function Corrente_secundario_CreateFcn(hObject, ~, ~)
% hObject    handle to Corrente_secundario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Resistencia_interna_Callback(~, ~, ~)
% hObject    handle to Resistencia_interna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Resistencia_interna as text
%        str2double(get(hObject,'String')) returns contents of Resistencia_interna as a double


% --- Executes during object creation, after setting all properties.
function Resistencia_interna_CreateFcn(hObject, ~, ~)
% hObject    handle to Resistencia_interna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Reatancia_interna_Callback(~, ~, ~)
% hObject    handle to Reatancia_interna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Reatancia_interna as text
%        str2double(get(hObject,'String')) returns contents of Reatancia_interna as a double


% --- Executes during object creation, after setting all properties.
function Reatancia_interna_CreateFcn(hObject, ~, ~)
% hObject    handle to Reatancia_interna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, ~)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curvasaturacao



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(~, ~, ~)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



% --- Executes during object deletion, before destroying properties.
function axes1_DeleteFcn(~, ~, ~)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(~, ~, ~)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(~, ~, ~)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function axes9_CreateFcn(~, ~, ~)
% hObject    handle to axes9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes9

%Logotipo da UTFPR
a = imread('normal.jpg');
imshow(a);
axis off
