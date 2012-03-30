require 'fileutils'

class PBImageUploader
          def initialize()
          end
          
          def upload_images()
            puts "image uploading: starting"
            ftp = connect_to_remote_folder()
            image_list = get_all_unuploaded_images()
            p image_list
            image_list.each do |image|
              puts 'uploading image ' + image.to_s 
              upload_to_remote_folder(image, ftp)
              copy_to_old_image_folder(image)
              delete_from_image_folder(image)
            end
            puts "image uploading: done"
          end
     
        def connect_to_remote_folder()
            ftp = Net::FTP.new('ftp.thepornboutique.com')
            ftp.login "maorus", "dR2KZPOA6Cq9"
            ftp.chdir('public_html/previews')
            ftp
        end
        
        def get_all_unuploaded_images()
          Dir["c://imagefolder/*.jpg"]
        end
        
        def upload_to_remote_folder(anImage, aFtp)
          aFtp.put anImage
        end
        
        def copy_to_old_image_folder(anImage)
          FileUtils.cp anImage, "C://imagefolder/oldimages"
        end
        
        def delete_from_image_folder(anImage)
          FileUtils.remove anImage
          
        end
end



