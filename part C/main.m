% encoding a string using LZW dictionary coding
% declaring the static dictionary
indices = 1:6;
strings = ["a", "b", "h", "i", "s", "t"];

% encoder dictionary (strings -> indices)
encoder_dict = dictionary(strings, indices);

% decoder dictionary (indices -> strings)
decoder_dict = dictionary(indices, strings);

% encoding the input string
fprintf("-------------------- LZW ENCODING --------------------\n")
string_to_encode = 'thisahatbsahahah';
[index_seq, ~] = lzw_encoding(string_to_encode, encoder_dict);

% decoding the generated index sequence
fprintf("\n\n-------------------- LZW DECODING --------------------\n")
[output, ~] = lzw_decoding(index_seq, decoder_dict);
