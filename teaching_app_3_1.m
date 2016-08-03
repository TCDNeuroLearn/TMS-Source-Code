function varargout = teaching_app_3_1(varargin)
%TEACHING_APP_3_1 M-file for teaching_app_3_1.fig
%      TEACHING_APP_3_1, by itself, creates a new TEACHING_APP_3_1 or raises the existing
%      singleton*.
%
%      H = TEACHING_APP_3_1 returns the handle to a new TEACHING_APP_3_1 or the handle to
%      the existing singleton*.
%
%      TEACHING_APP_3_1('Property','Value',...) creates a new TEACHING_APP_3_1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to teaching_app_3_1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TEACHING_APP_3_1('CALLBACK') and TEACHING_APP_3_1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TEACHING_APP_3_1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teaching_app_3_1

% Last Modified by GUIDE v2.5 11-May-2016 12:59:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @teaching_app_3_1_OpeningFcn, ...
    'gui_OutputFcn',  @teaching_app_3_1_OutputFcn, ...
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


% --- Executes just before teaching_app_3_1 is made visible.
function teaching_app_3_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for teaching_app_3_1

handles.output = hObject;
clc;

ss=get(0,'screensize');         
w=ss(3);                %Screen width and height
h=ss(4);


p=get(handles.figure1,'Position');
width=p(3);
height=p(4);

set(handles.figure1,'Position',[w*1/8,h*2/16,width,height]);


%Load in plotting data for each subject
load('data.mat');


handles.tcdlogo=tcdlogo;    %Read in the close up view for axis2
%handles.tcdlogo=flipud(handles.tcdlogo);
axes(handles.logo)
image(handles.tcdlogo);
set(gca,'XTick',[],'YTick',[]);
box off
set(gca,'XColor',[1 1 1],'YColor',[1 1 1],'TickDir','out')


set(handles.pulse2,'Enable','off');



%String Array of Subject Data: Controls = 1 ALS =2 Multiple Sclerosis = 3 Stroke = 4
handles.data={' ' ' ' ' ' ' ';' ' ' ' ' ' ' ';' ' ' ' ' ' ' ';' ' ' ' ' ' ' '};
handles.MT=[46.6 42.5 72 85];           %Motor Threshold
handles.CMCT=[5.75 6.4 16.5 7.8];       %Central Motor Conduction Time
handles.MEP=[6.7 2.1 2 2.5];            %Motor Evoked Potentials
handles.MEP_var=[2.8 1.9 2.2 2];        %MEP variances
handles.SP=[124 114 209 402];           %Silent Period
handles.findMT=[0 0 0 0];
handles.findCMCT=[0 0 0 0];
handles.findMEP=[0 0 0 0];
handles.findSP=[0 0 0 0];
handles.bgcolors=[0.973 0.973 0.973;0.133 0.722 0.102];

handles.diagram_right=diagram_right;     %Different placements of TMS coil. Images
handles.diagram_left=diagram_left;
handles.diagram_right_contract=diagram_right_contract;

handles.subjects=struct('Controls',control,'ALS',ALS,'MS',MS,'Stroke',Stroke);

handles.TSTdata=TSTdata;
handles.TSTcontrol=TSTdata.control;
handles.TSTpatient=TSTdata.patient;
handles.PPTdata=PPTdata;

axes(handles.axes7);xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro'); 
axes(handles.axis2);xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');

axes(handles.diagram);
hold on;
image(handles.diagram_right);
[handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3,handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes teaching_app_3_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = teaching_app_3_1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in disease_type.
function disease_type_Callback(hObject, eventdata, handles)
% hObject    handle to disease_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns disease_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from disease_type


axes(handles.axes7)
cla
axes(handles.axis2)
cla

if handles.findMT(get(handles.disease_type,'Value'))            %Motor Threshold is already found for subject. Make visible all other parameter values
      
    set(handles.MT_value,'String',handles.data(get(handles.disease_type,'Value'),1));
    set(handles.MT_value,'BackgroundColor',[0.133 0.722 0.102])
    set(handles.CMCT_value,'String',handles.data(get(handles.disease_type,'Value'),2),'BackgroundColor',handles.bgcolors(handles.findCMCT(get(handles.disease_type,'Value'))+1,:),'Visible','on');
    set(handles.MEP_value,'String',handles.data(get(handles.disease_type,'Value'),3),'BackgroundColor',handles.bgcolors(handles.findMEP(get(handles.disease_type,'Value'))+1,:),'Visible','on');
    set(handles.SP_value,'String',handles.data(get(handles.disease_type,'Value'),4),'BackgroundColor',handles.bgcolors(handles.findSP(get(handles.disease_type,'Value'))+1,:),'Visible','on');
    set(handles.CMCT_text,'Visible','on');
    set(handles.MEP_text,'Visible','on');
    set(handles.SP_text,'Visible','on');
    set(handles.stim,'Enable','off');
    
    
else
    
    set(handles.CMCT_rb,'Value',1);
    set(handles.stim,'Enable','on');
    set(handles.MT_value,'BackgroundColor',[0.973 0.973 0.973],'String','');
    set(handles.CMCT_text,'Visible','off');
    set(handles.CMCT_value,'Visible','off','BackgroundColor',[0.973 0.973 0.973],'String','');
    set(handles.CMCT_rb,'Visible','off');
    set(handles.MEP_text,'Visible','off');
    set(handles.MEP_value,'Visible','off','BackgroundColor',[0.973 0.973 0.973],'String','');
    set(handles.MEP_rb,'Visible','off');
    set(handles.SP_text,'Visible','off');
    set(handles.SP_value,'Visible','off','BackgroundColor',[0.973 0.973 0.973],'String','');
    set(handles.SP_rb,'Visible','off');
    
end


set(handles.TST,'Value',0);

parameter_switch(hObject,handles);
paired_pulse(hObject,handles);



% --- Executes during object creation, after setting all properties.
function disease_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disease_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TST.
function TST_Callback(hObject, eventdata, handles)
% hObject    handle to TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST

%Set diagram to shows individual motor pathways
[handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);
state={'off' 'on'};
s=get(handles.TST,'Value');

set(handles.PPT_check,'Enable',state{2-s});
set(handles.erb_push,'Visible',state{s+1});
set(handles.wrist_push,'Visible',state{s+1});
set(handles.TST_push,'Visible',state{s+1});



% --- Executes on slider movement.
function stim_Callback(hObject, eventdata, handles)
% hObject    handle to stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.stim_text,'String',[int2str(get(handles.stim,'Value')*100) '%']);

% --- Executes during object creation, after setting all properties.
function stim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ulnar_stim.
function ulnar_stim_Callback(hObject, eventdata, handles)
% hObject    handle to ulnar_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disable(hObject,handles)

TMS_pulse3(hObject,handles);

Enable(hObject,handles);
axes(handles.axes7);
lines= findobj(gca,'Type','Animated Line');
blu=[115 200 255]/255;
if ~isempty(lines)
    if (length(lines)>1 || isequal(lines(1).Color,blu))     %Display Calculate CMCT button if both TMS pulse 1 and ulnar stim pulse are plotted
        
        set(handles.calculate_cmct2,'Visible','on')
        
    end
end
% --- Executes on button press in pulse1.
function pulse1_Callback(hObject, eventdata, handles)
% hObject    handle to pulse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if get(handles.PPT_check,'Value')               %Paired Pulse Technique. For Control subjects only. Illustrating the method rahter than showing patient parameters
    
    
    blu=[115 200 255]/255;
    time=0.02;
    p=handles.subjects.Controls.TMS_head;
    [~,I] = min(abs(handles.PPTdata(:,1)-get(handles.interval_slider,'Value')*20));     %Find the closest data point to the input of interval duration
    p(:,2)=p(:,2)*handles.PPTdata(I,2)/100;
    h1=handles.head1;
    a1=handles.arm1;
    
    axes(handles.axes7)
    lines=findobj(gca,'Type','Animated Line');
    delete(lines);
    G1=animatedline('Color',blu,'LineWidth',2);
    
    % Flashing Animation
    axes(handles.diagram)
    P1=animatedline('Color','r','Marker','h','MarkerSize',10,'MarkerFaceColor',[1 0.5 0.5],'MaximumNumPoints',1);
    
    addpoints(P1,270,550);
    pause(0.25)
    clearpoints(P1);
    pause(0.25)
    
    P1=animatedline('Color','b','Marker','h','MarkerSize',25,'MarkerFaceColor',blu,'MaximumNumPoints',1);
    addpoints(P1,270,550);
    pause(0.125)
    clearpoints(P1);
    
    P1=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
    
    for i=length(h1):-1:1
        
        addpoints(P1,h1(i,1),h1(i,2))
        addpoints(G1,p(length(h1)-i+1,1),p(length(h1)-i+1,2))
        pause(time)
        
    end
    
    clearpoints(P1)
    
    for i=1:length(a1)
        
        addpoints(P1,a1(i,1),a1(i,2))
        addpoints(G1,p(length(h1)+i,1),p(length(h1)+i,2))
        pause(time)
        
    end
    
    
    for i=(length(h1)+length(a1)+1):length(p)
        
        addpoints(G1,p(i,1),p(i,2));
        pause(time)
        
    end
    
    clearpoints(P1)
    
    
    axes(handles.axis2)
    hold on;
    scatter(handles.PPTdata(I,1),handles.PPTdata(I,2),'k','MarkerFaceColor','k');
    plot(handles.PPTdata(1:I,1),handles.PPTdata(1:I,2),'k','LineWidth',1.5);
    
    
    
else
    
    
    
    axes(handles.axes7)
    blu=[115 200 255]/255;
    
    disable(hObject,handles)
    
    TMS_pulse1(get(handles.TST,'Value'),hObject,handles);
    
    set(handles.MT_value,'String',[int2str(get(handles.stim,'Value')*100) '%']);
    
    %If the MT is in range of the correct value of it has been found
    %already for the given subject
    if (( get(handles.stim,'Value')*100>=handles.MT(get(handles.disease_type,'Value')) && get(handles.stim,'Value')*100<handles.MT(get(handles.disease_type,'Value'))+5) || handles.findMT(get(handles.disease_type,'Value')))

        handles.data(get(handles.disease_type,'Value'),1)={[int2str(handles.MT(get(handles.disease_type,'Value'))) '%']};

        set(handles.stim,'Value',handles.MT(get(handles.disease_type,'Value'))/100);
        
        set(handles.MT_value,'String',[handles.data(get(handles.disease_type,'Value'),1)]);
        set(handles.stim_text,'String',[handles.data(get(handles.disease_type,'Value'),1)]);
        set(handles.MT_value,'BackgroundColor',[0.133 0.722 0.102])
        set(handles.stim,'Enable','off');
        handles.findMT(get(handles.disease_type,'Value'))=1;
        
        set(handles.CMCT_text,'Visible','on');
        set(handles.CMCT_value,'Visible','on');
        set(handles.CMCT_rb,'Visible','on');
        
        set(handles.MEP_text,'Visible','on');
        set(handles.MEP_value,'Visible','on');
        set(handles.MEP_rb,'Visible','on');
        
        set(handles.SP_text,'Visible','on');
        set(handles.SP_value,'Visible','on');
        set(handles.SP_rb,'Visible','on');
        
        
        if ~get(handles.TST,'Value')
            
            parameter_switch(hObject,handles);
        end
        
        if get(handles.CMCT_rb,'Value')
            
            axes(handles.axes7);
            lines= findobj(gca,'Type','Animated Line');
            
            
            if length(lines)>1
                set(handles.calculate_cmct1,'Visible','on')
                
            end
            
            axes(handles.axis2)
            lines= findobj(gca,'Type','Animated Line');
            
            if ~isempty(lines)
                
                set(handles.calculate_cmct2,'Visible','on')
            end
            
        end
        guidata(hObject, handles);
        
    else
        
        set(handles.MT_value,'BackgroundColor',[0.784 0.075 0.114])
        
    end
    
    
    if get(handles.MEP_rb,'Value')
        pause(1);
        
        n = get(handles.disease_type,'Value');
        fields = fieldnames(handles.subjects);
        p=handles.subjects.(fields{n}).TMS_head;
        
        [y,i]=max(p(:,2));
        x=p(i,1);
        
        axes(handles.axes7);
        hold on;
        maxpoint=plot(x,y,'Marker','o','Color','r','MarkerFaceColor','r','MarkerSize',8);
        pause(1);
        handles.data(get(handles.disease_type,'Value'),3)={[num2str(handles.MEP(get(handles.disease_type,'Value'))) 'mV']};
        set(handles.MEP_value,'String',handles.data(get(handles.disease_type,'Value'),3),'BackgroundColor',[0.973 0.973 0.973],'ForegroundColor',[0 0 0]);
        pause(1);
        eb=errorbar(x,y,handles.MEP_var(get(handles.disease_type,'Value')),'Color','r','LineWidth',1);
        pause(1);
        

        v=handles.MEP_var(get(handles.disease_type,'Value'));
        handles.data(get(handles.disease_type,'Value'),3)={[num2str(handles.MEP(get(handles.disease_type,'Value'))) char(177) num2str(v) 'mV']};
        handles.findMEP(get(handles.disease_type,'Value'))=0;
        set(handles.MEP_value,'String',handles.data(get(handles.disease_type,'Value'),3));
        
        set(handles.MEP_value,'BackgroundColor',[0.784 0.075 0.114],'ForegroundColor',[1 1 1])
        handles.data(get(handles.disease_type,'Value'),3)={''};

        pause(1);
        delete(maxpoint);
        delete(eb);
        guidata(hObject,handles);
        
    end
    
    
    if get(handles.SP_rb,'Value')
        
        pause(1);
        axes(handles.axis2);
        hold on;
        n = get(handles.disease_type,'Value');
        fields = fieldnames(handles.subjects);
        p=handles.subjects.(fields{n}).SP;
        
        x1=p(146,1);
        
        
        i=find(p(146:end,2)>0.5,1,'first');
        x2=p(i+144,1);
        y1=-0.5;
        y2=-1;
        
        bracket=[x1 y1;x1 y2;x2 y2;x2 y1];
        
        plot(bracket(:,1),bracket(:,2),'r','LineWidth',2);
        
        text((x1+x2)/2,-1.4,'Silent Period','HorizontalAlignment','Center','Color','r','FontWeight','bold','FontName','Source Sans Pro','FontUnits','Normalized');
        pause(1);
        handles.findSP(get(handles.disease_type,'Value'))=1;
        handles.data(get(handles.disease_type,'Value'),4)={[num2str(handles.SP(get(handles.disease_type,'Value'))) 'ms']};
        set(handles.SP_value,'String',handles.data(get(handles.disease_type,'Value'),4));
        set(handles.SP_value,'BackgroundColor',[0.133 0.722 0.102],'ForegroundColor',[1 1 1])
        pause(1);
        guidata(hObject,handles);
    end
    
    Enable(hObject,handles)
    
end



% --- Executes on button press in pulse2.
function pulse2_Callback(hObject, eventdata, handles)
% hObject    handle to pulse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)

TMS_pulse2(get(handles.TST,'Value'),hObject,handles);
Enable(hObject,handles)

axes(handles.axes7)
lines= findobj(gca,'Type','Animated Line');


if length(lines)>1
    
    set(handles.calculate_cmct1,'Visible','on')
    
end

% --- Executes on button press in CMCT_rb.
function CMCT_rb_Callback(hObject, eventdata, handles)
% hObject    handle to CMCT_rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CMCT_rb

axes(handles.axes7);
cla

axes(handles.axis2)
cla

set(handles.TST,'Value',0);
parameter_switch( hObject, handles );

% --- Executes on button press in MEP_rb.
function MEP_rb_Callback(hObject, eventdata, handles)
% hObject    handle to MEP_rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MEP_rb

axes(handles.axes7);
cla

axes(handles.axis2)
cla

parameter_switch( hObject, handles );


% --- Executes on button press in SP_rb.
function SP_rb_Callback(hObject, eventdata, handles)
% hObject    handle to SP_rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SP_rb

axes(handles.axes7);
cla

axes(handles.axis2)
cla
set(handles.TST,'Value',0);

parameter_switch( hObject, handles );


% --- Executes on button press in erb_push.
function erb_push_Callback(hObject, eventdata, handles)
% hObject    handle to erb_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)
axes(handles.axes7);cla;

erb_pulse(hObject,handles);
Enable(hObject,handles)


% --- Executes on button press in wrist_push.
function wrist_push_Callback(hObject, eventdata, handles)
% hObject    handle to wrist_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)
axes(handles.axes7);cla;
wrist_pulse(hObject,handles);
Enable(hObject,handles)


% --- Executes on button press in TST_push.
function TST_push_Callback(hObject, eventdata, handles)
% hObject    handle to TST_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)

TST_pulse(hObject,handles);

n = get(handles.disease_type,'Value');
n=(n>1)+1;
fields = fieldnames(handles.TSTdata);
p=handles.TSTdata.(fields{n});

[y,i]=max(p(170:end,2));
x=p(i+170,1)-0.13;
axes(handles.axes7);
hold on;
maxpoint=plot(x,y,'Marker','o','Color','r','MarkerFaceColor','r','MarkerSize',8);
pause(1);
handles.data(get(handles.disease_type,'Value'),3)={[num2str(handles.MEP(get(handles.disease_type,'Value'))) 'mV']};
set(handles.MEP_value,'String',handles.data(get(handles.disease_type,'Value'),3),'BackgroundColor',[0.973 0.973 0.973],'ForegroundColor',[0 0 0]);
pause(1);
eb=errorbar(x,y,handles.MEP_var(get(handles.disease_type,'Value'))/2.5,'Color','r','LineWidth',1);
pause(1);

v=handles.MEP_var(get(handles.disease_type,'Value'))/2.5;
handles.data(get(handles.disease_type,'Value'),3)={[num2str(handles.MEP(get(handles.disease_type,'Value'))) char(177) num2str(v) 'mV']};
handles.findMEP(get(handles.disease_type,'Value'))=1;
set(handles.MEP_value,'String',handles.data(get(handles.disease_type,'Value'),3));
set(handles.MEP_value,'BackgroundColor',[0.133 0.722 0.102],'ForegroundColor',[1 1 1])
pause(1.5);
delete(maxpoint);
delete(eb);
guidata(hObject,handles);
Enable(hObject,handles)



% --- Executes on button press in calculate_cmct1.
function calculate_cmct1_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_cmct1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)
t1=arrow1(hObject,handles);
pause(0.5)
t2=arrow2(hObject,handles);
pause(0.5)

axes(handles.axes7)
yl=get(gca,'YLim');
equation=text(5,(0+yl(2))/2,['CMCT = T1 - T2'],'FontWeight','bold','Color',([115 200 255]/255),'FontName','Source Sans Pro');

pause(1)


handles.findCMCT(get(handles.disease_type,'Value'))=1;
handles.data(get(handles.disease_type,'Value'),2)={[num2str(handles.CMCT(get(handles.disease_type,'Value'))) 'ms']};
set(handles.CMCT_value,'String',handles.data(get(handles.disease_type,'Value'),2));
set(handles.CMCT_value,'BackgroundColor',[0.133 0.722 0.102])
pause(1);

lines= findobj(gca,'Type','Animated Line');
delete(lines(1:2))
delete(t1)
delete(t2)
delete(equation)

guidata(hObject,handles);
Enable(hObject,handles)


% --- Executes on button press in calculate_cmct2.
function calculate_cmct2_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_cmct2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disable(hObject,handles)

t1=arrow1(hObject,handles);
pause(0.5)
[t3,t4]=arrow3(hObject,handles);
pause(0.5)

axes(handles.axis2)
equation=text(20,1,['CMCT = T1 - (F+M-1)/2'],'FontWeight','bold','Color',[255 53 53]/255,'FontName','Source Sans Pro');

pause(1)

handles.findCMCT(get(handles.disease_type,'Value'))=1;
handles.data(get(handles.disease_type,'Value'),2)={[num2str(handles.CMCT(get(handles.disease_type,'Value'))) 'ms']};
set(handles.CMCT_value,'String',handles.data(get(handles.disease_type,'Value'),2));
set(handles.CMCT_value,'BackgroundColor',[0.133 0.722 0.102])
pause(1);

lines= findobj(gca,'Type','Animated Line');
delete(lines(1:2))
delete(t3)
delete(t4)
delete(equation)


axes(handles.axes7)
lines= findobj(gca,'Type','Animated Line');
delete(lines(1))
delete(t1)

guidata(hObject,handles);
Enable(hObject,handles)


% --- Executes on button press in PPT_check.
function PPT_check_Callback(hObject, eventdata, handles)
% hObject    handle to PPT_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
paired_pulse(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of PPT_check


% --- Executes on slider movement.
function interval_slider_Callback(hObject, eventdata, handles)
% hObject    handle to interval_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.stim_text,'String',[round(int2str(get(handles.interval_slider,'Value')*20)) 'ms']);

% --- Executes during object creation, after setting all properties.
function interval_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function t1=arrow1( hObject,handles )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

blu=[115 200 255]/255;

             n = get(handles.disease_type,'Value');
 fields = fieldnames(handles.subjects);
 p=handles.subjects.(fields{n}).TMS_head;

 x=find(p(40:length(p),2)>0.1,1,'first');
 x=p(x+40,1);
x=ones(15,1)*x;
y=linspace(-2.5,-0.5,15);

arrow1=[x';y]';
ahead=[x(1)+0.3 y(13); x(1)-0.3 y(13);x(1) y(15)];
arrow1=[arrow1;ahead];
 axes(handles.axes7);
A1=animatedline('Color',blu,'LineWidth',1.5);

for i=1:length(arrow1)
   
    addpoints(A1,arrow1(i,1),arrow1(i,2));
    pause(0.025);
    
end

t1=text(x(1)+0.7, y(2),'T1','FontWeight','bold','Color',blu,'FontName','Source Sans Pro');


function [ t2 ] = arrow2( hObject,handles )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

gren=[0.757 0.867 0.776];

             n = get(handles.disease_type,'Value');
 fields = fieldnames(handles.subjects);
p=handles.subjects.(fields{n}).TMS_shoulder;

 x=find(p(40:length(p),2)>0.1,1,'first');
 x=p(x+40,1);
x=ones(15,1)*x;
y=linspace(-2.5,-0.5,15);

arrow2=[x';y]';
ahead=[x(1)+0.3 y(13); x(1)-0.3 y(13);x(1) y(15)];
arrow2=[arrow2;ahead];
 axes(handles.axes7);
A2=animatedline('Color',gren,'LineWidth',1.5);

for i=1:length(arrow2)
   
    addpoints(A2,arrow2(i,1),arrow2(i,2));
    pause(0.025);
    
end

t2=text(x(1)+0.7, y(2),'T2','FontWeight','bold','Color',gren,'FontName','Source Sans Pro');


function [ t3, t4 ] = arrow3( hObject, handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
axes(handles.axis2)
redd=[255 53 53]/255;
   n = get(handles.disease_type,'Value');
 fields = fieldnames(handles.subjects);
 p=handles.subjects.(fields{n}).TMS_ulnar;

  xF=find(p(100:length(p),2)>0.1,1,'first');
 xF=p(xF+100,1);
xF=ones(15,1)*xF;
yF=linspace(-1.7,-0.5,15);
 
arrow1=[xF';yF]';
ahead=[xF(1)+0.3 yF(13); xF(1)-0.3 yF(13);xF(1) yF(15)];
arrow1=[arrow1;ahead];
 axes(handles.axis2);
A1=animatedline('Color',redd,'LineWidth',1.5);

for i=1:length(arrow1)
   
    addpoints(A1,arrow1(i,1),arrow1(i,2));
    pause(0.025);
    
end

t3=text(xF(1)+0.7, yF(2),'F','FontWeight','bold','Color',redd,'FontName','Source Sans Pro');

  xM=find(p(:,2)>0.1,1,'first');
 xM=p(xM,1);
xM=ones(15,1)*xM;
yM=linspace(-1.7,-0.5,15);
 
arrow2=[xM';yM]';
ahead=[xM(1)+0.3 yM(13); xM(1)-0.3 yM(13);xM(1) yM(15)];
arrow2=[arrow2;ahead];
 axes(handles.axis2);
A2=animatedline('Color',redd,'LineWidth',1.5);

for i=1:length(arrow2)
   
    addpoints(A2,arrow2(i,1),arrow2(i,2));
    pause(0.025);
    
end

t4=text(xM(1)+0.7, yM(2),'M','FontWeight','bold','Color',redd,'FontName','Source Sans Pro');

function disable( hObject, handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
set(handles.pulse1,'Enable','off');
set(handles.pulse2,'Enable','off');
set(handles.ulnar_stim,'Enable','off');
set(handles.erb_push,'Enable','off');
set(handles.wrist_push,'Enable','off');
set(handles.calculate_cmct1,'Enable','off');
set(handles.calculate_cmct2,'Enable','off');
set(handles.TST_push,'Enable','off');
set(handles.CMCT_rb,'Enable','off');
set(handles.MEP_rb,'Enable','off');
set(handles.SP_rb,'Enable','off');


function Enable( hObject, handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
set(handles.pulse1,'Enable','on');

if get(handles.CMCT_rb,'Value')
set(handles.pulse2,'Enable','on');
set(handles.ulnar_stim,'Enable','on');
end

set(handles.erb_push,'Enable','on');
set(handles.wrist_push,'Enable','on');
set(handles.calculate_cmct1,'Enable','on');
set(handles.calculate_cmct2,'Enable','on');
set(handles.TST_push,'Enable','on');
set(handles.CMCT_rb,'Enable','on');
set(handles.MEP_rb,'Enable','on');
set(handles.SP_rb,'Enable','on');


function erb_pulse( hObject,handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
blu=[115 200 255]/255;
redd=[255 53 53]/255;
time=0.02;
axes(handles.diagram)
P1=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P2=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P3=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);

   
e=handles.erb;

for i=1:length(e)
    
   addpoints(P1,e(i,1),e(i,2))
    pause(time)
    
end

clearpoints(P1);

    a1=handles.arm1;
    a2=handles.arm2;
    a3=handles.arm3;
    
    for i=1:length(a1)
        
        addpoints(P1,a1(i,1),a1(i,2))
        addpoints(P2,a2(i,1),a2(i,2))
        addpoints(P3,a3(i,1),a3(i,2))
        pause(time)
        
    end
    
    
    clearpoints(P1)
    clearpoints(P2)
    clearpoints(P3)
    
    function paired_pulse( hObject,handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if get(handles.PPT_check,'Value')
   
    set(handles.text16,'String','Interstimulus Interval')
        set(handles.text31,'Visible','on')
                set(handles.interval_slider,'Visible','on')
    set(handles.stim_text,'String',[int2str(round(get(handles.interval_slider,'Value')*20)) 'ms'])
set(handles.CMCT_rb,'Enable','off');
set(handles.MEP_rb,'Enable','off');
set(handles.SP_rb,'Enable','off');
set(handles.pulse2,'Enable','off');
set(handles.ulnar_stim,'Enable','off');
set(handles.calculate_cmct1,'Visible','off');
set(handles.calculate_cmct2,'Visible','off');


axes(handles.diagram);
cla;
hold on;
image(handles.diagram_left);
    [handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);

axes(handles.axis2);cla;
xlabel('Interstimulus Interval (ms)','FontName','Source Sans Pro');ylabel('Percentage of Control Size (%)','FontName','Source Sans Pro');xlim([0 20]);ylim([0 320]);
set(gca,'XTick',[0 5 10 15 20],'XTickLabel',[0 5 10 15 20],'YTick',[0 100 200 300 400 500],'YTickLabel',[0 100 200 300 400 500]);

axes(handles.axes7);cla;

   p = handles.subjects.Controls.TMS_head;
    plot(p(:,1),p(:,2),'r','LineWidth',2);
       xlabel('Time','FontName','Source Sans Pro'); ylabel('Voltage (mV)','FontName','Source Sans Pro'); ylim([-12 20]);xlim([0 30]);
    set(gca,'XTick',[0:5:30],'XTickLabel',[0:5:30],'YTick',[-10 -5 0 5 10 15 20],'YTickLabel',[-10 -5 0 5 10 15 20]);
    legend('Control TMS','Location', 'NorthWest');
    
    set(handles.TST,'Enable','off');

else
    
        set(handles.text16,'String','Stimulus Intensity')
        set(handles.text31,'Visible','off')
                set(handles.interval_slider,'Visible','off')
                    set(handles.stim_text,'String',[int2str(round(get(handles.stim,'Value')*100)) '%'])
set(handles.CMCT_rb,'Enable','on');
set(handles.MEP_rb,'Enable','on');
set(handles.SP_rb,'Enable','on');

if get(handles.CMCT_rb,'Value')
set(handles.pulse2,'Enable','on');
set(handles.ulnar_stim,'Enable','on');
end

if get(handles.MEP_rb,'Value')
   
    set(handles.TST,'Enable','on')
    
end

axes(handles.diagram);
cla;
hold on;

if get(handles.SP_rb,'Value')
image(handles.diagram_right_contract);

else
image(handles.diagram_right);
end

    [handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);

axes(handles.axis2);cla;
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');
set(gca,'XTick',[],'XTickLabel',[],'YTick',[],'YTickLabel',[]);

axes(handles.axes7);cla;
legend off
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');
set(gca,'XTick',[],'XTickLabel',[],'YTick',[],'YTickLabel',[]);


end


function parameter_switch( hObject, handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (get(handles.disease_type,'Value')==1 && handles.findMT(1)==1)
   
    set(handles.PPT_text,'Visible','on');
        set(handles.PPT_check,'Visible','on');

    
else
    
        set(handles.PPT_text,'Visible','off');
        set(handles.PPT_check,'Visible','off','Value',0);

    
end


state={'off' 'on'};

cmct=(get(handles.CMCT_rb,'Value') && handles.findMT(get(handles.disease_type,'Value')));
mep=(get(handles.MEP_rb,'Value')&& handles.findMT(get(handles.disease_type,'Value')));
sp=(get(handles.SP_rb,'Value')&& handles.findMT(get(handles.disease_type,'Value')));
tst=(get(handles.TST,'Value')&& handles.findMT(get(handles.disease_type,'Value')));

if sp

axes(handles.diagram);
cla;
hold on;
image(handles.diagram_right_contract);
    [handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);
else
   
    
axes(handles.diagram);
cla;
hold on;
image(handles.diagram_right);
    [handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);
    
end



if (tst)
  
        set(handles.TST,'Value',0);
    [handles.arm1, handles.arm2, handles.arm3, handles.head1, handles.head2, handles.head3, handles.erb, handles.wrist] = paths(get(handles.TST,'Value'),hObject,handles);


    
end

set(handles.pulse2,'Enable',state{cmct+1});
set(handles.ulnar_stim,'Visible',state{cmct+1});
set(handles.ulnar_stim,'Enable',state{cmct+1});
set(handles.calculate_cmct1,'Visible','off');
set(handles.calculate_cmct2,'Visible','off');
    set(handles.TST_push,'Visible',state{tst+1});
set(handles.TST,'Enable',state{mep+1});
    set(handles.erb_push,'Visible',state{tst+1});

    set(handles.wrist_push,'Visible',state{tst+1});
    set(handles.TST_push,'Visible',state{tst+1});
    
    
    function [ arm1, arm2, arm3, head1, head2,head3,erb,wrist ] = paths( TST, hObject, handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

axes(handles.diagram);
lines= findobj(gca,'Type','Line');      %Clear any previously existing plots
delete(lines);
r= findobj(gca,'Type','Rectangle');
delete(r);

scale=40;               
xoffset1=205;yoffset1=300;
xoffset2=220;yoffset2=300;
xoffset3=190;yoffset3=300;
xScale=32.5;
yScale=20;
axpoint1=[210,355,585,601,617]; aypoint1=[285,200,195,288.5,382];
axpoint2=[225 365 570 587.5 605]; aypoint2=[285 210 206 295.5 385];
axpoint3=[195 345 600 614.5 629]; aypoint3=[285 190 184 281.5 379];
erbxpoint=[430, 210]; erbypoint=[345 ,285];
wristxpoint=[690 617];wristypoint=[340 382];
numpoints=40;
numpoints2=40;
numpoints3=40;


if (get(handles.disease_type,'Value')==1 || ~TST)           %Define any blocked motor pathways by color    
    path_color=[1 0 0];   
else  
    path_color=[0 0 0];
end


if TST
    width=1;
else
    width=2;
end


erb=[linspace(erbxpoint(1),erbxpoint(2),numpoints3);linspace(erbypoint(1),erbypoint(2),numpoints3)]';
wrist=[linspace(wristxpoint(1),wristxpoint(2),numpoints3);linspace(wristypoint(1),wristypoint(2),numpoints3)]';

arm1_1=[linspace(axpoint1(3), axpoint1(4),numpoints2/3);linspace(aypoint1(3),aypoint1(4),numpoints2/3)]';
arm1_2=[linspace(axpoint1(4), axpoint1(5),numpoints2*2/3);linspace(aypoint1(4),aypoint1(5),numpoints2*2/3)]';

x=[axpoint1(1),axpoint1(2),axpoint1(3)];y=[aypoint1(1),aypoint1(2),aypoint1(3)];
xx=[x(1):(x(end)-x(1))/numpoints:x(end)];
yy=interp1(x,y,xx,'pchip');
arm1=[xx;yy]';


arm1=[arm1; arm1_1;arm1_2];

arm2_1=[linspace(axpoint2(3), axpoint2(4),numpoints2/3);linspace(aypoint2(3),aypoint2(4),numpoints2/3)]';
arm2_2=[linspace(axpoint2(4), axpoint2(5),numpoints2*2/3);linspace(aypoint2(4),aypoint2(5),numpoints2*2/3)]';
x=[axpoint2(1),axpoint2(2),axpoint2(3)];y=[aypoint2(1),aypoint2(2),aypoint2(3)];
xx=[x(1):(x(end)-x(1))/numpoints:x(end)];
yy=interp1(x,y,xx,'pchip');
arm2=[xx;yy]';

arm2=[arm2;arm2_1;arm2_2];

arm3_1=[linspace(axpoint3(3), axpoint3(4),numpoints2/3);linspace(aypoint3(3),aypoint3(4),numpoints2/3)]';
arm3_2=[linspace(axpoint3(4), axpoint3(5),numpoints2*2/3);linspace(aypoint3(4),aypoint3(5),numpoints2*2/3)]';

x=[axpoint3(1),axpoint3(2),axpoint3(3)];y=[aypoint3(1),aypoint3(2),aypoint3(3)];
xx=[x(1):(x(end)-x(1))/numpoints:x(end)];
yy=interp1(x,y,xx,'pchip');
arm3=[xx;yy]';
arm3=[arm3;arm3_1;arm3_2];

xlim([0 800]); ylim([0 700]);
set(gca,'XTick',[],'YTick',[]);
hold on;

x=1:scale*pi/30:(scale*2*pi);
y=(sin(x/scale))*yScale;

angle=100*pi/180;

[theta,r]=cart2pol(x,y);
theta=theta+angle;
[x,y]=pol2cart(theta,r);

head1=[-x+xoffset1;y+yoffset1]';
head2=[-x+xoffset2;y+yoffset2]';
head3=[-x+xoffset3;y+yoffset3]';

if TST
       
    plot(head2(:,1),head2(:,2),'Color',path_color,'LineWidth',width);
    plot(head3(:,1),head3(:,2),'r','LineWidth',width);
    plot([-x(1)+xoffset2-5 -x(1)+xoffset2],[y(1)+yoffset2-5 y(1)+yoffset2],'Color',path_color,'LineWidth',width);
    plot([-x(1)+xoffset2+5 -x(1)+xoffset2],[y(1)+yoffset2-5 y(1)+yoffset2],'Color',path_color,'LineWidth',width); 
    plot([-x(1)+xoffset3-5 -x(1)+xoffset3],[y(1)+yoffset3-5 y(1)+yoffset3],'r','LineWidth',width);
    plot([-x(1)+xoffset3+5 -x(1)+xoffset3],[y(1)+yoffset3-5 y(1)+yoffset3],'r','LineWidth',width);
    plot(arm2(:,1),arm2(:,2),'r','LineWidth',width);
    plot(arm3(:,1),arm3(:,2),'r','LineWidth',width);
    plot(erb(:,1),erb(:,2),'r','LineWidth',width);
    plot(wrist(:,1),wrist(:,2),'r','LineWidth',width);
    rectangle('Position',[(axpoint2(1)-4),aypoint2(1)-2,8,6],'FaceColor','r','EdgeColor','r');
    rectangle('Position',[(axpoint3(1)-4),aypoint3(1)-2,8,6],'FaceColor','r','EdgeColor','r');

end


plot(head1(:,1),head1(:,2),'Color',path_color,'LineWidth',width);
plot([-x(1)+xoffset1-5 -x(1)+xoffset1],[y(1)+yoffset1-5 y(1)+yoffset1],'Color',path_color,'LineWidth',width);
plot([-x(1)+xoffset1+5 -x(1)+xoffset1],[y(1)+yoffset1-5 y(1)+yoffset1],'Color',path_color,'LineWidth',width);
plot(arm1(:,1),arm1(:,2),'r','LineWidth',width);
rectangle('Position',[(axpoint1(1)-4),aypoint1(1)-2,8,6],'FaceColor','r','EdgeColor','r');


function  TMS_pulse1( TST, hObject,handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


threshold=handles.MT(get(handles.disease_type,'Value'));
stimulus=(get(handles.stim,'Value'))*100;
blu=[115 200 255]/255;
redd=[255 53 53]/255;
time=0.020;
n = get(handles.disease_type,'Value');
fields = fieldnames(handles.subjects);
p=handles.subjects.(fields{n}).TMS_head;



if get(handles.SP_rb,'Value')
    
    p=handles.subjects.(fields{n}).SP;
    
end



if get(handles.MEP_rb,'Value')
    limits=[p(1,1) p(end,1) min(p(:,2))-2 max(p(:,2))+4];
else
    limits=[p(1,1) p(end,1) min(p(:,2))-2 max(p(:,2))+2];
end

axes(handles.diagram)
P1=animatedline('Color','b','Marker','h','MarkerSize',25,'MarkerFaceColor',blu,'MaximumNumPoints',1);

%addpoints(P1,handles.head1(end,1),handles.head1(end,2));
addpoints(P1,270,550);


pause(0.125)
clearpoints(P1);


P1=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P2=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P3=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);


if get(handles.SP_rb,'Value')
    
    axes(handles.axis2)
    cla;
else
    axes(handles.axes7)
    
    
    lines= findobj(gca,'Type','Animated Line');
    
    if ~isempty(lines)
        
        
        if length(lines)>1
            
            if lines(1).Color==blu
                
                axes(handles.axes7)
                delete(lines(1))
                
            else
                
                axes(handles.axes7)
                delete(lines(2))
                
            end
            
            
        else
            
            if lines(1).Color==blu
                axes(handles.axes7)
                delete(lines)
            end
            
        end
        
    end
    
end

xlim([limits(1) limits(2)]);ylim([limits(3) limits(4)]);
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');

if get(handles.SP_rb,'Value')
    
    
    set(gca,'XTick',[],'XTickLabel',[],'YTick',[],'YTickLabel',[]);
    
    
else
    
    
    set(gca,'XTick',1:5:p(end,1),'XTickLabel',0:5:p(end,1),'YTick',floor(limits(3)):2:floor(limits(4)),'YTickLabel',floor(limits(3)):2:floor(limits(4)));
    
    
end

G1=animatedline('Color',blu,'LineWidth',2);

if stimulus>=threshold
    
    if TST
        
        h3=handles.head3;
        
        a3=handles.arm3;
        
        
        if get(handles.disease_type,'Value')==1
            
            h1=handles.head1;
            h2=handles.head2;
            a1=handles.arm1;
            a2=handles.arm2;
        else
            
            h1=ones(length(h3),2)*-3;
            h2=ones(length(h3),2)*-3;
            a1=ones(length(a3),2)*-3;
            a2=ones(length(a3),2)*-3;
        end
        
        
        for i=length(h3):-1:1
            
            addpoints(P1,h1(i,1),h1(i,2))
            addpoints(P2,h2(i,1),h2(i,2))
            addpoints(P3,h3(i,1),h3(i,2))
            % axes(handles.axes7)
            addpoints(G1,p(length(h3)-i+1,1),p(length(h3)-i+1,2))
            pause(time)
            
        end
        
        clearpoints(P1)
        clearpoints(P2)
        clearpoints(P3)
        
        
        for i=1:length(a1)
            
            addpoints(P1,a1(i,1),a1(i,2))
            addpoints(P2,a2(i,1),a2(i,2))
            addpoints(P3,a3(i,1),a3(i,2))
            %axes(handles.axes7)
            addpoints(G1,p(length(h3)+i,1),p(length(h3)+i,2));
            pause(time)
            
        end
        
        
        
        for i=(length(h1)+length(a1)+1):length(p)
            
            addpoints(G1,p(i,1),p(i,2));
            pause(time)
            
        end
        clearpoints(P1)
        clearpoints(P2)
        clearpoints(P3)
        
        
    else
        
        h1=handles.head1;
        a1=handles.arm1;
        
        n = get(handles.disease_type,'Value');
        fields = fieldnames(handles.subjects);
        p=handles.subjects.(fields{n}).TMS_head;
        
        if get(handles.SP_rb,'Value')
            
            p=handles.subjects.(fields{n}).SP;
            
        end
        
        
        
        %%No TST Selected
        
        
        for i=length(h1):-1:1
            
            addpoints(P1,h1(i,1),h1(i,2))
            addpoints(G1,p(length(h1)-i+1,1),p(length(h1)-i+1,2))
            pause(time)
            
        end
        
        clearpoints(P1)
        
        for i=1:length(a1)
            
            addpoints(P1,a1(i,1),a1(i,2))
            axes(handles.axes7)
            addpoints(G1,p(length(h1)+i,1),p(length(h1)+i,2))
            pause(time)
            
        end
        
        
        for i=(length(h1)+length(a1)+1):length(p)
            
            addpoints(G1,p(i,1),p(i,2));
            pause(time)
            
        end
        
        clearpoints(P1)
        
    end
    
else
    
    addpoints(P1,handles.head1(end,1),handles.head1(end,2));
    pause(1);
    clearpoints(P1);
    
end


function  TMS_pulse2( TST,hObject,handles )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
blu=[115 200 255]/255;
gren=[0.757 0.867 0.776];
redd=[255 53 53]/255;
time=0.02;
    n = get(handles.disease_type,'Value');
    fields = fieldnames(handles.subjects);
    p=handles.subjects.(fields{n}).TMS_head;



if get(handles.MEP_rb,'Value')
limits=[0 p(end,1) min(p(:,2))-2 max(p(:,2))+4];
else
    limits=[0 p(end,1) min(p(:,2))-2 max(p(:,2))+2];
end

    p=handles.subjects.(fields{n}).TMS_shoulder;

axes(handles.diagram)
P1=animatedline('Color',[0.082 0.373 0.137] ,'Marker','h','MarkerSize',25,'MarkerFaceColor',gren,'MaximumNumPoints',1);

addpoints(P1,200,290);
pause(0.125)
clearpoints(P1);

P1=animatedline('Color',[0.082 0.373 0.137],'Marker','o','MarkerFaceColor',gren,'MaximumNumPoints',1);
P2=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P3=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
axes(handles.axes7);
lines= findobj(gca,'Type','Animated Line');
if ~isempty(lines)
    
    
    if length(lines)>1
        
        if lines(1).Color==gren
            
            axes(handles.axes7)
            delete(lines(1))
            
        else
            
            axes(handles.axes7)
            delete(lines(2))
            
        end
        
        
    else
        
        
        if lines(1).Color==gren
        axes(handles.axes7)
        delete(lines)
        end
        
        
    end
    
end

xlim([limits(1) limits(2)]);ylim([limits(3) limits(4)]);
set(gca,'XTick',1:5:p(end,1),'XTickLabel',0:5:p(end,1),'YTick',floor(limits(3)):2:floor(limits(4)),'YTickLabel',floor(limits(3)):2:floor(limits(4)));
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');

G1=animatedline('Color',gren,'LineWidth',2);

axes(handles.diagram);

    a1=handles.arm1;
    
    for i=1:length(a1)
        
        addpoints(P1,a1(i,1),a1(i,2))
        axes(handles.axes7)
        
        addpoints(G1,p(i,1),p(i,2));
        pause(time)
        
    end
    
    for i=(length(a1)+1):length(p)
        

        addpoints(G1,p(i,1),p(i,2));
        pause(time)
        
    end

    clearpoints(P1);
    
    
    function TMS_pulse3( hObject, handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

redd=[255 53 53]/255;
time=0.017;
axes(handles.diagram);
P1=animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1);
P2=animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1);

axes(handles.axis2)
lines= findobj(gca,'Type','Animated Line');
if ~isempty(lines)
    
    delete(lines)
    
end

G1=animatedline('Color',redd,'LineWidth',2);
xlim([0 42]);ylim([-2 2]);
set(gca,'XTick',0:5:40,'XTickLabel',0:5:40,'YTick',-2:2,'YTickLabel',-2:2);
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');
n = get(handles.disease_type,'Value');
fields = fieldnames(handles.subjects);
p=handles.subjects.(fields{n}).TMS_ulnar;


a1=handles.arm1((end-40)+1:end,:);
a2=handles.arm1((end-40):-1:1,:);

axes(handles.diagram)

for i=1:length(a1)
    
    addpoints(P1,a1(i,1),a1(i,2))
    addpoints(P2,a2(i,1),a2(i,2))
    addpoints(G1,p(i,1),p(i,2))
    
    pause(time)
    
end

clearpoints(P1)
clearpoints(P2)

a1=handles.arm1;

for i=1:length(a1)
    
    addpoints(P1,a1(i,1),a1(i,2))
    addpoints(G1,p(i+length(a2)+1,1),p(i+length(a2)+1,2))
    pause(time)
    
end



for i=length(a2)+length(a1)+1:length(p)
    addpoints(G1,p(i,1),p(i,2));
    pause(time)
    
end

clearpoints(P1)


function  TST_pulse( hObject, handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
blu=[115 200 255]/255;
%gren=[0.757 0.867 0.776];
time=0.025;

axes(handles.diagram)

P1=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P2=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P3=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P4=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P5=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P6=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);

axes(handles.axes7);
cla;
G1=animatedline('Color',blu,'LineWidth',2);


h1=handles.head1;
h2=handles.head2;
h3=handles.head3;
a1=handles.arm1;
a2=handles.arm2;
a3=handles.arm3;


if get(handles.disease_type,'Value')==1
    
    
    %Healthy Controls
    
    p=handles.TSTcontrol;
    xlim([0 max(p(:,1))]);
    ylim([min(p(:,2))-1 max(p(:,2))+1]);
    set(gca,'XTick',0:2:p(end,1),'XTickLabel',0:2:p(end,1));
xlabel('Time (ms)','FontName','Source Sans Pro');ylabel('Voltage (mV)','FontName','Source Sans Pro');

    
    
    set(handles.pulse1,'BackgroundColor',blu);
    pause(0.1);
    set(handles.pulse1,'BackgroundColor',[0.055 0.451 0.726]);
    
    
    for i=length(h1):-1:1
        
        addpoints(P1,h1(i,1),h1(i,2))
        addpoints(P2,h2(i,1),h2(i,2))
        addpoints(P3,h3(i,1),h3(i,2))
        addpoints(G1,p(length(h1)-i+1,1),p(length(h1)-i+1,2));
        pause(time)
        
    end
    

    
    set(handles.wrist_push,'BackgroundColor',blu);
    pause(0.1);
    set(handles.wrist_push,'BackgroundColor',[0.055 0.451 0.726]);
    
        clearpoints(P1)
    clearpoints(P2)
    clearpoints(P3)
    
    l=floor(length(a1)/2);
    
    for i=1:l
        
        addpoints(P1,a1(i,1),a1(i,2))
        addpoints(P2,a2(i,1),a2(i,2))
        addpoints(P3,a3(i,1),a3(i,2))
        addpoints(P4,a1(l*2-i+1,1),a1(l*2-i+1,2))
        addpoints(P5,a2(l*2-i+1,1),a2(l*2-i+1,2))
        addpoints(P6,a3(l*2-i+1,1),a3(l*2-i+1,2))
        addpoints(G1,p(length(h1)+i,1),p(length(h1)+i,2));
        
        pause(time)
        
    end
    

    
    set(handles.erb_push,'BackgroundColor',blu);
    pause(0.1);
    set(handles.erb_push,'BackgroundColor',[0.055 0.451 0.726]);
    
        clearpoints(P1)
    clearpoints(P2)
    clearpoints(P3)
    clearpoints(P4)
    clearpoints(P5)
    clearpoints(P6)
    
    for i=1:length(a1)
        
        addpoints(P1,a1(i,1),a1(i,2))
        addpoints(P2,a2(i,1),a2(i,2))
        addpoints(P3,a3(i,1),a3(i,2))
        addpoints(G1,p(length(h1)+l+i,1),p(length(h1)+l+i,2));
        pause(time)
        
    end
    
    
    for i=length(h1)+l+length(a1):length(p)
       
        addpoints(G1,p(i,1),p(i,2));
        pause(time)
        
    end
    
    clearpoints(P1)
    clearpoints(P2)
    clearpoints(P3)
    
else
    
    %Patients
    
    p=handles.TSTpatient;
        xlim([0 max(p(:,1))]);
    ylim([min(p(:,2))-1 max(p(:,2))+1]);
    
    set(handles.pulse1,'BackgroundColor',blu);
    pause(0.1);
    set(handles.pulse1,'BackgroundColor',[0.055 0.451 0.726]);
    
    
    for i=length(h1):-1:1
        
        addpoints(P3,h3(i,1),h3(i,2))
        addpoints(G1,p(length(h1)-i+1,1),p(length(h1)-i+1,2));

        pause(time)
        
    end
    
    
    
    set(handles.wrist_push,'BackgroundColor',blu);
    pause(0.1);
    set(handles.wrist_push,'BackgroundColor',[0.055 0.451 0.726]);
    
    
    clearpoints(P3)
    
    l=floor(length(a1)/2);
    
    for i=1:l
        
        addpoints(P3,a3(i,1),a3(i,2))
        addpoints(P4,a1(l*2-i+1,1),a1(l*2-i+1,2))%
        addpoints(P5,a2(l*2-i+1,1),a2(l*2-i+1,2))%
        addpoints(P6,a3(l*2-i+1,1),a3(l*2-i+1,2))
                addpoints(G1,p(length(h1)+i,1),p(length(h1)+i,2));

        pause(time)
        
    end
    
    
    

    
    set(handles.erb_push,'BackgroundColor',blu);
    pause(0.1);
    set(handles.erb_push,'BackgroundColor',[0.055 0.451 0.726]);
    
        clearpoints(P3)
    clearpoints(P4)
    clearpoints(P5)
    clearpoints(P6)
    
    l1=floor(length(a1)/4);
    
    
    for i=1:l1
        
        addpoints(P1,a1(i,1),a1(i,2))
        addpoints(P2,a2(i,1),a2(i,2))
        addpoints(P3,a3(i,1),a3(i,2))
        addpoints(P4,a1(l1*2-i+1,1),a1(l1*2-i+1,2))%
        addpoints(P5,a2(l1*2-i+1,1),a2(l1*2-i+1,2))
        addpoints(G1,p(length(h1)+l+i,1),p(length(h1)+l+i,2));
        
        pause(time);
        
    end
    
    
    clearpoints(P1)
    clearpoints(P2)
    clearpoints(P3)
    clearpoints(P4)
    clearpoints(P5)
    
    for i=(l1+1):length(a1)
    
        addpoints(P3,a3(i,1),a3(i,2))
        addpoints(G1,p(length(h1)+l+i,1),p(length(h1)+l+i,2));
        pause(time);
        
    end
    
   
    
    for i=length(h1)+l+length(a1)+1:length(p)
        
        addpoints(G1,p(i,1),p(i,2));
        pause(time)
    end
    
    clearpoints(P3)
    
end


function wrist_pulse( hObject,handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
axes(handles.diagram);
blu=[115 200 255]/255;
redd=[255 53 53]/255;
time=0.015;
P1=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P2=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);
P3=animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1);

   
w=handles.wrist;

for i=1:length(w)
    
   addpoints(P1,w(i,1),w(i,2))
    pause(time)
    
end

clearpoints(P1);

                    a1=handles.arm1;
             a2=handles.arm2;
             a3=handles.arm3;
             
             for i=length(a1):-1:1
                
                            addpoints(P1,a1(i,1),a1(i,2))
            addpoints(P2,a2(i,1),a2(i,2))
            addpoints(P3,a3(i,1),a3(i,2))
            pause(time)
                 
             end
    
                     
        clearpoints(P1)
        clearpoints(P2)
        clearpoints(P3)
