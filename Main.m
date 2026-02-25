clear  % clearing memory
clc    % clearing command window
format compact  % Suppresses the display of blank lines

%% 1. CREATING UIFIGURE
% uifigure creates a figure for building a user interface
fig = uifigure;
fig.Position = [0 50 1920 1000];

% uigridlayout positions UI components along the rows and columns of an
% invisible grid that spans the entire uifigure or a container
g = uigridlayout(fig);
g.RowHeight = {'5x','1x','1x','1x','8x'};
g.ColumnWidth = {'2x','1x','12x'};

%% 2. CREATING UI COMPONENTS
uit1 = uitable(g);
uit1.Layout.Row = 1;
uit1.Layout.Column = [1,2];
uit1.RowName = [];
uit1.ColumnName = {'Property','Sign','Value','unit'};
uit1.Data = {'Rotational Speed','n',6000,'rpm'
             'Mass of the piston','mp',380,'g'
             'Mass of the conrod','mr',330,'g'
             'Mass of the crankshaft','mk',1310,'g'
             'Length of the conrod','l',106.7,'mm'
             'COG of the conrod','lg',33,'mm'
             'Crank radius','r',31.5,'mm'
             'COG of the crankshaft','rg',12.86,'mm'};
uit1.ColumnWidth = {'5x','2x'};
uit1.ColumnEditable = [false,false,true,false];

sld1 = uislider(g);
sld1.Layout.Row = 2;
sld1.Layout.Column = 1;
sld1.Limits = [0 50];
sld1.ValueChangingFcn = @slider1_Callback;

spn1 = uispinner(g);
spn1.Layout.Row = 2;
spn1.Layout.Column = 2;
spn1.FontSize = 20;
spn1.ValueChangedFcn = @spinner1_Callback;
spn1.Value = 1;

sld2 = uislider(g);
sld2.Layout.Row = 3;
sld2.Layout.Column = 1;
sld2.Limits = [0 1000];
sld2.ValueChangingFcn = @slider2_Callback;

spn2 = uispinner(g);
spn2.Layout.Row = 3;
spn2.Layout.Column = 2;
spn2.FontSize = 20;
spn2.ValueChangedFcn = @spinner2_Callback;
spn2.Value = 1;

btn = uibutton(g);
btn.Layout.Row = 4;
btn.Layout.Column = 1;
btn.Text = "CALCULATE!";
btn.FontSize = 20;
btn.ButtonPushedFcn = @start;

edfil = uieditfield(g,'numeric');
edfil.Layout.Row = 4;
edfil.Layout.Column = 2;
edfil.FontSize = 20;


uit2 = uitable(g);
uit2.Layout.Row = 5;
uit2.Layout.Column = [1,2];
uit2.RowName = [];
uit2.ColumnName = {'function','Sign','Show'};
uit2.ColumnFormat = {'char','char','logical'};
uit2.Data = {'Piston displacement','yB',0
             'piston velocity','vB',0
             'Piston acceleration','aB',0
             'vertical rotational force','Fy_rot',0
             '1st order reciprocating force','Fy_rec1',0
             '2nd order reciprocating force','Fy_rec2',0
             '4th order reciprocating force','Fy_rec4',0
             '6th order reciprocating force','Fy_rec6',0
             'Resultant reciprocating force','Fy_rec',0
             'Vertical rotational force of the counterweight','Fy_rotC',0
             'Resultant vertical force','Fy',0
             'Horizontal rotational force of crank mechanism','Fz_rot',0
             'Horizontal rotational force of counterweight','Fz_rotC',0
             'Resultant horizontal force','Fz',0};
uit2.ColumnWidth = {'6x','2x','1x'};
uit2.ColumnEditable = [false,false,true];
uit2.CellEditCallback = @start;

ax = uiaxes(g);
ax.Layout.Row = [1 5];
ax.Layout.Column = 3;
hold(ax,'on')
set(ax,'Xtick',0:60:360);
xlim(ax,[0,360]);
ylim(ax,'auto');
grid(ax,'on');
xlabel(ax,'x value');
ylabel(ax,'y value');
set(ax,'Fontsize',14);

fig.UserData = struct("uit1",uit1,"uit2",uit2,"spn1",spn1,"sld1",sld1,"spn2",spn2,"sld2",sld2,"edfil",edfil,"ax",ax);

%% 3. CREATING CALLBACK FUNCTIONS
function start(src,~)
    fig = ancestor(src,"figure","toplevel");
    calculation(fig.UserData)
end

function slider1_Callback(src,event)
    fig = ancestor(src,"figure","toplevel");
    V_1 = event.Value;
    fig.UserData.spn1.Value = V_1;
    calculation(fig.UserData);
end

function spinner1_Callback(src,~)
    fig = ancestor(src,"figure","toplevel");
    V_1 = src.Value;
    fig.UserData.sld1.Value = V_1;
    calculation(fig.UserData);
end

function slider2_Callback(src,event)
    fig = ancestor(src,"figure","toplevel");
    V_2 = event.Value;
    fig.UserData.spn2.Value = V_2;
    calculation(fig.UserData);
end

function spinner2_Callback(src,~)
    fig = ancestor(src,"figure","toplevel");
    V_2 = src.Value;
    fig.UserData.sld2.Value = V_2;
    calculation(fig.UserData);
end