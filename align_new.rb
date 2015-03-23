class Word
	def initialize(str)
		@word = str
		puts "added #{str}"
	end
	def to_str()
		@word
	end

end


class Sentence_E 
	def initialize(english_words)
		@words = english_words
		#array of arrays of combinations of words length 2
		@english_doubles = english_words.combination(2).to_a
		#array of arrays of combinations of words length 3
		@english_trips =  english_words.combination(3).to_a
	end

	def singles()
		singles = []
		@words.each do |w|
			singles.push(w.to_str())
		end
		singles		
	end
	def dubs()
		singles().combination(2).to_a
	end
	def trips()
		singles().combination(3).to_a
	end
	
end

class Sentence_F
	def initialize(french_words)
		@words = french_words
		#array of arrays of combinations of words length 2
		@french_doubles = french_words.combination(2).to_a
		#array of arrays of combinations of words length 3
		@french_trips =  french_words.combination(3).to_a

	end
	def singles()
		singles = []
		@words.each do |w|
			singles.push(w.to_str())
		end
		singles		
	end
	def dubs()
		singles().combination(2).to_a
	end
	def trips()
		singles().combination(3).to_a
	end

end

class Parallel_Corpus
	def initialize(ary_of_sentences_e, ary_of_sentences_f)
		@corpus = []
		ary_of_sentences_e.each_index do |x| 
			@corpus.push([ary_of_sentences_e[x], ary_of_sentences_f[x]])
		end
		
	end
	def display_corpus()
		p @corpus
	end
	def get_corpus()
		@corpus
	end
	def french_s_to_eng(sent_F_key)
		p @corpus.rassoc(sent_F_key)[0]
		@corpus.rassoc(sent_F_key)[0]
	end
	def english_s_to_fr(sent_E_key)
		p @corpus.assoc(sent_E_key)[1]
		@corpus.assoc(sent_E_key)[1]
	end
	#returns a list of french sentences that correspond to english sentences containing the input
	def list_of_assoc_french_s_with(contain_me)
		assoc_list = []
		@corpus.each do |pair|
			if pair[0].singles().include?(contain_me) || pair[0].dubs().include?(contain_me) || pair[0].trips().include?(contain_me)
				assoc_list.push(pair[1])
			end
		end
		#p assoc_list
	end
	def list_of_assoc_eng_s_with(contain_me)
		assoc_list = []
		@corpus.each do |pair|
			if pair[1].singles().include?(contain_me) || pair[1].dubs().include?(contain_me) || pair[1].trips().include?(contain_me)
				assoc_list.push(pair[0])
			end
		end
		#p assoc_list
	end

end

=begin
hey = Word.new("HEY")
hi = Word.new("Hi")
bonjour = Word.new("bonjour")
wi = Word.new("Wi")
S1E = Sentence_E.new([hey, hi])
S1F = Sentence_F.new([bonjour, wi])

p_c = Parallel_Corpus.new([S1E], [S1F])
p_c.list_of_assoc_eng_s_with("Wi")

#puts cor[0][0] == S1E
S1E.display_singles

=end

def get_data(english_file, french_file)
	en_f = File.open(english_file, "r")
	fr_f = File.open(french_file, "r")
	english_words = []
	french_words = []
	p "Loading Data...this could take a while"
	en_f.each_line do |line| 
		english_words.push(Sentence_E.new(line.split()))
		print "101"	
	end
	p "Done Loading Set 1"
	fr_f.each_line do |line|
		french_words.push(Sentence_F.new(line.split()))
	end
	p "Done Loading Set 2"
	en_f.close()
	fr_f.close()
end

get_data("Data/hansards.e", "Data/hansards.f")




