function scriptConverterPL4toMAT
  % converte pl4 para mat
  !converter.exe &
  keyInject('ConverterForm','\t','ConverterForm')
  keyInject('ConverterForm','P','ConverterForm')
  keyInject('ConverterForm','\t','ConverterForm')
  keyInject('ConverterForm','M','ConverterForm')
  keyInject('ConverterForm','M','ConverterForm')
  keyInject('ConverterForm','\t','ConverterForm')
  keyInject('ConverterForm','\r','Abrir')
  keyInject('Abrir','matriz.pl4','Abrir')
  keyInject('Abrir','\r','Converter')
  keyInject('Converter','\r','ConverterForm')
  keyInject('ConverterForm','ALT_+F4ALT_-','ConverterForm')
  delete('dum*.bin')
end