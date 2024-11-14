=begin
require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  setup do
    @relationship = relationships(:one)
  end

  test "visiting the index" do
    visit relationships_url
    assert_selector "h1", text: "Relationships"
  end

  test "should create relationship" do
    visit relationships_url
    click_on "New relationship"

    find_field("Member1").set(1)
    find_field("Member2").set(2)
    find_field("Types").set(@relationship.types)
    click_on "Create Relationship"

    assert_text "Relationship was successfully created"
    click_on "Back"
  end

  test "should update Relationship" do
    visit relationship_url(@relationship)
    click_on "Edit this relationship", match: :first

    find_field("Member1").set(@relationship.member1_id)
    find_field("Member2").set(@relationship.member2_id)
    find_field("Types").set(@relationship.types)
    click_on "Update Relationship"

    assert_text "Relationship was successfully updated"
    click_on "Back"
  end
end
=end
