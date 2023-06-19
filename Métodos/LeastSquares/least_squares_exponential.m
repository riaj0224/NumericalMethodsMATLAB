%% Lin_reg -> exponential
% Equipo2_HarryPotter
%% Algoritmo
function resultados = equipo2_exp_model ( x , y, verbose ) %
Se declaran las entradas y salidas
sizeX = size (x); % Se obtienen las dimensiones
n = sizeX(2); % La cantidad de datos por matriz
if size( y ) ~= size (x) % Candado para confirmar que ambas
matrices son del mismo tamaño
error ( "ErrorDimensiones:X y Y deben de tener la misma
longitud (cantidad de datos)"...
+ " X:%d && Y:%d", size(x), size(y)); % Crashear en
caso de error
end % Terminar iF
y = log(y); % Se linealizan los datos
sx = sum( x ); % Sumatoria de X
sy = sum( y ); % Sumatoria de Y
sx2 = sum( x .* x ); % Sumatoria de x^2
sy2 = sum( y .* y ); % Sumatoria de y^2
sxy = sum( x .* y ); % Sumatoria de xy
3
m = ( n*sxy - sx*sy ) / ( n*sx2 - sx^2 ) ; % Se calcula
pendiente
b = sy / n - m * sx / n ; % Se calcula intercepción con Y
r=(n*sxy-sx*sy)/sqrt((n*sx2-sx^2)*(n*sy2-sy^2)); % Se calcula
coeficiente de correlación
r2 = r^2; % Se calcula coeficiente de determinación
yp =(@(xp) exp(m * xp + b)) ; % Se declara función del modelo
y = exp(y); % Se deslinealizan los datos
alpha = exp(b); % Coeficiente del modelo exponencial
base = exp(m); % Base del modelo exponencial
if verbose == true % Mostrar modelo y gráficas
hold on % Graficar dos modelos
plot ( x , y , 'o') ; % Scatter de los datos
fplot (yp, [min(x) max(x)]); % Gráfica del modelo
hold off % Cerrar hold on
grid on % Cuadrícula
fprintf ("\nEl modelo exponencial para los datos es:\n
\ny = %f * %f ^t\n", alpha, base); % Presentar modelo
end % Terminar IF
fprintf("\n Alpha: %f \n \n e^Beta: %f \n \n r = %f\n \n r^2=
%f\n", alpha, base, r, r2); % Imprimir resultados
resultados = [alpha base r r2]; % Almacenar resultados
end % Terminar IF
