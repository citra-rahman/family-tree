=begin
require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "should create member" do
    visit members_url
    click_on "New member"

    fill_in "Birth date", with: @member.birth_date
    fill_in "Death date", with: @member.death_date
    find_field("Family").set(@member.family.id)
    find_field("member[gender]", match: :first).set(true)
    fill_in "Name", with: @member.name
    click_on "Create Member"

    assert_text "Member was successfully created"
    click_on "Back"
  end

  test "should update Member" do
    visit member_url(@member)
    click_on "Edit this member", match: :first

    fill_in "Birth date", with: @member.birth_date.to_s
    fill_in "Death date", with: @member.death_date.to_s
    find_field("Family").set(@member.family.id)
    find_field("member[gender]", match: :first).set(true)
    fill_in "Name", with: @member.name
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end
end
=end
