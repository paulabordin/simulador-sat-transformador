function a = tira_ext(meutccerto)
  % se for dado arquivo com extensao (.atp), sera ignorada.
  %a = meutccerto;
  %a=str2double(meutccerto)
  %a = regexp(meutccerto,'\.','split') %Não usa essa merda porque eu já organizei
%   e fiz a porra da matriz meutccerto
  %a = [b{1:max(1,end-1)}];
  
  conv = mat2str(meutccerto);
  a = regexp(conv,'\.','split'); 
  a = [a{1:max(1,end-1)}];
end