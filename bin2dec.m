function n = bin2dec(binArray)

dim = length(binArray);
val = 2.^(0:(dim-1));

n = sum(binArray .* val);

end