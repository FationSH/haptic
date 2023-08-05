% Shehaj Fation, University of Ioannina
% Code for matlab simulation of haptic robot
%--------------------------------------------------------------------------
clear variables; % Remove all variables from the workspace.
close all; % Close all open figure windows.

%% Cube
alpha=0.3;           % transparency (max=1=opaque)
Xtrox=zeros(1,11);
Ytrox=zeros(1,11);
Ztrox=zeros(1,11);

%  cube
X = [-0.05 -0.05 -0.05 -0.05 -0.05 0.05;
    0.05 -0.05 0.05 0.05 0.05 0.05;
    0.05 -0.05 0.05 0.05 0.05 0.05;
    -0.05 -0.05 -0.05 -0.05 -0.05 0.05];
Y = [0 0 0 0 0.05 0;
    0 0.05 0 0 0.05 0.05;
    0 0.05 0.05 0.05 0.05 0.05;
    0 0 0.05 0.05 0.05 0];
Z = [-0.05 -0.05 0.05 -0.05 -0.05 -0.05;
    -0.05 -0.05 0.05 -0.05 -0.05 -0.05;
    0.05 0.05 0.05 -0.05 0.05 0.05;
    0.05 0.05 0.05 -0.05 0.05 0.05];

l = 0.1;    % 10 cm
m = 0.2;   % 200 gr

%% draw cube
figure(1)
movegui('northeast') % move top right corner of screen

fill3(X,Y,Z,0.3,'FaceAlpha',alpha);
xlim([-0.2 0.2]);
ylim([0 0.2]);
zlim([-0.2 0.2]);
grid;               % Add grid lines to the current axes.
xlabel('x');ylabel('y');zlabel('z');
box on;
drawnow
view(140,32)
hold on;

% arxikopoihsh
xl = 0.15; yl = 0.15; zl = 0.15;   % suntetagmenwn
q1l = 28.3101; q2l = 88.3101; q3l = 35.2644; % gwniwn (se moires)

% Simulation begins
while (1)
    
    %% Read x, y, z movement ----------------------------------------------
    prompt = 'Insert x: ';
    x = input(prompt);
    prompt = 'Insert y: ';
    y = input(prompt);
    prompt = 'Insert z: ';
    z = input(prompt);
    
    if (x>0.2 || y>0.2 || z>0.2)
        S = 'ERROR: Wrong input.';
        disp(S);
    end
    
    %% Count q1, q2, q3 from invert Kinematics ----------------------------
    x1=10*x; y1=10*y; z1=10*z; l1=10*l;
    r = sqrt(x1^2+y1^2+z1^2);
    theta = atan2(y1,x1);
    
    q3f = radtodeg(asin(z1/(r)));

    % ta x & y pou exei an paei stis 2 diastaseis
    x2d = r*cos(theta);
    y2d = r*sin(theta);

    syms q1 q2
    % upologismos q1 & q2
    eqns = [l1*cos(q1)+l1*cos(q2) == x2d,...
            l1*sin(q1)+l1*sin(q2) == y2d];

    s = solve(eqns, q1, q2);

    q1 = s.q1;
    q2 = s.q2;

    q1deg = real(double(radtodeg(vpa(q1))));
    q2deg = real(double(radtodeg(vpa(q2))));

    % there are two solutions, q1 < q2 && q1 > q2
    % always q1 < q2 
    if q1deg(1) < q2deg(1)
        q1f = q1deg(1); q2f = q2deg(1);
    else
        q1f = q1deg(2); q2f = q2deg(2);
    end
    
    % KAI elegxos gwniwn gia to an einai to T.S.D. ston xwro ergaseias
    if ((q1f>=10 || q1f<=160 || q2f>=20 || q2f<=170 || q3f>=0 || q3f<=360 || q3f>=290 || q3f<=360) && q2f>=q1f+10)
    
        %% sxediasmos troxias gia kaluterh optikopoihsh
        x0=xl; xf=x;
        tf=3;  % xronos metakinhshs
        x1=xl; x2=3*(xf-xl)/tf^2; x3=-2*(xf-xl)/tf^3;

        y0=yl; yf=y; z0=zl; zf=z;
        y1=yl; y2=3*(yf-yl)/tf^2; y3=-2*(yf-yl)/tf^3;
        z1=zl; z2=3*(zf-zl)/tf^2; z3=-2*(zf-zl)/tf^3;
        % *****************************************************************

        for t=0:0.3:tf
            % Kubika poluwnima
            xf=a0+a2*t^2+a3*t^3;  % troxia ar8rwsewn
            yf=y0+y2*t^2+y3*t^3;  % troxia ar8rwsewn
            zf=z0+z2*t^2+z3*t^3;  % troxia ar8rwsewn
            Xtrox((t/0.3)+1)=xf;
            Ytrox((t/0.3)+1)=yf;
            Ztrox((t/0.3)+1)=zf;

            %% Count q1, q2, q3 from invert Kinematics --------------------
            x1=10*xf; y1=10*yf; z1=10*zf; l1=10*l;
            r = sqrt(x1^2+y1^2+z1^2);
            theta = atan2(y1,x1);

            q3f = radtodeg(asin(z1/(r)));

            % ta x & y pou exei an paei stis 2 diastaseis
            x2d = r*cos(theta);
            y2d = r*sin(theta);

            syms q1 q2
            % upologismos q1 & q2
            eqns = [l1*cos(q1)+l1*cos(q2) == x2d,...
                    l1*sin(q1)+l1*sin(q2) == y2d];

            s = solve(eqns, q1, q2);

            q1 = s.q1;
            q2 = s.q2;

            q1deg = real(double(radtodeg(vpa(q1))));
            q2deg = real(double(radtodeg(vpa(q2))));

            % there are two solutions, q1 < q2 && q1 > q2
            % always q1 < q2 
            if q1deg(1) < q2deg(1)
                q1f = q1deg(1); q2f = q2deg(1);
            else
                q1f = q1deg(2); q2f = q2deg(2);
            end
            
            % delete last plot
            if exist('h','var') == 1
                set(h,'Visible','off')
            end

            %% An oxi mesa sto empodeio, ropes einai mhdanikes
            if (xf<=0.05 && yf<=0.05 && zf<=0.05 && xf>=-0.05 && zf>=-0.05)
                % Taxuthta kai epitaxunsh upologizontai apo diaforhsh tvn
                % kubikwn poluonimwm
                q1p = 2*x2*t+3*x3*t^2;
                q2p = 2*y2*t+3*y3*t^2;
                q3p = 2*z2*t+3*z3*t^2;
                %disp(q1p);disp(q2p);disp(q3p);

                q1pp = 2*x2+6*x3*t;
                q2pp = 2*y2+6*y3*t;
                q3pp = 2*z2+6*z3*t;
                %disp(q1pp);disp(q2pp);disp(q3pp);
                
                % krataei tis gwnies gia thn epomenh metakinhsh
                q1l = q1f;
                q2l = q2f;
                q3l = q3f;

                %% Jacobian Matrix
                %J = Jacobian(l,q1f,q2f,q3f);

                %% Dynamic  -----------------------------------------------------------
                % tensor
                I1 = tensors(q1f,q2f,q3f,1);
                I2 = tensors(q1f,q2f,q3f,2);
                I3 = tensors(q1f,q2f,q3f,3);
                I4 = tensors(q1f,q2f,q3f,4);

                        Ixx1=I1(1,1);
                        Ixx2=I2(1,1);
                        Ixx3=I2(1,1);
                        Ixx4=I2(1,1);
                        Izz1=I1(3,3);
                        Izz2=I2(3,3);
                        Izz3=I3(3,3);
                        Izz4=I4(3,3);

                        M = Mass(l,q1f,q2f,q3f,m,Ixx1,Ixx2,Ixx3,Ixx4,Izz1,Izz2,Izz3,Izz4); % Maza
                        G = gmatrix(l,m,q3f);
                        V = vmatrix(l,m,q1f,q2f,q3f,q1p,q2p,q3p);

                        % Compute Torque
                        t = (M*[q1pp; q2pp; q3pp] +V +G)*(1+((0.15-x-y-z)/3));

                        title(['\fontsize{10} Toruqe 1 is {\color{red}', num2str(t(1)),...
                            'Nm} Torque 2 is {\color{red}', num2str(t(2)),...
                            'Nm} Torque 3 is {\color{red}', num2str(t(3)),'Nm}']);
            else
                G = gmatrix(l,m,q3f);
                t = G;
                title(['\fontsize{10} Toruqe 1 is {\color{red}', num2str(t(1)),...
                       'Nm} Torque 2 is {\color{red}', num2str(t(2)),...
                       'Nm} Torque 3 is {\color{red}', num2str(t(3)),'Nm}']);
            end
            %% Plot
            if (xf<=0.05 && yf<=0.05 && zf<=0.05 && xf>=-0.05 && zf>=-0.05)
                    h = plot3(xf,yf,zf,...
                        'Marker','h',...
                        'MarkerSize',10,...
                        'MarkerEdgeColor','r');
            else
                    h = plot3(xf,yf,zf,...
                        'Marker','d',...
                        'MarkerSize',10,...
                        'MarkerEdgeColor','k');
            end
        end 
    else 
        S = 'ERROR: Wrong input.';
        disp(S);
    end
end
% Shehaj Fation, University of Ioannina
% Code for matlab simulation of haptic robot
%--------------------------------------------------------------------------
clear variables; % Remove all variables from the workspace.
close all; % Close all open figure windows.

%% Cube
alpha=0.3;           % transparency (max=1=opaque)
Xtrox=zeros(1,11);
Ytrox=zeros(1,11);
Ztrox=zeros(1,11);

%  cube
X = [-0.05 -0.05 -0.05 -0.05 -0.05 0.05;
    0.05 -0.05 0.05 0.05 0.05 0.05;
    0.05 -0.05 0.05 0.05 0.05 0.05;
    -0.05 -0.05 -0.05 -0.05 -0.05 0.05];
Y = [0 0 0 0 0.05 0;
    0 0.05 0 0 0.05 0.05;
    0 0.05 0.05 0.05 0.05 0.05;
    0 0 0.05 0.05 0.05 0];
Z = [-0.05 -0.05 0.05 -0.05 -0.05 -0.05;
    -0.05 -0.05 0.05 -0.05 -0.05 -0.05;
    0.05 0.05 0.05 -0.05 0.05 0.05;
    0.05 0.05 0.05 -0.05 0.05 0.05];

l = 0.1;    % 10 cm
m = 0.2;   % 200 gr

%% draw cube
figure(1)
movegui('northeast') % move top right corner of screen

fill3(X,Y,Z,0.3,'FaceAlpha',alpha);
xlim([-0.2 0.2]);
ylim([0 0.2]);
zlim([-0.2 0.2]);
grid;               % Add grid lines to the current axes.
xlabel('x');ylabel('y');zlabel('z');
box on;
drawnow
view(140,32)
hold on;

% arxikopoihsh
xl = 0.1; yl = 0.1; zl = 0.1;   % suntetagmenwn
q1l = 28.3101; q2l = 88.3101; q3l = 35.2644; % gwniwn (se moires)

% Simulation begins
while (1)
    
    %% Read x, y, z movement ----------------------------------------------
    prompt = 'Insert x: ';
    x = input(prompt);
    prompt = 'Insert y: ';
    y = input(prompt);
    prompt = 'Insert z: ';
    z = input(prompt);
    
    if (x<0.2 && y<0.2 && z<0.2)
        %% Count q1, q2, q3 from invert Kinematics ----------------------------
        x1=10*x; y1=10*y; z1=10*z; l1=10*l;
        r = sqrt(x1^2+y1^2+z1^2);

        q3f = radtodeg(asin(z1/(r)));

        theta = atan2(y1,x1);

        % ta x & y pou exei an paei stis 2 diastaseis
        x2d = r*cos(theta);
        y2d = r*sin(theta);

        syms q1 q2
        % upologismos q1 & q2
        eqns = [l1*cos(q1)+l1*cos(q2) == x2d,...
                l1*sin(q1)+l1*sin(q2) == y2d];

        s = solve(eqns, q1, q2);

        q1 = s.q1;
        q2 = s.q2;

        q1deg = real(double(radtodeg(vpa(q1))));
        q2deg = real(double(radtodeg(vpa(q2))));

        % there are two solutions, q1 < q2 && q1 > q2
        % always q1 < q2 
        if q1deg(1) < q2deg(1)
            q1f = q1deg(1); q2f = q2deg(1);
        else
            q1f = q1deg(2); q2f = q2deg(2);
        end
 
        % KAI elegxos gwniwn gia to an einai to T.S.D. ston xwro ergaseias
        if ((q1f>=10 || q1f<=160 || q2f>=20 || q2f<=170 || q3f>=0 || q3f<=360 || q3f>=290 || q3f<=360) && q2f>=q1f+10)

            %% sxediasmos troxias gia kaluterh optikopoihsh
            x0=xl; xf=x;
            tf=3;  % xronos metakinhshs
            a0=xl; a1=xl; a2=3*(xf-xl)/tf^2; a3=-2*(xf-xl)/tf^3;

            y0=yl; yf=y; z0=zl; zf=z;
            y1=yl; y2=3*(yf-yl)/tf^2; y3=-2*(yf-yl)/tf^3;
            z1=zl; z2=3*(zf-zl)/tf^2; z3=-2*(zf-zl)/tf^3;
            % ************************************************************************
            tic
            for t=0:0.3:tf
                xf=a0+a2*t^2+a3*t^3;  % troxia ar8rwsewn
                yf=y0+y2*t^2+y3*t^3;  % troxia ar8rwsewn
                zf=z0+z2*t^2+z3*t^3;  % troxia ar8rwsewn

                Xtrox((t/0.3)+1)=xf;
                Ytrox((t/0.3)+1)=yf;
                Ztrox((t/0.3)+1)=zf;
                
                % delete last plot
                if exist('h','var') == 1
                    set(h,'Visible','off')
                end
                % draw new plot
                % mauros rombos ektos kubou
                % kokkino asteri entos kubou
                if (xf<=0.05 && yf<=0.05 && zf<=0.05 && xf>=-0.05 && zf>=-0.05)
                    h = plot3(xf,yf,zf,...
                        'Marker','h',...
                        'MarkerSize',10,...
                        'MarkerEdgeColor','r');
                else
                    h = plot3(xf,yf,zf,...
                        'Marker','d',...
                        'MarkerSize',10,...
                        'MarkerEdgeColor','k');
                end
                pause(0.1);
            end
            time = toc; % xronos metaforas apo ena shmeio se allo gia ton upologismo epitaxunshs
            xl = xf; yl = yf; zl = zf;

            %% An oxi mesa sto empodeio, ropes einai mhdanikes
            if (x<=0.05 && y<=0.05 && z<=0.05 && x>=-0.05 && z>=-0.05)
                % epitaxunsh gwniwn
                % t1 & u1 tewreite 0, afou 3ekinaei apo xrono tic=0 kai
                % einai panta akinhto prin to kounisw
                q1p = deg2rad(q1l)-deg2rad(q1f)/time;
                q2p = deg2rad(q2l)-deg2rad(q2f)/time;
                q3p = deg2rad(q3l)-deg2rad(q3f)/time;
                %disp(q1p);disp(q2p);disp(q3p);
                
                q1pp = q1p/time;
                q2pp = q2p/time;
                q3pp = q3p/time;
                %disp(q1pp);disp(q2pp);disp(q3pp);
                % krataei tis gwnies gia thn epomenh metakinhsh
                q1l = q1f;
                q2l = q2f;
                q3l = q3f;


                %% Jacobian Matrix
                %J = Jacobian(l,q1f,q2f,q3f);

                %% Dynamic  -----------------------------------------------------------
                % tensor
                I1 = tensors(q1f,q2f,q3f,1);
                I2 = tensors(q1f,q2f,q3f,2);
                I3 = tensors(q1f,q2f,q3f,3);
                I4 = tensors(q1f,q2f,q3f,4);

                Ixx1=I1(1,1);
                Ixx2=I2(1,1);
                Ixx3=I2(1,1);
                Ixx4=I2(1,1);
                Izz1=I1(3,3);
                Izz2=I2(3,3);
                Izz3=I3(3,3);
                Izz4=I4(3,3);

                M = Mass(l,q1f,q2f,q3f,m,Ixx1,Ixx2,Ixx3,Ixx4,Izz1,Izz2,Izz3,Izz4); % Maza
                G = gmatrix(l,m,q3f);
                V = vmatrix(l,m,q1f,q2f,q3f,q1p,q2p,q3p);
                
                % Compute Torque
                t = (M*[q1pp; q2pp; q3pp] +V +G)*(1+((0.15-x-y-z)/3));

                title(['\fontsize{10} Toruqe 1 is {\color{red}', num2str(t(1)),...
                    'Nm} Torque 2 is {\color{red}', num2str(t(2)),...
                    'Nm} Torque 3 is {\color{red}', num2str(t(3)),'Nm}']);
            else
                G = gmatrix(l,m,q3f);
                t = G;
                title(['\fontsize{10} Toruqe 1 is {\color{red}', num2str(t(1)),...
                    'Nm} Torque 2 is {\color{red}', num2str(t(2)),...
                    'Nm} Torque 3 is {\color{red}', num2str(t(3)),'Nm}']);
                
%                 title(['\fontsize{10} Toruqe 1 is {\color{red}0' ...
%                 'N} Torque 2 is {\color{red}0' ...
%                 'N} Torque 3 is {\color{red}0 N}']);
            end
        end
    else 
        S = 'ERROR: Wrong input.';
        disp(S);
    end
    % show torque on point
    %txt1 = '\leftarrow t1 = ', num2str(x);
    %text(xf,yf, zf,txt1)
end
