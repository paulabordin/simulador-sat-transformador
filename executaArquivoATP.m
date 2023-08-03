function executaArquivoATP
  % Executa o arquivo do atp
  %a = tira_ext('tcsat_certo.atp');
  comando =('C:\TCC\matriz.atp'); % Aponte para o diretorio onde o arquivo atp gerado
  dos(comando) % link entre matlab e atp
  delete('dum*.bin');
end
  