function lstsqu_slopes(N,var)
%requires the N and variation as an input, no outputs

mean=0;
%Placeholder for slopes in different iterations, PLS slopes in first column
Slopes = zeros(N, 2);

%Does the amount of simulation defined by N
%White gaussian noise added using matlab function
%slopes found using native matlab functions
for i=1:N
    x = rand(N,1);
    y = 2*x;
    x_noise = normrnd (0, sqrt(var), N, 1);
    y_noise = normrnd (0, sqrt(var), N, 1);
    x_noisey = x + x_noise;
    y_noisey = y + y_noise;
    [~, ~,~,~,beta] = plsregress(x_noisey,y_noisey,1);
    Slopes(i,1)=beta(2);
    [Slopes(i,2),~]=lsqr(x_noisey, y_noisey);
end
plots = ["PLS" "TLS"];
%X label for plots
titl = ["Slopes From PLS and TLS N = ",num2str(N)," and Var =",num2str(var)];
%title for figure
figure (1)
boxplot(Slopes, plots); xlabel('Least Square Method'); ylabel('Slopes'); title(titl); ylim([-0.5 2.5]);
hold on ; plot((0:3),[2 2 2 2],'r'); %reference line for slope equal to 2
hold off

%This function can be used to find all the combinations of N and Variance
%TLS performs better than PLS except in cases in which the large N allows  
%for similar perfomance. PLS square performs extremely poorely in cases
%with large variance and small N, in which a signficant portion of the
%slope distrubition is actually negative.
