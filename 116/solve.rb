#!/usr/bin/ruby

TILES=[1,2,3,4]

def tile_enum tileset, max_length
   return Enumerator.new do |t|
      TILES.each do |tile|
         continued = Array.new(tileset) + [tile]
         step_length = continued.reduce(:+)
         if step_length == max_length
            t.yield continued
         elsif step_length < max_length
            further_enum = tile_enum continued, max_length
            further_enum.each { |f|
               t.yield f
            }
         end
      end
   end
end

p tile_enum([], 50).count
