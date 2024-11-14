class ImportControllerTest < ActionDispatch::IntegrationTest
  test "should import file with single row" do
    file_path = "#{Rails.root}/test/fixtures/files/test1.txt"
    composer_file = fixture_file_upload(file_path, "application/json")
    post "/import", params: { file: composer_file }
    assert_response 200
  end

  test "should import file with multiple row" do
    file_path = "#{Rails.root}/test/fixtures/files/test2.txt"
    composer_file = fixture_file_upload(file_path, "application/json")
    post "/import", params: { file: composer_file }
    assert_response 200
  end

  test "should import file with add child and  get relationship" do
    file_path = "#{Rails.root}/test/fixtures/files/test3.txt"
    composer_file = fixture_file_upload(file_path, "application/json")
    post "/import", params: { file: composer_file }
    assert_response 200
  end
end
