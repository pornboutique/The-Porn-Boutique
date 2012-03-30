require 'fileutils'
require 'Sql'
class CSVFileHandler 
        def initialize() 
          @sql = Sql.new
        end
        
        def upload_csv()
          puts "uploading csv data file: starting"
          
          @sql.exec "LOAD DATA LOCAL INFILE 'c:/content.csv' INTO TABLE jos_content
                    FIELDS TERMINATED BY ';'
                    ENCLOSED BY '\"'
                    LINES TERMINATED BY '\n';"    
         
         
          @sql.exec "LOAD DATA LOCAL INFILE 'c:/frontpage.csv' INTO TABLE jos_content_frontpage
                    FIELDS TERMINATED BY ';'
                    ENCLOSED BY '\"'
                    LINES TERMINATED BY '\n' ;"    
          
          maxid = @sql.exec("Select max(id) FROM jos_content")[0]["max(id)"].to_s;
          puts "ordering new content with max id " + maxid
          @sql.exec "UPDATE `jos_content` SET `ordering`=" +  maxid +"- `id` "         
          
          puts "uploading csv data file: done"
        end
        
        def delete_csv()
          puts "deleting csv files: starting"
          
          FileUtils.remove 'c:/content.csv'
          FileUtils.remove 'c:/frontpage.csv'  
          
          
          puts "deleting csv files: done"
        end
end