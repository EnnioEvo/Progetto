N = film.N;
Tfin = film.Tfin;
Hcampionato = film.H;
Qcampionato = film.Q;

figure(199)
for j=1:Tfin
    subplot(2,1,1)
    plot(Hcampionato(:,j));
    axis([1 N 0 50])
    grid
    title(['Piezometrica condotta istante di tempo t = ',num2str(j), 's'])
    xlabel('Sezioni condotta')
    ylabel('Carico H')
    
    subplot(2,1,2)
    plot(Qcampionato(:,j));
    axis([1 N 0 0.3])
    grid
    title(['Portata condotta istante di tempo t = ',num2str(j), 's'])
    xlabel('Sezioni condotta')
    ylabel('Q')
    
    pause(0.01);                                                                   % pause(n) mette in pause l'esecuzione per n secondi %
end