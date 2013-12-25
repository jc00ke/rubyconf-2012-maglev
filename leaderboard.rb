require 'set'
begin
  require 'rubygems'
  require 'pry'
rescue LoadError
  # nothing
end

class Leaderboard
  attr_reader :players

  def initialize
    @players = SortedSet.new
  end

  def add_player(player)
    @players << player
  end

  def add_players(some_players)
    some_players.each do |p|
      add_player(p)
    end
  end

  alias << add_player

  def inc_player_by(player, points)
    player.inc_by points
    @players << player
  end

  def leaders
    @players.sort
  end

  def first_place
    leaders.first
  end

  def last_place
    leaders.last
  end

  def rank_of(leader)
    if rank = @players.find_index(leader)
      rank + 1
    else
      raise "#{leader.name} not found in #{self}"
    end
  end

  def report
    puts "*" * 80
    puts "first place: #{first_place.name}"
    puts "last place: #{last_place.name}"

    players.each do |x|
      puts "#{x.name}: #{x.score} - #{x.timestamp}"
    end
  end
end

class LeaderboardItem
  include Comparable

  attr_reader :name, :score, :timestamp

  def initialize(name, score=0)
    @name = name
    @score = score
    @timestamp = Time.now.to_f
  end

  def inc_by(x)
    @score += x.to_i
    @timestamp = Time.now.to_f
  end

  def <=>(other)
    return  1 if score < other.score
    return -1 if score > other.score

    return -1 if timestamp < other.timestamp
    return  1 if timestamp > other.timestamp

    0
  end
end

a = LeaderboardItem.new('Annie')
j = LeaderboardItem.new('Jesse')
n = LeaderboardItem.new('Nathan')
r = LeaderboardItem.new('Rebecca', 5)

s = Leaderboard.new
s.add_players([a, j, n, r])

s.report

s.inc_player_by(j, 10)
sleep 0.1
s.inc_player_by(a, 10)

s.report

s.inc_player_by(n, 12)
sleep 0.1
s.inc_player_by(n, 1)
s.inc_player_by(n, 1)

s.rank_of(j) == 2
s.rank_of(n) == 1

s.report
