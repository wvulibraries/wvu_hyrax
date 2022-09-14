# app/jobs/import_job.rb

# Import Job
class ImportJob < ApplicationJob
  queue_as :default

  def perform(file)
    @hash = JSON.parse(File.read(file))
  
    # only import objects
    if @hash.present? && Item.where(id: @hash['ID']).count == 0
      # rename timestamps and convert format
      @hash['created_at'] = Time.at(@hash.delete('createTime').to_f) if @hash['createTime']
      @hash['updated_at'] = Time.at(@hash.delete('modifiedTime').to_f) if @hash['modifiedTime'] 
  
      # delete items
      @hash.delete('parentID')
      @hash.delete('defaultProject')
      @hash.delete('objectProject')
  
      # save old file info
      files_hash = { }    
      @hash['data'].each { |key, value| 
        if self.field_has_files?(value)
          if value['files'].is_a?(Hash)
            if value['files'].has_key?('archive')
              files_hash[key] = value
            end
          end
          @hash['data'].delete(key)
        end
      }
      
      array = @hash.keys
      array.each { |key| self.update_key(key) }
  
      # create items
      self.create_item(@hash)
      self.process_files(@hash['id'], files_hash) unless files_hash.empty?
    end  
  end  

  private

  # string contains files key that is not empty
  def field_has_files?(obj)
    begin
      obj.has_key?('files') && !obj['files'].blank?
    rescue
      false
    end
  end  
  
  def update_key(name)
    @hash[name.to_s.underscore] = @hash.delete(name)
  end   

  def create_item(hash_values)
    begin
      i = Item.new(hash_values)
      i = BasicWork.new(hash_values)
      i.record_timestamps=false
      i.save(validate: false)
    rescue StandardError => e
      # puts "Rescued: #{e.inspect}"
      # abort
      logger.error e.message
      logger.error e.backtrace.join("\n")      
    end
  end  

  def process_files(item_id, files_hash = nil)
    return if files_hash.nil? || files_hash.empty?
    item = Item.find(item_id)
    files_hash.each { |field_name, file_field| 
      # insure any old data is cleared from the
      # original mfcs. We will be recreating in 
      # the new system
      item[:data][field_name] = []
      item.save

      file_field['files']['archive'].each do |file|
        puts "Processing: #{file['name']}"

        self.process_file(item_id, field_name, file)
      end
    }
  end
  
  def process_file(item_id, field_name, file)
    # get original_filename
    original_filename = file['name']

    puts "Creating Archive and Working Copies for: "
    puts "File Name: #{original_filename}"
    puts "Item Id: #{item_id}"
    puts "Field Name: #{field_name}"

    # file_path is temporarly using backup copy
    # for some files so they are not in the correct 
    # location
    file_path = self.find_file(file['path'], original_filename)

    if file_path != nil && File.exist?(file_path)
      # get Item
      item = Item.find(item_id)

      # copy file for archive and working copies
      self.copy_file(file_path, item.archival_path, original_filename)

      # full path to the file
      archive_file_path = item.archival_path.join(original_filename) 

      hash_values = {
        item_id: item.id,
        form_id: item.form_id, 
        media_type: :archive, 
        filename: original_filename, 
        path: archive_file_path,
        fieldname: field_name
      }

      # creates archive media object in database
      archive_media = Media.new(hash_values)
      archive_media.save          

      # add archive media to item
      item[:data][field_name] << archive_media

      # set soft delete to false
      item.soft_delete = false

      # save updated item
      item.record_timestamps=false
      item.save

      WorkingFileJob.perform_later(archive_media.id)      
    end
  end
  
  def copy_file(from_path, to_path, filename)
    # create the path if it doesn't exist 
    FileUtils.mkdir_p(to_path) unless File.directory?(to_path)
  
    # creates the saved file
    file_path = to_path.join(filename) 
  
    # only copy the original archive file
    FileUtils.cp from_path, file_path  
  end 
  
  # method is used to find the file in the backup copy
  # temporarly using the backup copy for testing
  # will be removed later
  def find_file(file_path, original_filename)
    if File.exist?('importing/objects/' + file_path + '/' + original_filename)
      path = 'importing/objects/' + file_path + '/' + original_filename      
    # don't have all the files yet, so using the backup copy
    # for testing
    elsif File.exist?('importing/folklife_1605711112/archive/' + original_filename)
      path = 'importing/folklife_1605711112/archive/' + original_filename
    else
      path = nil
    end
    return path
  end  
end
