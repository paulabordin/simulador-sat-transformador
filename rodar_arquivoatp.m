function rodar_arquivoatp
  % Executa o arquivo do atp
  %a = tira_ext('tcsat_certo.atp');
  comando =('C:\Users\Paula\Downloads\TCC-20230727T184834Z-001\TCC\a.atp');
  dos(comando) % link entre matlab e atp
  delete('dum*.bin');
end
  