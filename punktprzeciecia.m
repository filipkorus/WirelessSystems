% Funkcja punktprzeciecia (ax,ay,bx,by,cx,cy,dx,dy) najpierw sprawdza, czy 2 wektory sie przecinaja.
% Jezeli tak, to liczy wspolrzedne punktu przeciecia tych dwoch wektorow. 
% (ax,ay) i (bx,by) to wspolrzedne poczatku i konca pierwszego wektora,
% a (cx,cy) i (dx,dy) to odpowiednio wspolrzedne poczatku i koñca drugiego z wektorow.
% Funkcja zwraca:
%         0 jezeli wektory sa rozlaczne, styczne lub (czesciowo) sie pokrywaja,
%         wspolrzedne punktu przeciecia, jezeli wektory sie przecinaja (krzyzuja). 

function result = punktprzeciecia (ax, ay, bx, by, cx, cy, dx, dy) ;
if dwawektory (ax, ay, bx, by, cx, cy, dx, dy) ~= 1
    result = 0 ;
else
   X = ((cy*dx-dy*cx)*(bx-ax) + (by*ax-ay*bx)*(dx-cx)) / ((by-ay)*(dx-cx) + (cy-dy)*(bx-ax)) ;
   if abs(ax-bx) > 0.000001
       Y = (by-ay)*X/(bx-ax) + (ay*bx-by*ax)/(bx-ax) ;
   else
       Y = (dy-cy)*X/(dx-cx) + (cy*dx-dy*cx)/(dx-cx) ;
   end
   
   result = [X Y] ;    
end


