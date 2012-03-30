require 'Sql'

class Movie 
	attr_accessor :tpb_id 
	attr_accessor :xnxx_id
	def initialize(tpb_id, xnxx_id)
		@tpb_id = tpb_id
		@xnxx_id = xnxx_id
	end

	def is_not_working?
		begin
			html = Net::HTTP.get(URI.parse('http://video.xnxx.com/' + @xnxx_id));
			return (html =~ /Sorry, this video is not available./) || (html =~ /Sorry, this video is no longer available./);
		rescue Exception => e
			puts 'exception happened';
		end
	end

	def remove_from_tpb()
		sql = Sql.new
		sql.exec("DELETE FROM jos_content WHERE id=" + tpb_id.to_s);
		sql.exec("DELETE FROM jos_content_frontpage WHERE content_id=" + tpb_id.to_s);

	end
end
