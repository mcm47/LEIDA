function [outdata] = lei_transitionfilter(Data,filterwindows,filterLEIDA)
% This function filter outs the unstable, short dwell times from the data

% Data => Input data structure from Leida analysis 
% filterwindows => minimum duration for a segment to be included in the analysis
% filterLEIDA => if it is '1' then filtered LEIDAs are also calculated

% outdata => Data sutrcuture with new field called filteredID

% get number of subjects

n_sub=length(Data);

if filterwindows < 2
        disp(' ')
        disp('                   %%%%% WARNING %%%%%')
        disp('------ Filter windows value is smaller than 2. -------')
        disp('---------- Filtering will not be performed.-----------')
        disp(' ')
end

for sub=1:n_sub

    if filterwindows < 2
        Data(sub).filteredID=Data(sub).PatchedIDs;
        
        if filterLEIDA ==1
            Data(sub).filteredLEIDA=Data(sub).PatchedLEIDA;
        end
        
    else
    
        ID=Data(sub).PatchedIDs;
        d=diff(ID);
        st=find(diff(ID)~=0);
        newID=ID(1:st(1));
        
        if filterLEIDA==1
            Leida=Data(sub).PatchedLEIDA;
            L=Leida(1:st(1),:);
        end
        
        for k=1:length(st)-1
            if (st(k+1)-st(k))<filterwindows
            continue
            else
            newID=[newID;ID(st(k)+1:st(k+1))];
            
            if filterLEIDA==1
                L=[L;Leida(st(k)+1:st(k+1),:)];
            end
            
            end
        end
        
        Data(sub).filteredID=newID;
        
        if filterLEIDA==1
            Data(sub).filteredLEIDA=L;
        end
        
        clear newID L
    end
   
end

outdata=Data; 

end

