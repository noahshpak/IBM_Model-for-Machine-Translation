class word
	def initialize(str)
		@word = str
		puts "added #{str}"
	end
end


class Sentence_E 
	def initialize(english_words)
		#array of arrays of len 1, each containing a word
		@english_singles = english_words.combination(1).to_a
		#array of arrays of combinations of words length 2
		@english_doubles = english_words.combination(2).to_a
		#array of arrays of combinations of words length 3
		@english_trips =  english_words.combination(3).to_a
	end
end

class Sentence_F
	def initialize(french_words)
		#array of arrays of len 1, each containing a word
		@french_singles = french_words.combination(1).to_a
		#array of arrays of combinations of words length 2
		@french_doubles = french_words.combination(2).to_a
		#array of arrays of combinations of words length 3
		@french_trips =  french_words.combination(3).to_a
	end
end

class Parallel_Corpus
	def initialize(ary_of_sentences_e, ary_of_sentences_f)
		@corpus_hash = Hash[ary_of_sentences_e.zip(ary_of_sentences_f)]
		p @corpus_hash
		# => {s1E => s1F, s2E => s2F,..., snE=>snF}
	end
	def display_hash()
		p @corpus_hash
	end
	def get_hash()
		@corpus_hash
	end

end


hey = Word.new("HEY")
hi = Word.new("Hi")
bonjour = Word.new("bonjour")
wi = Word.new("Wi")
S1E = Sentence_E.new([hey, hi])
S1F = Sentence_F.new([bonjour, wi])

p_c = Parallel_Corpus.new([S1E], [S1F])








