# app/jobs/add_file_to_item_job.rb

# Import Job
class AddFileToItemJob < ApplicationJob
    queue_as :ingest

    def perform(item_id, source, filename)
        # set golbal variables
        @folder = '/home/wvu_hyrax/imports'
        @source = source
        @filename = filename
        @item_id = item_id

        add_file_to_item
    end  
  
    private

    def add_file_to_item
        item = BasicWork.find(@item_id)
        user = User.where(email: item.depositor).first_or_create
        file = File.open("#{@folder}/#{@source}/export/bulkrax/files/#{@filename}")
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

end