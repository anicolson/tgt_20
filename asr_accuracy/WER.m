function w=WER(h,r,varargin)
% The function is intended for calculation of word error rate (WER)
% between word sequence H (hypothesis) and word sequence R (reference).
% WER is a measure (metric) of the performance of an automatic speech 
% recognition. For calculation we use Levenshtein distance on word level.
% Levenshtein distance is a minimal quantity of insertiions, deletions
% and substitutions of words for conversion of a hypothesis to a reference.
% H and R are cell arrays of words (for example after using TEXTSCAN) or
% cells with word sequences or strings. Types of H and R may be different.
% WER = D(H,R)/N, where D(H,R) is a Levenshtein distance between H and R,
% and N is the number of words in the reference R.
% W = WER(H,R) returns array W.
% W(1) is WER for case sensitive.
% W(2) is WER for case insensitive.
% W = WER(H,R,1) and H and R are strings then we calculate distances on 
% character level and result is the character error rate(CHR).
% Example
% h={'The','English','word','probability',...
%   'derives','from','Latin','word','probitas'};
% r={'The','English','word','Probability',...
%   'derives','from','the','Latinic','word','Probabilitas'};
% w=WER(h,r);
% disp('WER, case sensitive')
% disp(w(1))
% disp('WER, case insensitive')
% disp(w(2))
% WER, case sensitive
%          0.4
% WER, case insensitive
%          0.3
w=[];
switch nargin
  case [{0},{1}] 
    warning('Not enough input arguments.')   
    return 
  case [{2},{3}]
    if nargin==2&&ischar(h)
      h=strsplit(h);
    end
    if nargin==2&&ischar(r)
      r=strsplit(r);
    end
    d1=strd(h,r,1); % distance between H and R, case sensitive
    d2=strd(h,r,2); % distance between H and R, case insensitive
    d3=numel(r); % the number of words in the reference R
    if isempty(r)
      warning('Reference should not be empty.') 
    end
    w=[d1,d2]/d3;  % calculation of WER   
  otherwise    
    warning('Too many input arguments.')
    return
end

function d=strd(a,b,cas)

% d=strd(r,b,cas) computes Levenshtein and editor distance 
% between strings r and b with use of Vagner-Fisher algorithm.
% if CAS == 2 then a case is ignored.
    aa=a;
    bb=b;
  if cas==2
    aa=upper(a);
    bb=upper(b);
  end

luma=numel(bb);	lima=numel(aa);
lu1=luma+1;       li1=lima+1;
dl=zeros([lu1,li1]);
dl(1,:)=0:lima;   dl(:,1)=0:luma;
%Distance
for i=2:lu1
   bbi=bb(i-1);
   for j=2:li1
      kr=1;
      if strcmp(aa(j-1),bbi)
         kr=0;
      end
   dl(i,j)=min([dl(i-1,j-1)+kr,dl(i-1,j)+1,dl(i,j-1)+1]);
   end
end
d=dl(end,end);



