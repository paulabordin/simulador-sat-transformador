function [str] = fmt(num,tamanho)
% Formata o numero <num> dado para uma string compativel com o ATP.
% A string de saida tem que:
%  - Ter exatamente <tamanho> caracteres
%  - Possuir obrigatoriamente um ponto decimal
%  - Pode nao ter zeros depois do ponto, ex: '    5.'
%  - Pode nao ter zeros antes do ponto, ex: '    .5'
%  - Pode ser em notacao cientifica com E, ex: ' 5.5E-5'

n =num;
sinal = sign(num);
if (sinal<0)
    t = tamanho-1;
else
    t = tamanho;
end

if (n==0)
    str = [repmat(' ',1,t-2) '0.'];
    return;
end

%if (t <= 5)
%    error('Nao previsto formatar numero em campo com largura menor que 6.');
%end

% Obs.: Para n>1, notacao cientifica gasta caracteres, por isso so vale
%       a pena se for inevitavel (numero muito grande ou muito pequeno).

logn = log10(n);
% Numero grande demais, obrigatorio notacao cientifica:
if (logn >= t-1)
    % quantos caracteres para o expoente?
    t_exp = ceil(log10(logn));
    exp = floor(logn);
    % quantos dig. significativos para matissa?
    t_matissa = t-t_exp-3;
    matissa = round(n*10^(t_matissa-exp)) / 10^t_matissa;
    str_matissa = sprintf('%#*.*g',t_matissa+1,t_matissa,matissa);
    str_exp = ['E+' num2str(exp)];
    str = [str_matissa str_exp];
% Numero maior que 1, nao compensa usar notacao cientifica:
elseif (n >= 1)
    dig_signif = t-1;
    valor = round( n * 10^(dig_signif) )/10^dig_signif;
    str = sprintf('%#*.*g',t,dig_signif,valor)
% Numero pequeno demais, obrigatorio notacao cientifica;
% ou numero tem 4 ou mais zeros apos a virgula, compensa usar cientifica:
elseif (logn<-(t-2) || 4<=ceil(-logn)) % ex. tamanho=7, numero<0.00001
    % ex. tamanho 7, numero = .000015[1] = 1.51e-5 (melhor N.C.)
    % ex. tamanho=7, numero = .000151[3] = 1.51e-4 (tanto faz)
    % ex. tamanho=7, numero = .001513[2] = 1.51e-3 (melhor normal)
    % usando notacao cientifica, matissa pode ter t-4 significativos.
    % usando notacao normal sem zero antes da virgula, 
    % seja nz = ceil(-logn)-1 o numero de zeros depois da virgula
    % entao pode ter t-nz-1 = t-ceil(-logn) significativos para matissa.
    t_exp = floor(log10(ceil(-logn)))+1;
    exp = floor(logn);
    % quantos dig. significativos para matissa?
    t_matissa = t-t_exp-3;
    matissa = round(n*10^(t_matissa-exp)) / 10^t_matissa;
    str_matissa = sprintf('%#*.*g',t_matissa+1,t_matissa,matissa);
    str_exp = ['E' num2str(exp)];
    %str_exp = ['E' str2double(exp)];
    str = [str_matissa str_exp];
else
    % se caiu aqui, o numero eh menor que 1 e nao vale a pena not. cientif.
    % posso ter t-1 algarismos depois da virgula.
    % nao vou usar zero antes da virgula. ex.: |.00985|
    str = [ '.' sprintf('%0*ld',t-1,round(n*10^(t-1))) ];
end

% colocar sinal de menos
if (sinal==-1)
    str = ['-' str];
    % trocar - por ' '
    i = 1;
    atual = str(1);
    proximo = str(2);
    while (atual=='-' && proximo==' ' && length(str) >= i+2 )
        str(i)=' ';
        str(i+1)='-';
        i = i+1;
        atual = str(i);
        proximo = str(i+1);
    end
end

if length(str) ~= tamanho
    error(['Conversao de ' num2str(num) ' para ' num2str(tamanho) ' caracteres nao teve sucesso. Ficou assim: <<' str '>>']);
    %error(['Conversao de ' str2double(num) ' para ' str2double(tamanho) ' caracteres nao teve sucesso. Ficou assim: <<' str '>>']);
end
