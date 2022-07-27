# app/jobs/json_import_job.rb

# Json Import Job
class JsonImportJob < ApplicationJob
  queue_as :default

  def perform()
    t = BasicWork.new(id: '0000',
                      title: ['testing'], 
                      description: ['testing'], 
                      parents: ,
                      creator: ,
                      rights: ,
                      contributor: ,
                      publisher: ,
                      date_created: , 
                      subject: ,
                      language: ,
                      source: ,
                      resource_type: ,
                      institution: ,
                      place: ,
                      subtype: ,
                      extent: ,
                      depositor: `changeme@mail.wvu.edu`
                      )

    source_identifier,model,title,description,parents,creator,rights,contributor,publisher,date_created,subject,language,source,resource_type,institution,place,subtype,extent,file
    folklife,Collection,"WV Folklife Collection",
    
    item = BasicWork.new
    item.id = "4224RizettaSamAudioInt71916"
    item.model = BasicWork
    item.title = "Oral history of Sam Rizzetta"
    item.description = "Sam Rizzetta is a dulcimer designer, builder, and musician who moved to West Virginia in the early 1970s. He was a member of the string band Trapezoid and founded the hammer dulcimer playing classes at the Augusta Heritage Center at Davis & Elkins College. He has built dulcimers for musicians including John McCutcheon, Guy Carawan, and Sam Herrmann. Rizzetta now collaborates with the Dusty Strings Company who build hammer dulcimers based on his designs. He lives with his wife Carrie Rizzetta in Berkeley County, WV."
    folklife
    "Rizzetta, Sam"
    "In Copyright - Educational Use Permitted"
    "Hilliard, Emily"
    ,
    ,
    2016-07-19,
    "Augusta Heritage Center|||Davis and Elkins College|||Dulcimer|||Musical instruments|||Stringed instruments",
    English,
    "A&M 4224, West Virginia Folklife Program Collection",
    Sound,
    "West Virginia and Regional History Center",
    ,
    audio/wav,
    00:44:30,
    4224.RizettaSam.AudioInt.7.16.19.wav
    
  end
end
