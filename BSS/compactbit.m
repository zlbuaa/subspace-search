function cb = compactbit(b)
%
% b = bits array
% cb = compacted string of bits (using 8-bit 'words')

[nbits, nSamples] = size(b);
nwords = ceil(nbits/8);
cb = zeros([nwords nSamples], 'uint8');

for j = 1:nbits
    w = ceil(j/8);
    cb(w,:) = bitset(cb(w,:), mod(j-1,8)+1, b(j,:));
end

end
