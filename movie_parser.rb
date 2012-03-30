require 'Sql'
require 'movie'

class Movie_parser
	def self.get_movies(start_index, end_index)
		sql = Sql.new
		result = sql.exec "SELECT `id`, `introtext` FROM jos_content WHERE `id`<=" + end_index.to_s + " AND `id`>=" + start_index.to_s
		return create_movies(result);
	end

	def self.create_movies(result)
		movies = []
		result.each do |r|
			movies << Movie.new(r["id"], r["introtext"].match(/video(\d)+/).to_s);
		end
		return movies;
	end

end