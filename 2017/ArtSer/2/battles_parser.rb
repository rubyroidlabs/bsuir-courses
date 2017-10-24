require_relative 'battler'
+class BattlesParser
+  BATTLERS_NAMES_IDENTIFIER = 'header_with_cover_art-primary_info-title'.freeze
+  ROUND_IDENTIFIER = 'lyrics'.freeze
+
+  def initialize
+    @first_battler = nil
+    @second_battler = nil
+  end
+
+  def parser(links_to_battles, search_criteria, required_battler)
     unless check_name_on_page?(links_to_battles, required_battler)
+      return
+    end
+    links_to_battles.each do |link|
+      battle = link.click
+      unless check_name_on_page?(link, required_battler)
+        next
+      end
+      memory_allocation_for_battlers
+      battle_rounds = text_division battle
+      unless set_battlers_names? battle, required_battler
+        next
+      end
+      rounds_analysis battle_rounds, search_criteria
+      set_winner
+      get_battle_info link
+    end
+  end
+
+  def check_name_on_page?(link, required_battler)
+    if !link.to_s.downcase.include? required_battler.name.downcase
+      false
+    else
+      true
+    end
+  end
+
+  def memory_allocation_for_battlers
+    @first_battler = Battler.new
+    @second_battler = Battler.new
+  end
+
+  def text_division(battle)
+    battle_rounds = battle.search(".#{ROUND_IDENTIFIER}")
+    battle_rounds = battle_rounds.text.split /Round [0-9]: /
+    battle_rounds.delete_at 0
+    battle_rounds
+  end
+
+  def set_battlers_names?(battle, required_battler)
+    battlers_names = battle.search(".#{BATTLERS_NAMES_IDENTIFIER}")
+    battlers_names = battlers_names.text.split(/vs/i)
+
+    unless battlers_names[1]
+      return false
+    end
+
+    battlers_names[0].slice!(0, battlers_names[0].index(/\w/))
+    battlers_names[0].slice!(0, battlers_names[0].reverse!.index(/\w/))
+    battlers_names[0].reverse!
+    battlers_names[1].slice!(0, battlers_names[1].index(/\w/))
+    battlers_names[1].slice! /([\(\[]Title Match[\)\]])/i
+    battlers_names[1].slice!(0, battlers_names[1].reverse!.index(/[\w\]\)]/))
+    battlers_names[1].reverse!
+
+    @first_battler.name = battlers_names[0]
+    @second_battler.name = battlers_names[1]
+
+    unless required_battler.name.empty?
+      required_battler.points = 0
+      req_name = required_battler.name
+      first_name = @first_battler.name
+      if req_name =~ /(#{first_name})/i || first_name =~ /(#{req_name})/i
+        required_battler.name = @first_battler.name
+        @first_battler = required_battler
+        @second_battler.name = battlers_names[1]
+      else
+        required_battler.name = @second_battler.name
+        @second_battler = required_battler
+        @first_battler.name = battlers_names[0]
+      end
+    end
+    true
+  end
+
+  def rounds_analysis(battle_rounds, search_criteria)
+    battle_rounds.each do |round|
+      name = round.slice!(0, round.index("\n"))
+      name.slice!(0, name.index(/\w/))
+      name.delete!('[]')
+      if search_criteria
+        round = round.downcase.scan /(#{search_criteria})/i
+      else
+        round.gsub!(/\W/, '')
+      end
+      second_name = @second_battler.name
+      first_name = @first_battler.name
+      if first_name =~ /(#{name})/i || name =~ /(#{first_name})/i
+        @first_battler.points += round.size
+      elsif second_name =~ /(#{name})/i || name =~ /(#{second_name})/i
+        @second_battler.points += round.size
+      end
+    end
+  end
+
+  def set_winner
+    if @first_battler.points > @second_battler.points
+      @first_battler.count_of_wins += 1
+      @second_battler.count_of_defeat += 1
+    elsif @second_battler.points > @first_battler.points
+      @second_battler.count_of_wins += 1
+      @first_battler.count_of_defeat += 1
+    end
+  end
+
+  def get_battle_info(link)
+    puts "\n\n"
+    p '===================================='
+    p "Adress: #{link.uri}"
+    p "Name: #{@first_battler.name}, Points: #{@first_battler.points}"
+    p "Name: #{@second_battler.name}, Points: #{@second_battler.points}"
+    if @first_battler.points > @second_battler.points
+      p "Winner: #{@first_battler.name}"
+    else
+      p "Winner: #{@second_battler.name}"
+    end
+    p '====================================='
+    true
+  end
+end