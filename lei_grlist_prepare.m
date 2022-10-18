function [grlist] = lei_grlist_prepare(Data)

%lei_grlist_prepare generates a group level ID list

Grp=[Data.Grp];
ug=unique(Grp);

for g=1:length(ug)
    
    slist=find(Grp==ug(g));
    
    dum=[];
    
    i=1;
    for sub=slist
        dum=[dum;Data(sub).filteredID];
        dum2(:,:,i)=Data(sub).NoFullTransit/sum(sum(Data(sub).NoFullTransit));
    i=i+1;
    end
    
    dum2=mean(dum2,3);
    
    grlist(g).fullpji=dum2;
    
    dum2=dum2-diag(diag(dum2));
    dum2=dum2/sum(dum2(:));

    grlist(g).pji=dum2;
    grlist(g).ID=dum;

clear dum slist dum2
end

end

