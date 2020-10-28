clc;
clear all;
close all;

%-----Import the Cover Image-----%
I = imread('lena2.tif');

if ndims(I) > 2
    I = rgb2gray(I);
end

[m, n] = size(I);

b = [];

%-----Histogram Processing-----% 
[counts, binLoc] = imhist(I);
P = binLoc(counts == max(counts));
Zeros = binLoc(counts == 0);
diff = abs(Zeros - P);
Z = Zeros(diff == min(diff));

%-----Secret Data Embedding-----%
I = I(:);
count = 1;
s = I;

if P > Z
    for ii =  1:length(I)    
        if I(ii) > Z && I(ii) <= P
            if I(ii) == P
                b(count) = randi([0, 1]);
                s(ii) = s(ii) - 1 + b(count);
                count = count + 1;
            else
                s(ii) = s(ii) - 1;
            end
         end
%         if count > length(b) % Uncomment if length of b is known 
%             break
%         end
    end
elseif P < Z
    for ii =  1:length(I)    
        if I(ii) >= P && I(ii) < Z
            if I(ii) == P
                b(count) = randi([0, 1]);
                s(ii) = s(ii) + 1 - b(count);
                count = count + 1;
            else
                s(ii) = s(ii) + 1;
            end
        end
%         if count > length(b) % Uncomment if length of b is known            
%             break
%         end
    end
end

s = reshape(s, m, n);

subplot(1, 2, 1);
imhist(I);
title("Cover Image Histogram");

subplot(1, 2, 2);
imhist(s);
title('Stego Image Histogram');

save('Histogram_Shifting_Embedding', 's', 'b', 'P', 'Z');