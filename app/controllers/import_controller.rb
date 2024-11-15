class ImportController < ApplicationController
  skip_before_action :verify_authenticity_token

  def import_txt
    unless params[:file].present?
      render json: { error: "File not provided" }, status: :unprocessable_entity and return
    end

    file = params[:file]

    # Ensure the file has a .txt extension
    unless File.extname(file.original_filename) == ".txt"
      render json: { error: "File type must be .txt" }, status: :unprocessable_entity and return
    end

    # Open the file and process each line
    begin
      file_data = file.read
      data_rows = file_data.split("\n")
      output = []
      for line in data_rows do
        data = line.split(/\s+/)

        if data[0] === "ADD_CHILD"
          mother = Member.find_by(name: data[1])
          child = Member.create! member(data[2], data[3])
          Relationship.create! mother_child_relationship(mother, child)
          output << "CHILD_ADDED"
        end

        if data[0] === "GET_RELATIONSHIP"
            member = Member.find_by(name: data[1])
            relationships = find_relationships(member, data[2]) if member.presence
            relationships.each { |r| output << r.name } if relationships.presence
        end
      end
      render json: output, status: :ok and return
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def find_relationships(member, type)
    case type
    when "Parents"
      member.parents
    when "Spouses"
      member.spouses
    when "Siblings"
      member.siblings
    when "Cousins"
      member.cousins
    when "Sisters_In_Law"
      member.sisters_in_law
    when "Brothers_In_Law"
      member.brothers_in_law
    when "GrandParents"
      member.grandparents
    end
  end

  def member(name, gender)
    {
      name: name,
      gender: gender.downcase,
      birth_date: Time.now - 20.years,
      death_date: nil,
      family_id: Family.last.id
    }
  end

  def mother_child_relationship(mother, child)
    {
      member1_id: child.id,
      member2_id: mother.id,
      types: Relationship.types[:child]
    }
  end
end
