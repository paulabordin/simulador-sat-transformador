function matriz = removeExtensaoArquivo(matrizTC)
  conv = mat2str(matrizTC);
  matriz = regexp(conv,'\.','split'); 
  matriz = [matriz{1:max(1,end-1)}];
end