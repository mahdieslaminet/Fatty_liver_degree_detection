function out = MIRROR(in)
    
    [M, N] = size(in);
    img1 = zeros(M,N);
    img2 = zeros(M,N);
    
    for m = 1:M
        img1(m,:) = in(end-m+1,:);
    end
    
    for n = 1:N
        img2(n,:) = in(:,end-n+1);
    end
    
    for n = 1:N
        img3(n,:) = img1(:,end-n+1);
    end
    
    out(:,:,1) = img1;
    out(:,:,2) = img2;
    out(:,:,3) = img3;
    