#!/usr/bin/ruby
puts 'Problem 122'

INIT = [1]

#N=15
N=200

MAX_CHAIN_LEN=16

def init_mins
   $mins = {}
   (1..N).each do |n|
      $mins[n] = n - 1
   end
end

def next_from_seen seen
   return Enumerator.new do |e|
      len = seen.length
      (0...len).each do |i|   
         (i...len).each do |j|
            k = seen[i] + seen[j]
            next if seen.include? k
            next if k > N
            next_chain = seen + [k]
            e.yield next_chain
         end
      end
   end
end

init_mins()

$last_chains = [INIT]
(1..MAX_CHAIN_LEN).each { |count|
   next_chains = []
   $last_chains.each { |prev_chain|
      next_seen = next_from_seen(prev_chain).to_a
      next_seen.each { |chain|
         if $mins[chain.last] >= count
            $mins[chain.last] = count
            next_chains.push chain
         end
      }
   }
   $last_chains = next_chains.uniq
}

pp $mins
puts $mins.values.reduce(:+)
