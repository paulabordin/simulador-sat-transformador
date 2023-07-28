function rodar_atp(a)
  % Cria o arquivo no atp
  meutccerto = tira_ext('a.atp');
  comando = ['C:\ATP\Atpdraw.exe', meutccerto, '.atp & exit &'];
  system(comando) % link entre matlab e atp
  delete('dum*.bin');

end
  