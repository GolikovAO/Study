## Шаблон для выполнения заданий Лабораторной работы №6
## ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
## НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
## решения заданий должны быть вписаны в отведенные для этого позиции
 
################################################################################
# Задание 1
# add b
################################################################################
class Array
  def add b
    temp = (self.clone.zip b).map { |i| i.reduce(:+) }
  end
end
# конец описания задания 1
################################################################################
 
################################################################################
# Задания 2-6
# Класс Field
################################################################################
class Field
  FieldSize = 10
  def initialize
    @field = Array.new(FieldSize) { Array.new(FieldSize) }
  end
  # Задание 3 size (метод класса)
  def self.size
    FieldSize
  end
  # Задание 4 set!(n, x, y, hor, ship)
  def set!(n, x, y, hor, ship = nil)
    while n > 0
      hor ? @field[x + n - 1][y] = ship : @field[x][y + n - 1] = ship
      n -= 1
    end
  end
  # Задание 5 print_field
  def print_field
    print "+"; FieldSize.times {print "-"}; print "+\n"
    @field.each do |i|
      print "|"
      i.each do |j|
        if j then print j.to_s else print " " end
      end
      print "|\n"
    end
    print "+"; FieldSize.times {print "-"}; print "+\n"
  end
  # Задание 6 free_space?(n, x, y, hor, ship)
  def free_space?(n, x, y, hor, ship = nil)
    f = (hor && y.between?(0, FieldSize - 1) && x.between?(0, FieldSize - n)) ||
        (!hor && x.between?(0, FieldSize - 1) && y.between?(0, FieldSize - n))
    if f
      temp = []
      hor ? (cord1 = x; cord2 = y) : (cord1 = y; cord2 = x)
      t = cord1 - 1 > 0 ? cord1 - 1 : 0
      while t <= cord1 + n && t < FieldSize
        t2 =  
        t2 = cord2 - 1 > 0 ? cord2 - 1 : 0
        while t2 <= cord2 + 1 && t2 < FieldSize
          hor ? temp.push(@field[t][t2]) : temp.push(@field[t2][t])
          t2 += 1
        end
        t += 1
      end
      f = temp.all? {|x| x == nil or x == ship}
    end
    f
  end
end
# конец описания класса Field
################################################################################
 
 
################################################################################
# Задания 7-16
# Класс Ship
################################################################################
class Ship
  attr_reader :len, :coord
  def initialize(field, len)
    @len = len
    @myfield = field
    @maxhealth = @len * 100
    @minhealth = @len * 30
    @health = @len * 100
    @coord = nil
    @hor = nil
  end
  # Задание 8 to_s
  def to_s
    "X"
  end
  # Задание 9 clear
  def clear
    @myfield.set!(@len, @coord[0], @coord[1], @hor)
  end
  # Задание 10 set!(x, y, hor)
  def set!(x, y, hor)
    t = @myfield.free_space?(@len, x, y, hor, self)
    if t
      if @coord then clear end
      @myfield.set!(@len, x, y, hor, self)
      hor ? @coord = [x, y, x + @len - 1, y] : @coord = [x, y, x, y + @len - 1]
      @hor = hor
    end
    t
  end
  # Задание 11 kill
  def kill
    clear
    @coord = nil
  end
 
  # Задание 12 explode
  def explode
    @health -= 70
    if @health <= @minhealth
      kill
      @len
    else
      nil
    end
  end
 
  # Задание 13 cure
  def cure
    @health + 30 < @maxhealth ? @health += 30 : @maxhealth
  end
 
  # Задание 14 health
  def health
    (@health.to_f / @maxhealth * 100).round(2)
  end
  # Задание 15 move(forward)
  def move(forward)
    d = forward ? 1 : -1
    if @hor
      set!(@coord[0] + d, @coord[1], @hor)
    else
      set!(@coord[0], @coord[1] + d, @hor)
    end
  end
  # Задание 16 rotate(n, k)
  def rotate(n, k)
    t = k.between?(1, 3) && n.between?(1, @len)
    x = @coord[0]
    y = @coord[1]
    hor = true
    if t
      if @hor
        if k == 1 then x1 = x + n - 1; y1 = y - n + 1; hor = false end
        if k == 2 then x1 = x + 2 * n - @len - 1; y1 = y end
        if k == 3 then x1 = x + n - 1; y1 = y + n - @len; hor = false end
      else
        if k == 1 then x1 = x + n - @len; y1 = y + n - 1 end
        if k == 2 then x1 = x; y1 = y + 2 * n - @len - 1; hor = false end
        if k == 3 then x1 = x - n + 1; y1 = y + n - 1 end
      end
      t = set!(x1, y1, hor)
    end
    t
  end
end
# конец описания класса Ship
################################################################################
 
################################################################################
# Задания 17-25
# Класс BattleField
################################################################################
class BattleField < Field
  Ships = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
  def initialize
    super
    @allships = nil
    newships
  end
  def newships
    @allships = Ships.map { |i| Ship.new(self, i) }
  end
  # Задание 18 fleet
  def fleet
    @allships.each_with_index.map { |x, i| [i, x.len] }
  end
  # Задание 19 place_fleet pos_list
  def place_fleet pos_list
    t = true
    pos_list.each { |i| t = t && @allships[i[0]].set!(i[1], i[2], i[3]) }
    if t
      @allships.each { |i| if !i.coord then t = false end }
    end
    if !t
      @allships.each { |i| if i.coord then i.kill end }
    end
    t
  end
 
  # Задание 20 remains
  def remains
    @allships.each_with_index.map{ |x, i| [i, x.coord, x.len, x.health] }
  end
  # Задание 21 refresh
  def refresh
    @allships = @field.reduce(:|).find_all { |x| x }
  end
  # Задание 22 shoot c
  def shoot c
    t = @field[c[0]][c[1]]
    if t
      n = t.explode
      if n
        refresh
        "killed " + n.to_s
      else
        "wounded"
      end
    else
      "miss"
    end
  end
  # Задание 23 cure
  def cure
    @allships.map { |i| i.cure }
  end
  # Задание 24 game_over?
  def game_over?
    @allships.empty?
  end
  # Задание 25 move l_move
  def move l_move
    temp = @allships[l_move[0]]
    if l_move[1].between?(1,3)
      temp.rotate(l_move[2], l_move[1])
    else
      l_move[2] == 1 ? temp.move(true) : temp.move(false)
    end
  end
end
# конец описания класса BattleField
################################################################################
 
 
################################################################################
# Задания 26-31
# Класс Player
################################################################################
class Player
  attr_reader :name
  attr_accessor :manual
 
  def initialize(name, manual = false)
    @name = name
    @manual = manual
    @lastsample = [1, 0]
    reset
  end
 
  def reset
    @allshots = []
    @lastshots = []
  end
  # Задание 27 random_point
  def random_point
    [rand(Field::FieldSize), rand(Field::FieldSize)]
  end
  # Задание 28 place_strategy ship_list
  def place_strategy ship_list
    temp = Field.new
    ans = []
    new_list = ship_list.sort { |x, y| y[1] <=> x[1] }
    new_list.each do |i|
      shp = Ship.new(temp, i[1])
      c = random_point
      h = [true, false].sample
      while !shp.set!(c[0], c[1], h)
        c = random_point
        h = [true, false].sample
      end
      ans.push([i[0], c[0], c[1], h])
    end
    ans
  end
  # Задание 29 hit message
  def hit message
    @lastshots.push([@shot, message])
  end
  #            miss
  def miss
    @lastshots.push([@shot, "miss"])
    @allshots.push(@lastshots)
    @lastshots = []
  end
 
  # Задание 30 shot_strategy
  def shot_strategy
    if @manual
      @lastshots.each {|x| print(x, "\n")}
      puts "Make a shot. To switch off the manual mode enter -1 for any coordinate"
      while true
        print "x = "; x = gets.to_i; print x
        print " y = "; y = gets.to_i; puts y
        shot = [x,y]
        if shot.all? {|a| a.between?(-1, Field.size - 1)}
          break
        else
          puts "Incorrect input"
        end
      end
      if shot.any? {|a| a == -1}
        @manual = false
        shot_strategy
      else
        @shot = shot
      end
    else
      # Здесь необходимо разместить решение задания 30
      last = @lastshots.size - 1
      if @lastshots.empty? || @lastshots[last][1] != "wounded"
        @shot = random_point
      else
        if @lastshots[last][1] == "wounded" &&
           (last == 0 ||
            @lastshots[last - 1][1] != "wounded")
          eps = [[-1, 0], [1, 0], [0, 1], [0, -1]]
          @lastsample = eps[rand(4)]
          @shot = @shot.add(@lastsample)
        else
          if @lastshots[last][1] == "wounded" &&
             @lastshots[last - 1][1] == "wounded"
            @shot = @shot.add(@lastsample)
          end
        end
        if !@shot[0].between?(0, Field::FieldSize - 1) ||
           !@shot[1].between?(0, Field::FieldSize - 1)
          @lastsample = [ -@lastsample[0], -@lastsample[1]]
          @shot = @lastshots[last][0].add(@lastsample)
        end
      end
      if @lastshots.any? { |i| i[0] == @shot }
        shot_strategy
      else
        @shot
      end
      # конец решения задания 30
    end
  end
 
  # Задание 31 ship_move_strategy remains
  def ship_move_strategy remains
    if @manual
      puts "Ship health"
      tmp_field = Field.new
      names = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a
      ship_hash = {}
      remains.each do |ship|
        name = names[ship[0]]
        x = ship[1][0]; y = ship[1][1]
        hor = (ship[1][1] == ship[1][3])
        ship_hash[name] = [ship[0], ship[2]]
        tmp_field.set!(ship[2], x, y, hor, name)
        print(name, " - ", ship[3], "%\n")
      end
      puts "Your ships"
      tmp_field.print_field
      puts "Make a move. To switch off the manual mode enter an incorrect ship name"
      while true
        print "Choose ship: ";
        name = gets.strip; puts name
        if !ship_hash[name] then break end
        move = 0
        begin
          print "Enter 0 to move, 1-3 to rotate: "
          move = gets.to_i; puts move
        end until move.between?(0,3)
        if move == 0
          print "1 - forward/any - backward): "; dir = gets.to_i
          puts dir
        else
          dir = 0
          begin
            print "Choose a center point: (1..#{ship_hash[name][1]}): "
            dir = gets.to_i; puts dir
          end until dir.between?(1,ship_hash[name][1])
        end
        break
      end
      if !ship_hash[name]
        @manual = false
        ship_move_strategy remains
      else
        [ship_hash[name][0], move, dir]
      end
    else
      # Здесь необходимо разместить решение задания 31
      ans = remains.sort { |x, y| x[3] <=> y[3] }
      [ans[0][0], rand(4), rand(ans[0][2]) + 1]
      # конец решения задания 31
    end
  end
 
end
# конец описания класса Player
################################################################################
 
################################################################################
# Задания 32-33
# Класс Game
################################################################################
class Game
  def initialize(player_1, player_2)
    @game_over = false
    @players = [[player_1, BattleField.new, 0], [player_2, BattleField.new, 0]]
    @players = @players.each { |i| reset i }
    @players = @players.shuffle
  end
 
  def reset p
    plr = p[0]
    fld = p[1]
    print plr.name + " game setup\n"
    plr.reset
    temp = fld.place_fleet(plr.place_strategy(fld.fleet))
    if temp
      print "Ships placed\n"
    else
      raise "Illegal ship placement"
    end
  end
  # Задание 33 start
  def start
    lastshots = []
    while !@game_over
      plr = @players[0][0]
      fld = @players[0][1]
      @players[0][2] += 1
      cnt = @players[0][2]
      print "Step " + cnt.to_s + " of player " + plr.name + "\n"
      fld.cure
      r = plr.ship_move_strategy(fld.remains)
      fld.move r
      sht = plr.shot_strategy
      res = "miss"
      if lastshots.any? { |i| i[0] == sht }
        print "Illegal shot\n"
      else
        res = @players[1][1].shoot sht
      end
      lastshots.push sht
      print "[" + sht[0].to_s + "," + sht[1].to_s + "] " + res + "\n"
      if res == "miss"
        plr.miss
        @players = @players.reverse
        lastshots = []
      else
        plr.hit res
        @game_over = @players[1][1].game_over?
        if @game_over
          print "Player " + plr.name + " wins!\n"
        end
      end
    end
  end
end
# конец описания класса Game
################################################################################
 
################################################################################
# Переустановка датчика случайных чисел
################################################################################
srand
################################################################################
 
#№ Пример запуска
# p1 = Player.new("Ivan",true)
# p2 = Player.new("Feodor")
# g = Game.new(p1,p2)
# g.start