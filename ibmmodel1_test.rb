

class IBMModel1
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
        #puts "[#{ge_word}, #{en_setence[max_index]}](#{g_index} <--> #{max_index}):\t#{maxProb}"
      end
      p pred_a
      puts ""
    end
  end
end

ibmmodel1 = IBMModel1.new(ARGV[0], ARGV[1])
ibmmodel1.get_word_translate ARGV[2], ARGV[3].to_i, ARGV[4].to_i
ibmmodel1.get_align ARGV[5].to_i