function burgersEquation(f0, mu, N)
    X = linspace(-7,7,N)'; dx = X(2) - X(1); mn = numel(mu);
    U = f0(X)*ones(1, mn); dt = 0.01; clr = 'krb';
    figure(Color = 'w', Position = [360 245 413 272.6667]); hold on;
    SolPlot = arrayfun(@(m) plot(X, U(:,m), clr(m), LineWidth = 1.5), 1:mn);
    legend(strsplit(sprintf('$\\nu =  %0.2f$,',mu),','), ...
        interpreter='latex', Location='best', Box='off');
    axis([min(X), max(X), min(U(:)), max(U(:))]); hold off; box on;
    ax = gca; ax.TickLabelInterpreter = "latex"; ax.FontSize = 12;
    timetext = text(-6, 0.8, ['$t = ',sprintf('%0.2f', 0),'$'], ...
        Interpreter = "latex", FontSize = 12);
    drawnow;
    for n = 1:501
        Unp1 = U(2:end-1, (n-1)*mn + (1:mn));
        for m = 1:mn
            un = Unp1(:, m); 
            f = @(unp1) DiscretPDE(unp1, un, mu(m), dx, dt, N);
            unp1 = fsolve(f, un);
            unp1 = [2*unp1(1)-unp1(2);unp1;2*unp1(end)-unp1(end-1)];
            SolPlot(m).YData = unp1; U = [U, unp1];
        end
        timetext.String = ['$t = ', sprintf('%0.2f',(n-1)*dt),'$'];
        drawnow;
    end
end

function res = DiscretPDE(unp1, un, mu, dx, dt, N)
    U = [2*unp1(1)-unp1(2);unp1;2*unp1(end)-unp1(end-1)];
    m = 2:N-1; ump1 = U(m+1); umm1 = U(m-1);
    res = (unp1 - un)/dt + ...
           unp1.*(ump1 - umm1)/(2*dx) - ...
           mu*(ump1 - 2*unp1 + umm1)/dx^2;
end