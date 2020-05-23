
%tic
%-------ROBOT-------
myRobot=mlrobot;
mlrobotstart(myRobot);
%-------------------
Kp = 1;             % proportional
Ki = 0.25;          % Integral
Kd = 0.01;        % derivative // dt azaldıkça aşım azalır.
dt = 0.01;          % örnekleme zamanı
desired = 270;       % dönmesini istediğimiz açı
Time = 2;           % toplam simulasyon suresi

n = round(Time/dt); % ornek sayisi
Prop(1:n+1) = 0; Der(1:n+1) = 0; Int(1:n+1) = 0; I(1:n+1) = 0;
%PID(1:n+1) = 0;
%Output(1:n+1) = 0;
%Error(1:n+1) = 0;
%FeedBack(1:n+1) = 0;
color = rand(1,3);
for i = 1:n
    
    if desired<=180
        %------------PID------------
        FeedBack(i)=mlrobotreadcompassangle(myRobot);
        Error(i+1) = desired - FeedBack(i); 
        Prop(i+1) = Error(i+1);
        Der(i+1)  = (Error(i+1) - Error(i))/dt; 
        Int(i+1)  = (Error(i+1) + Error(i))*dt/2; 
        I(i+1)    = sum(Int); 
        PID(i+1)  = Kp*Prop(i) + Ki*I(i+1)+ Kd*Der(i);
        %-----differential drive-----
        r = 0.1; %Tekerlek yarıçapı(m)
        L = 0.5; %Tekerlekler arası uzaklık(m)
        W = PID(i);
        V = 10;
        vRight(i) = ( ( (2*V)+(PID(i)*L) ) / (2*r) );
        vLeft(i) = ( ( (2*V)-(PID(i)*L) ) / (2*r) );
        nvRight(i) = ( (1/150)*vRight(i) )*2;
        nvLeft(i) = ( (1/150)*vLeft(i) )*2;
        
        if(nvRight(i)>5) nvRight(i)=5; end
        if(nvRight(i)<-5) nvRight(i)=-5; end
        if(nvLeft(i)>5) nvLeft(i)=5; end
        if(nvLeft(i)<-5) nvLeft(i)=5; end
        
        mlrobotsetmotorvoltage(myRobot,'left',-nvLeft(i));
        mlrobotsetmotorvoltage(myRobot,'right',nvRight(i));
        %----------------------------
        wheelSpeedLeft(i) = mlrobotreadwheelspeed(myRobot,'left');
        wheelSpeedRight(i) = mlrobotreadwheelspeed(myRobot,'right');
    else
        inverseDesired = 360 - desired;
        %------------PID------------
        FeedBack(i)=mlrobotreadcompassangle(myRobot);
        Error(i+1) = inverseDesired - FeedBack(i); 
        Prop(i+1) = Error(i+1);
        Der(i+1)  = (Error(i+1) - Error(i))/dt; 
        Int(i+1)  = (Error(i+1) + Error(i))*dt/2; 
        I(i+1)    = sum(Int); 
        PID(i+1)  = Kp*Prop(i) + Ki*I(i+1)+ Kd*Der(i);
        %-----differential drive-----
        r = 0.1; %Tekerlek yarıçapı(m)
        L = 0.5; %Tekerlekler arası uzaklık(m)
        W = PID(i);
        V = 10;
        vRight(i) = ( (2*V)+(W*L) )/ (2*r);
        vLeft(i) = ( (2*V)-(W*L) )/ (2*r);
        nvRight(i) = ( (1/150)*vRight(i) )*2;
        nvLeft(i) = ( (1/150)*vLeft(i) )*2;
        
        if(nvRight(i)>5) nvRight(i)=5; end
        if(nvRight(i)<-5) nvRight(i)=-5; end
        if(nvLeft(i)>5) nvLeft(i)=5; end
        if(nvLeft(i)<-5) nvLeft(i)=5; end
        
        mlrobotsetmotorvoltage(myRobot,'left',-nvRight(i));
        mlrobotsetmotorvoltage(myRobot,'right',nvLeft(i));
        %----------------------------
        wheelSpeedLeft(i) = mlrobotreadwheelspeed(myRobot,'left');
        wheelSpeedRight(i) = mlrobotreadwheelspeed(myRobot,'right');
    end
    pause(0.1);% Bir sonraki robot açısını okumadan önce 0,1 saniye bekleme
end      
%-----------GRAFİKLER--------------------------
    T200 = 1:i;
    T201 = 1:i+1; 
    subplot(3,2,1)
    line(T200, FeedBack*pi/180,'color',color )
    grid on; hold on;
    title('Açı [rad]')
    xlabel('t(ms)')
    
    subplot(3,2,2)
    line(T201, Error*pi/180,'color',color)
    grid on; hold on;
    title('Hata [rad]')
    xlabel('t(ms)')
    
    subplot(3,2,3)
    %tekerlek açısal hız, w=v/r
    line(T200, wheelSpeedLeft/r,'color',color )
    grid on; hold on;
    line(T200, wheelSpeedRight/r,'color',color )
    title('Tekerlek Açısal Hızları [rad/s]')
    xlabel('t(ms)')
    
    subplot(3,2,4)
    line(T201, PID*pi/180,'color',color )
    grid on; hold on;
    title('Kontrol Sinyali (u)')
    xlabel('t(ms)')
    
    subplot(3,2,5)
    line(T200, nvLeft,'color',color )
    grid on; hold on;
    title('vl[volt]')
    xlabel('t(ms)')
    
    subplot(3,2,6)
    line(T200, nvRight,'color',color )
    grid on; hold on;
    title('vr[volt]')
    xlabel('t(ms)')
%---------------------------------  
mlrobotstop(myRobot);
%tsim = toc
