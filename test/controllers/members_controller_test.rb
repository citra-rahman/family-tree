require "test_helper"

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
  end

  test "should get index" do
    get members_url
    assert_response :success
  end

  test "should get new" do
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    assert_difference("Member.count") do
      post members_url, params: { member: { birth_date: @member.birth_date, death_date: @member.death_date, family_id: @member.family_id, gender: @member.gender, name: "member 3" } }
    end

    assert_redirected_to member_url(Member.last)
  end

  test "should show member" do
    get member_url(@member)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_url(@member)
    assert_response :success
  end

  test "should update member" do
    patch member_url(@member), params: { member: { birth_date: @member.birth_date, death_date: nil, family_id: @member.family_id, gender: @member.gender, name: @member.name } }
    assert_redirected_to member_url(@member)
  end
end
