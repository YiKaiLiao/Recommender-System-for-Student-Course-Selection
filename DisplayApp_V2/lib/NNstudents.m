%find k nearest neighbors (Student)
function [ans, NN] = NNstudents(M, k, targetIdx)
    rs = M;
    tt = M;
    cnt = 0;
    while(sum(sum(isnan(rs))) > 0)
        cnt = cnt + 1;
        if(cnt > 5)
            break;
        end
        for i = 1:size(rs, 1)
            imv = sort(rs(i, :),'descend','MissingPlacement','last');%目標stuvec
            imv(isnan(imv))=[];
            nei={};
            nei.dis=[];
            nei.kn=[];
            for j=1:size(rs,1)
                if(i~=j)
                    stunei=sort(rs(j,:),'descend','MissingPlacement','last');
                    stunei(isnan(stunei))=[];
                    if(size(imv,2)<size(stunei,2))
                        si=size(imv,2);
                        imv=zscore(imv(1:si));
                        stunei=zscore(stunei(1:si));
                        nei.dis=[nei.dis sqrt(sum(imv(:,si)-stunei(:,si)).^2)];
                        nei.kn=[nei.kn j];
                    else
                        si=size(stunei,2);
                        imv=zscore(imv(1:si));
                        stunei=zscore(stunei(1:si));
                        nei.dis=[nei.dis sqrt(sum(imv(:,si)-stunei(:,si)).^2)];
                        nei.kn=[nei.kn j];
                    end
                end
            end
            [~,idx] = sort(nei.dis);
            if(k==1)
                imp=rs(nei.kn(idx(1:k)),:);
            else
                imp=nanmean(rs(nei.kn(idx(1:k)),:));
            end
            rs(i,isnan(rs(i,:)))=imp(:,isnan(rs(i,:)));  
            if i == targetIdx
                NN = rs(nei.kn(idx(1:k)),:);
            end
        end
    end
    if(sum(sum(isnan(rs)))>0)
        t=ones(size(rs)).*nanmean(rs);
        rs(isnan(rs))=t(isnan(rs));
    end
    ans = rs;

end