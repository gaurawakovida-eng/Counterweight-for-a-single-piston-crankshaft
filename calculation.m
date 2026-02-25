function calculation(inp)

%% 1. READ DATA
tabdata = inp.uit1.Data;
n = tabdata{1,3};  
mp = tabdata{2,3};  
mr= tabdata{3,3};  
mk= tabdata{4,3};
l = tabdata{5,3};
ls = tabdata{6,3}
r = tabdata{7,3}
rs = tabdata{8,3}
rC = inp.spn1.Value; %counterweight radius
mC = inp.spn2.Value; %counterweight mass
%% 2. CALCULATION
%% Point masses
mAr = mr*(l-ls)/l;
mBr = mr*(ls)/l;
mAk = mk*rs/r;
m0 = mk*(r-rs)/r;

mA = mAr+mAk;
mB = mBr+mp;

%% Converting to tonnes
mA = mA/1000000
mB = mB/1000000
mC = mC/1000000
%% Angular Velocity
omega = (n*pi)/30;

%% Crank angle 
alpha = 1:360;

%% Conrod ratio
lamda = r/l;

%% Constants
C0 = (1/lamda)-(lamda/4)-(3*lamda^3)/64-(5*lamda^5)/256
C2 = (lamda/4)+(lamda^3)/16+(5*lamda^5)/512
C4 = (lamda^3)/64+(3*lamda^5)/256
C6 = lamda^5/512

A2 = 4*C2
A4 = 16*C4
A6 = 36*C6

%% Values
yB = r*(C0+cosd(alpha)+C2*cosd(2*alpha)-C4*cosd(4*alpha)+C6*cosd(6*alpha));
vB = r*(-omega*sind(alpha)-2*C2*omega*sind(2*alpha)+4*C4*omega*sind(4*alpha)-6*C6*omega*sind(6*alpha));
aB = -omega^2*r*(cosd(alpha)+A2*cosd(2*alpha)-A4*cosd(4*alpha)+A6*cosd(6*alpha));
Fy_rot = mA*r*omega^2*cosd(alpha);
Fy_rec1 = mB*r*omega^2*cosd(alpha);
Fy_rec2 = mB*r*omega^2*A2*cosd(2*alpha);
Fy_rec4 = -mB*r*omega^2*A4*cosd(4*alpha);
Fy_rec6 = mB*r*omega^2*A6*cosd(6*alpha);

Fy_rec = Fy_rec1+Fy_rec2+Fy_rec4+Fy_rec6;
Fy_rotC = -mC*rC*omega^2*cosd(alpha);

Fy = Fy_rot+Fy_rec+Fy_rotC;

Fz_rot = mA*r*omega^2*sind(alpha);
Fz_rotC = -mC*rC*omega^2*sind(alpha);

Fz = Fz_rotC+Fz_rot;

%% 3. PLOTTING
output = [yB
    vB
    aB
    Fy_rot
    Fy_rec1
    Fy_rec2
    Fy_rec4
    Fy_rec6
    Fy_rec
    Fy_rotC
    Fy
    Fz_rot
    Fz_rotC
    Fz];
fnames = {'Piston displacement','Piston velocity','Piston acceleration','Vertical rotational force','1st oder reciprocating force',...
    '2nd order reciprocating force','4th oder reciprocating force','6th order reciprocating force','resultant reciprocating force',...
    'Vertical rotational force of counterweight','Resultant vertical force','Horizontal rotational force of crank mechanism',...
    'Horizontal rotational force of counterweight','Resultant horizontal force'};
Cmat = turbo(size(output, 1));
cla(inp.ax);
j = 0;
for i = 1:14
   show = inp.uit2.Data{i,3};
   if show == 1
       j = j + 1;
       plt.f{j} = line(inp.ax,alpha,output(i,:));
       plt.f{j}.Color = Cmat(i,:);
       plt.f{j}.LineWidth = 2;
       plt.f{j}.Visible = "On";
       plt.f{j}.DisplayName = fnames{i};
   end
end

legend(inp.ax,'show');
k = (mC*rC-mA*r)*100/(mB*r);
inp.edfil.Value=k;
end
