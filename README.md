There are two python programs here (`-h` for usage):

-`./align` aligns words.

-`./grade` computes alignment error rate.

The commands work in a pipeline. For instance:

   > ./align -t 0.9 -n 1000 | ./grade -n 5

The `data` directory contains a fragment of the Canadian Hansards,
aligned by Ulrich Germann:

-`hansards.e` is the English side.

-`hansards.f` is the French side.

-`hansards.a` is the alignment of the first 37 sentences. The 
  notation i-j means the word as position i of the French is 
  aligned to the word at position j of the English. Notation 
  i?j means they are probably aligned. Positions are 0-indexed.
