function rodar_converter
  % converte pl4 para mat
  % a = tira_ext('tcsat_certo.atp');
  %comando = ['C:\Users\Paula\converter.exe'];
  %system(comando, '-echo') % link entre matlab e atp
  !converter.exe &
  keyInject('ConverterForm','\t','ConverterForm')
   keyInject('ConverterForm','P','ConverterForm')
  keyInject('ConverterForm','\t','ConverterForm')
   keyInject('ConverterForm','M','ConverterForm')
   keyInject('ConverterForm','M','ConverterForm')
   keyInject('ConverterForm','\t','ConverterForm')
   keyInject('ConverterForm','\r','Abrir')
  %  keyInject('Abrir','\t','Abrir')
  % keyInject('Abrir','\r','Abrir')
   keyInject('Abrir','a.pl4','Abrir')
 %   keyInject('Abrir','\t','Abrir')
 % keyInject('Abrir','\t','Abrir')
 %  keyInject('Abrir','\t','Abrir')
    keyInject('Abrir','\r','Converter')
   keyInject('Converter','\r','ConverterForm')
   keyInject('ConverterForm','ALT_+F4ALT_-','ConverterForm')
   delete('dum*.bin')
end