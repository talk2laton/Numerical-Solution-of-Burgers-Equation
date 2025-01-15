f0 = @(x) -exp(-(x+1).^2/2) + exp(-(x-1).^2/2);
N = 501;
mu = [1,0.1,0.01,];
SolveburgersEquation(f0, mu, N);

function SolveburgersEquation(f0, mu, N)
    X = linspace(-7,7,N)'; dx = X(2) - X(1); mn = numel(mu);
    U = f0(X)*ones(1, mn); dt = 0.01; clr = 'krb';
    figure(Color = 'w', Position = [360 245 413 272.6667]); hold on;
    SolPlot = arrayfun(@(m) plot(X, U(:,m), clr(m), LineWidth = 1.5), 1:mn);
    legend(strsplit(sprintf('$\\nu =  %0.2f$,',mu),','), ...
        interpreter='latex', Location='best', Box='off');
    axis([min(X), max(X), min(U(:)), max(U(:))]); hold off; box on;
    ax = gca; ax.TickLabelInterpreter = "latex"; ax.FontSize = 12;
    xlabel("$x$", Interpreter="latex"); ylabel("$u$", Interpreter="latex");
    timetext = text(-6, 0.8, ['$t = ',sprintf('%0.2f', 0),'$'], ...
        Interpreter = "latex", FontSize = 12);
    drawnow;
    frame = getframe(1); 
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256); 
    delaytime = 0.05;
    imwrite(imind, cm, 'N_wave.gif', 'gif', 'Loopcount', inf, ...
        'DelayTime', delaytime); 
    for n = 1:501
        Unp1 = U(2:end-1, (n-1)*mn + (1:mn));
        for m = 1:mn
            un = Unp1(:, m); 
            f = @(u) DiscretPDE(u, un, mu(m), dx, dt, N);
            unp1 = fsolve(f, un);
            unp1 = [2*unp1(1)-unp1(2);unp1;2*unp1(end)-unp1(end-1)];
            SolPlot(m).YData = unp1; U = [U, unp1];
        end
        timetext.String = ['$t = ', sprintf('%0.2f',(n-1)*dt),'$'];
        drawnow;
        if(~mod(n,5))
            frame = getframe(1); 
            im = frame2im(frame);
            [imind,cm] = rgb2ind(im,256); 
            % Write the frame to the GIF file
            imwrite(imind, cm, 'N_wave.gif', 'gif', ...
                       'WriteMode', 'append', 'DelayTime', delaytime);
        end
    end
end

function res = DiscretPDE(u, un, mu, dx, dt, N)
    U = [2*u(1)-u(2);u;2*u(end)-u(end-1)];
    i = 2:N-1; u_ip1 = U(i+1); u_im1 = U(i-1);
    res = u-un + dt*(u.*(u_ip1-u_im1)/(2*dx) - mu*(u_ip1-2*u+u_im1)/dx^2);
end