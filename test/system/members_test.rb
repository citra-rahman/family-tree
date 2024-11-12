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
    fill_in "Family", with: @member.family_id
    fill_in "Gender", with: @member.gender
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
    fill_in "Family", with: @member.family_id
    fill_in "Gender", with: @member.gender
    fill_in "Name", with: @member.name
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end

  test "should destroy Member" do
    visit member_url(@member)
    click_on "Destroy this member", match: :first

    assert_text "Member was successfully destroyed"
  end
end