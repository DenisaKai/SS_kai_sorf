clc
clear all
close all
%prevod obrazku z RGB na stupne sedi

%% nacteni a uprava dat
obr = imread('dataset.png');
figure, imshow(obr);
J = im2double(obr);
X = reshape(J,size(J,1)*size(J,2),3);
% kazdy dataset musi byt tvoren matici n x p, kde n je pocet pixelu a p = 3
% znamena dimenzi obrazku, kterou chceme pomoci algoritmu snizit
% ocekavany vysledek je tedy matice n x p*

%% implememtace algoritmu PCA
[coeff, score, latent, tsquared, explained] = pca(X); %aplikace algoritmu PCA na data X
% score je matice komponentarnich skore n x k
% latent je matice komponentnich zatezi k x p*
% tsquared je matice reziduin n x p*

%% vizualizace vysledneho obrazku
Xcentered = score*coeff'; % puvodni data centrovana odectenim stredni hodnoty sloupce od odpovidajicich sloupcu
Ipc1 = reshape(Xcentered(:,1),size(J,1),size(J,2));
Ipc2 = reshape(Xcentered(:,2),size(J,1),size(J,2));
Ipc3 = reshape(Xcentered(:,3),size(J,1),size(J,2));
figure, imshow(Ipc1,[]); %obrazek dle slozky R
figure, imshow(Ipc2,[]); %obrazek dle slozky G
figure, imshow(Ipc3,[]); %obrazek dle slozky B

%% vizualizace algoritmu
figure, biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3'});
xlabel('White')
ylabel('Black')
% VEKTORY
% kazda barva je reprezentovana vektorem, jeho delka a smer indikuji jak
% dana promena prispiva k dane slozce 
% BODY
% obsahuje bod kazdeho pixelu obrazku v jakem pomeru ma skore k danym
% hlavnim slozkam
