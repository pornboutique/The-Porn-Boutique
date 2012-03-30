require 'net/http'
require 'net/https'
require 'open-uri'
require 'movie'
require 'movie_parser'
require 'rubygems'
require 'active_record'


start_index = ARGV[0] || 1000;
end_index = ARGV[1] || 1020;


movies = Movie_parser.get_movies(start_index, end_index);

remove_count = 0;
movies.each do |m|
	puts "examining (#{m.tpb_id} #{m.xnxx_id})"
	if (m.is_not_working?)
		puts "\tRemoving it";
		m.remove_from_tpb;
		remove_count += 1 ;
	else
		puts "\tIts cool"
	end
end

puts "removed #{remove_count} videos"

