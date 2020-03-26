function globalThreshold
    clear; clc;
    % Global Threshold Segmentation
    global H Index;
    B=imread('world.png');

    V=reshape(B,[],1);
    G=hist(V,0:255);
    H=reshape(G,[],1);

    Ind=0:255;
    Index=reshape(Ind,[],1);
    result=zeros(size([1 256]));

    for i=0:255
        % Custom calculate function defined below
        [wbk,varbk]=calculate(1,i);
        [wfg,varfg]=calculate(i+1,255);
        result(i+1)=(wbk*varbk)+(wfg*varfg);
    end

    [~,val]=min(result);
    tval=(val-1)/256;

    bin_im=im2bw(B,tval);
    figure, imshow(bin_im);

    function [weight,var]=calculate(m,n)
        %Weight Calculation
        weight=sum(H(m:n))/sum(H);

        %Mean Calculation
        value=H(m:n).*Index(m:n);
        total=sum(value);
        mean=total/sum(H(m:n));

        if(isnan(mean))
            mean=0;
        end

        %Variance calculation.
        value2=(Index(m:n)-mean).^2;
        numer=sum(value2.*H(m:n));
        var=numer/sum(H(m:n));

        if(isnan(var))
            var=0;
        end
    end
end