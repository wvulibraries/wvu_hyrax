# app/jobs/add_file_to_item_job.rb

# to do
# if file isn't available in the export folder, check the data folder
# write the error to a log file
# do remove the BasicWork if the file isn't availble

# Import Job
class AddFileToItemJob < Hyrax::ApplicationJob
    queue_as :ingest

    def perform(item_id, source, filename)
        # set golbal variables
        @folder = '/home/hyrax/imports'
        @source = source
        @filename = filename
        @item_id = item_id

        add_file_to_item
    end  
  
    private

    def add_file_to_item
        item = BasicWork.find(@item_id)
        if item.present?
            # set the depositor
            user = User.where(email: item.depositor).first_or_create
            # set the file path
            file_full_path = "#{@folder}/#{@source}/export/bulkrax/files/#{@filename}"
            # verify file exists before adding
            if File.exists?(file_full_path)
                file = File.open(file_full_path)
                file_set = FileSet.new
                file_set.title = [@filename]
                file_set.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
                file_set.apply_depositor_metadata(item.depositor)
                file_set.save
                actor = Hyrax::Actors::FileSetActor.new(file_set, user)
                #actor.create_metadata(item)
                actor.create_content(file)
                actor.attach_to_work(item) 
            
                # create the checksum record
                Checksum.where(:fileset_id => actor.file_set.id).first_or_create(:ingest_date => Date.today, :ingest_week_no => Date.today.strftime("%U").to_i, :file_name => actor.file_set.label )
            end
            # throw error that file doesn't exist
            logger.info 'File does not exist ' + file_full_path + ' for item ' + @item_id
        end
        # throw error that item doesn't exist
        logger.info 'Item does not exist ' + @item_id
    end

end