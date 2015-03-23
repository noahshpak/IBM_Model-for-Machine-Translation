
class IBMModel1
  attr_accessor :english_s, :french_s, :en_fr_pairs, :t, :total, :count, :word_list_en, :word_list_fr
  def initialize(english, french)
    @english_s = []
    @french_s = []
    @en_fr_pairs = {}

    @t = {}
    @total = Hash.new(0)
    @count = Hash.new(0)
    @word_list_en = {}
    @word_list_fr = {}

    line_num = 0
    File.open(english).each.zip(File.open(french)).each do |en_line, fr_line|
      print "#{line_num += 1} "
      @english_s << (en_line.split(' ') << '') 
      @french_s << fr_line.split(' ')

      @english_s[-1].each do |en_word|
        @en_fr_pairs.store(en_word, {}) unless @en_fr_pairs.has_key? en_word
        @french_s[-1].each do |fr_word|
          @en_fr_pairs[en_word][fr_word] #store possible en-ge pair into en_ge_pairs. let the value is true to improve compute speed.
#          if @en_fr_pairs[en_word].has_key? fr_word
#            @en_fr_pairs[en_word][fr_word] += 1
#          else
#            @en_fr_pairs[en_word].store fr_word, 1
#          end
        end
      end
    end

    @en_fr_pairs.each do |en_word, fr_words|
      @t[en_word] = Hash.new(0.0)
      fr_words.each do |fr_word, count|
        @t[en_word][fr_word] = 1.0 / @en_fr_pairs[en_word].size     # considered NULL
        @word_list_en[en_word] = true
        @word_list_fr[fr_word] = true
      end
    end
    puts "Data Loaded!"
  end
#my implementation of the EM Algorithm
  def em_algorithm
    raise "Corpus isn't Parallel (Different Sizes) " if @english_s.size != @french_s.size
    @english_s.each_with_index do |eng_sentence, i|
      @french_s[i].each do |fr_word|
        s_total = eng_sentence.inject(0.0) {|s_total, item| s_total += @t[item][fr_word].to_f}
        eng_sentence.each do |en_word|
          temp = @t[en_word][fr_word] / s_total
          #get counts
          @count[en_word + "|" + fr_word] += temp
          @total[en_word] += temp
        end
      end
    end

    # estimate probabilities
    @t.each do |en_word, fr_words|
      fr_words.each_key do |fr_word|
        @t[en_word][fr_word] = @count[en_word + "|" + fr_word] / @total[en_word]
      end
    end
  end

  def getNbest en_word, n
    nbest = {}

    if @en_fr_pairs.has_key? en_word then
      @en_fr_pairs[en_word].each_key do |fr_word|
        nbest.store fr_word, @t[en_word][fr_word]
      end
      nbest.sort_by{|k, v| -v}.first(n)   #sort from large to small by value
    else
      nbest
    end
  end

  def get_word_translate dev_word_file, n, iter
    (0..iter-1).each {|index| em_algorithm; puts "EM iteration #{index} done!"}

    File.read(dev_word_file).each_line do |word|
      puts word.chomp
      puts "#{(getNbest word.chomp, n).inspect}"
    end
  end

  def get_align sentence_num
    (0..sentence_num-1).each do |index|
      en_sentence = @english_s[index]
      fr_sentence = @french_s[index]
      en_sentence.each do |word|
        print "#{word} "
      end
      print "\n"
      fr_sentence.each do |word|
        print "#{word} "
      end
      print "\n"
      pred_a = []

      fr_sentence.each_with_index do |fr_word, f_index|
        maxProb = -1
        max_index = 0
        #grab best match
        en_setence.each_with_index do |en_word, index|
          if @t[en_word][fr_word] > maxProb
            maxProb = @t[en_word][fr_word]
            max_index = index
          end
        end
        pred_a << max_index
        puts "[#{fr_word}, #{en_sentence[max_index]}](#{f_index} <--> #{max_index}):\t#{maxProb}" #sure set
      end
      p pred_a
      puts ""
    end
  end
end

ibmmodel1 = IBMModel1.new(ARGV[0], ARGV[1])
ibmmodel1.get_word_translate ARGV[2], ARGV[3].to_i, ARGV[4].to_i
ibmmodel1.get_align ARGV[5].to_i
