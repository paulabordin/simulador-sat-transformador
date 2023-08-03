function criarArquivoATP(~)
  % Cria o arquivo no atp
  circuitoATP = removeExtensaoArquivo('matriz.atp');
  %comando = ['C:\Program Files (x86)\ATPDraw\Atpdraw.exe', circuitoATP, '.atp & exit &'];
  comando = ['C:\ATP\tools\runATP.exe', circuitoATP, '.atp & exit &'];
  system(comando) % link entre matlab e atp
  delete('dum*.bin');

end
  