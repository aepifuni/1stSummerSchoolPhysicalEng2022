function [desc,inv1] = descMov2(path,tresh,i0,i1,j0,j1)
n=aviinfo(path);
df = aviopen(fullpath(path));
for l=1:n
    nframe=255-rgb2gray(avireadframe(df,l));
    m=double(im2bw(nframe, 1-tresh))
    M=0
    Mi=0
    Mj=0
    for i=i0:i1
        for j=j0:j1
         M = M + m(i,j)
         Mi = Mi + m(i,j)*i
         Mj = Mj + m(i,j)*j
        end
    end
            desc(l,:)=[round(Mi/M) round(Mj/M)]'
eta=zeros(4,4)
    for h=0:3
        for g=0:3 
            for i=i0:i1
                for j=j0:j1
                    eta(h+1,g+1)=eta(h+1,g+1)+ double(m(i,j))*((i-Mi/M)^h*(j-Mj/M)^g)/(M^((h+g)/2+1))
                end
            end
        end
    end
   inv1(l,:)=[eta(3,1)+eta(1,3) (eta(3,1)-eta(1,3))^2+4*eta(2,2)^2 (eta(4,1)-3*eta(2,3))^2+(3*eta(3,2)-eta(1,4))^2 (eta(4,1)+eta(2,3))^2+(eta(3,2)+eta(1,4))^2 (eta(4,1)-3*eta(2,3))*(eta(4,1)+eta(2,3))*((eta(4,1)+eta(2,3))^2-3*(eta(3,2)+eta(1,4))^2)+(3*eta(3,2)-eta(1,4))*(eta(3,2)+eta(1,4))*(3*(eta(4,1)+eta(2,3))^2-(eta(3,2)+eta(1,4))^2) (eta(3,1)-eta(1,3))*((eta(4,1)+eta(2,3))^2-(eta(3,2)+eta(1,4))^2+4*eta(2,2)*(eta(4,1)+eta(2,3))*(eta(3,2)+eta(1,4))) (3*eta(3,2)-eta(1,4))*(eta(4,1)+eta(2,3))*((eta(4,1)+eta(2,3))^2-3*(eta(3,2)+eta(1,4))^2)+(eta(4,1)-3*eta(2,3))*(eta(3,2)+eta(1,4))*(3*(eta(4,1)+eta(2,3))^2-(eta(3,2)+eta(1,4))^2)]';
end
endfunction
