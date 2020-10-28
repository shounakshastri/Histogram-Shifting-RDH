clc;
clear all;
close all;

%-----Import the reciever side data-----%
load('Histogram_Shifting_Embedding.mat');

s = s(:);
b_recovered = [];
count = 1;
if P > Z
    for ii =  1:length(s)    
        if s(ii) > Z && s(ii) <= P
            if s(ii) == P
                b_recovered(count) = 1;
                count = count + 1;
            elseif s(ii) == P - 1
                s(ii) = s(ii) + 1;
                b_recovered(count) = 0;
                count = count + 1;
            else
                s(ii) = s(ii) + 1;
            end
        end
        if count > length(b)
            break
        end
    end
elseif P < Z
    for ii =  1:length(s)    
        if s(ii) < Z && s(ii) >= P
            if s(ii) == P
                b_recovered(count) = 1;
                count = count + 1;
            elseif s(ii) == P + 1
                s(ii) = s(ii) - 1;
                b_recovered(count) = 0;
                count = count + 1;
            else
                s(ii) = s(ii) - 1;
            end
        end
        if count > length(b)
            break
        end
    end
end

isequal(b, b_recovered)