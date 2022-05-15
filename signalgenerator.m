fs=input('Enter the sampling frequency: ');%sampling frequency
startT=input('Enter the starting time scale: ');
endT=input('Enter the ending time scale: ');
nobreakpoints=input('Enter the number of break points: ');
Time=linspace(startT,endT,(endT-startT)*fs);
prev=startT;
%loop that requests the breakpoints and matches the each time domian to
%it's signal number
for i=1:nobreakpoints+1
if(or(i==nobreakpoints+1,nobreakpoints==0))
breakpoint=endT;
else
X = sprintf('Enter breakpoint no. %d: ',i);
disp(X);
breakpoint=input('');
while(or(or(breakpoint<startT ,breakpoint>endT),breakpoint<=prev))
disp(X);
breakpoint=input('');
end
end
signalstarttime=prev;
signalendtime=breakpoint;
prev=breakpoint;
Z=input('Choose the signal number from 1 DC signal,2 ramp signal,3 General order polynomial,4 Exponential signal and 5 Sinusoidal signal: ');
t=linspace(signalstarttime,signalendtime,fs*(signalendtime-signalstarttime));
%signal generator switch case based upon the value of the variable Z a
%signal is constructed and the values required to construct such signal
%and requested from the user
switch Z
case 1 %DC signal
Amp=input('Enter amplitude: ');
X=Amp*ones(1,round(fs*(signalendtime-signalstarttime)));
if(i==1)
Y=X;
else
Y=[Y X];
end
case 2 %ramp signal
slope=input('Enter slope: ');
intercept=input('enter intercept: ');
X=t*slope+intercept;
if(i==1)
Y=X;
else
Y=[Y X];
end
case 3 %general order polynomial generaltion
power=input('Enter the greatest power: ');
Amp=zeros(1,power);
for j=1:power
fprintf('Enter the amplitude of X to the power %d: ', j );
Amp(1,j)=input('');
end
X=Amp(1,power)*t.^(power);
for k=1:power-1
X=X+Amp(1,k)*t.^(k);
end
intercept=input('enter intercept: ');
X=X+intercept;
if(i==1)
Y=X;
else
Y=[Y X];
end
case 4 %Expnoential signal
Amp=input('Enter amplitude: ');
exponent=input('enter exponent: ');

X=Amp*exp(t*exponent);
if(i==1)
Y=X;
else
Y=[Y X];
end
case 5 %Sinusoidal signal
Amp=input('Enter amplitude: ');
Freq=input('Enter frequency: ');
phase=input('Enter phase: ');
X=Amp*sin((2*pi*(Freq))*(t-phase));
if(i==1)
Y=X;
else
Y=[Y X];
end
end
end
plot(Time,Y);%ploting the signal
ylim([min(Y)-1 max(Y)+1]);
grid on
choice=false;%Loop that applies changes to the obtained signal so long as the choice chosen is not true
while choice~=true
operation=input('Choose an operation number from 1 Amplitude Scaling,2 Time reversal,3 Time shift,4 Expanding the signal,5 Compressing the signal and 6 none: ');
switch operation
case 1
scale=input('input Amplitude scale: ');
Y=scale*Y;
plot(Time,Y);
ylim([min(Y)-1 max(Y)+1]);
grid on
case 2
Time=Time*-1;
plot(Time,Y);
ylim([min(Y)-1 max(Y)+1]);
grid on
case 3
shift=input('input shift value: ');
Time=Time+shift;
plot(Time,Y);
ylim([min(Y)-1 max(Y)+1]);

grid on
case 4
expand=input('input expansion value: ');
Time=Time*expand;
plot(Time,Y);
ylim([min(Y)-1 max(Y)+1]);
grid on;
case 5
compress=input('input compression value: ');
Time=Time/compress;
plot(Time,Y);
ylim([min(Y)-1 max(Y)+1]);
grid on;
case 6
end
choice=input('Do you want to end (true to end , false to apply more changing to the signal): ');
end