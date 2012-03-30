require "java"
require 'rubygems'
require 'active_record'
require 'pb_image_uploader'
require 'PornBug.jar'
require 'net/ftp'
require 'csv_file_handler'
require 'twitter_updater'

java_import "PornBug"

NumOfLinksToPost = 5

puts "Ass"


#PornBug::find_latest_links(0,50)
#PornBug::find_videos_through_tags(4531,4540)
#PornBug::shuffle_links


#=begin
PornBug::create_csv_file(NumOfLinksToPost)

piu = PBImageUploader.new
piu.upload_images
#=end

csv = CSVFileHandler.new
csv.upload_csv
#=end
t = TwitterUpdater.new
t.update

#csv.delete_csv 

puts 'done'
#=end